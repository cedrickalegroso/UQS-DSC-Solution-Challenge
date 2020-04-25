import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:UQS/Models/user.dart';
import 'package:UQS/Services/userDatabase.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:UQS/Miscellaneous/profileClipper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profilepage extends StatefulWidget {
  @override
  _ProfilepageState createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  final CollectionReference userCollection =
      Firestore.instance.collection('userCollection');

  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _editSnackbar(message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(fontSize: 15.0),
      ),
      action: SnackBarAction(label: 'Okay', onPressed: () => null),
      duration: new Duration(seconds: 5),
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  //creating an instance of the class AuthService
  final DatabaseService _user = DatabaseService();
  String _name = '';
  String _phoneNumber = '';

  bool _isEditedmode = false;

  File image;
  String _uploadedFileURL;

  Future editModeEnabled() async {
    setState(() {
      _isEditedmode = true;
    });
  }

  Future editModeDisabled() async {
    setState(() {
      _isEditedmode = false;
    });
  }

  Future logoutUser() async {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamed('/login');
  }

  Future chooseFile(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      image = selected;
    });
  }

  Future<void> cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
              ]
            : [
                CropAspectRatioPreset.square,
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));

    setState(() {
      image = cropped ?? image;
    });
  }

  Future<void> removeImage() async {
    setState(() {
      image = null;
    });
  }

  Future updateName(_name) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    String message = "Name changed to $_name";
    _editSnackbar(message);
    return userCollection.document(user.uid).updateData({'name': _name});
  }

  Future updatePhone(_phoneNumber) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    String message = "Phone changed to $_phoneNumber";
    _editSnackbar(message);
    return userCollection
        .document(user.uid)
        .updateData({'phonenumber': _phoneNumber});
  }

  Future uploadFile() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('profilepictures/user_${user.uid}');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
        String message = "Profile picture uploaded!";
        _editSnackbar(message);
      });
      return userCollection
          .document(user.uid)
          .updateData({'photoUrl': _uploadedFileURL});
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    final screenData = MediaQuery.of(context);

    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.white,
        body: _isEditedmode == true
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    FlatButton(
                        onPressed: editModeDisabled,
                        child: Text("Disable Edit Mode")),
                    Container(
                        height: screenData.size.height / 3,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/Pbackground.png'),
                                fit: BoxFit.cover)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                    top: 30,
                                    left: 25,
                                    right: 25,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      image != null
                                          ? ClipOval(
                                              clipper: ProfileClipper(),
                                              child: Image.file(
                                                image,
                                                width:
                                                    screenData.size.height / 6,
                                              ))
                                          : ClipOval(
                                              clipper: ProfileClipper(),
                                              child: CachedNetworkImage(
                                                imageUrl: user.photoUrl,
                                                width:
                                                    screenData.size.height / 6,
                                                placeholder: (context, url) =>
                                                    Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            )
                                    ],
                                  )),
                              SizedBox(height: 5.0),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    image != null
                                        ? Row(children: <Widget>[
                                            FlatButton(
                                                onPressed: cropImage,
                                                child: Text("Crop")),
                                            FlatButton(
                                                onPressed: removeImage,
                                                child: Text("Remove")),
                                            FlatButton(
                                                onPressed: uploadFile,
                                                child: Text("Upload")),
                                          ])
                                        : Row(children: <Widget>[
                                            FlatButton(
                                                onPressed: () => chooseFile(
                                                    ImageSource.camera),
                                                child: Text("Camera")),
                                            FlatButton(
                                                onPressed: () => chooseFile(
                                                    ImageSource.gallery),
                                                child: Text("Gallery")),
                                          ])
                                  ],
                                ),
                              ),
                            ])),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(2),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(
                                          Icons.person_outline,
                                          size: 30,
                                        ),
                                        title: Text(user.name),
                                        subtitle: Text("Name"),
                                        enabled: true,
                                        trailing: IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                      title: Text(
                                                        "Update name",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      content: Form(
                                                        key: _formKey,
                                                        child: TextFormField(
                                                            autofocus: false,
                                                            textAlign:
                                                                TextAlign.left,
                                                            validator: (value) =>
                                                                value.isEmpty
                                                                    ? 'Please enter complete name'
                                                                    : null,
                                                            onChanged: (val) {
                                                              setState(() =>
                                                                  _name = val);
                                                            },
                                                            onSaved: (value) =>
                                                                _name = value,
                                                            decoration: InputDecoration(
                                                                filled: true,
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    'Complete name',
                                                                labelText:
                                                                    "Name *",
                                                                hintStyle: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        400]))),
                                                      ),
                                                      actions: <Widget>[
                                                        FlatButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child:
                                                                Text("Cancel")),
                                                        FlatButton(
                                                            onPressed:
                                                                () async {
                                                              updateName(_name);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child:
                                                                Text("Update"))
                                                      ],
                                                      elevation: 24,
                                                    ));
                                          },
                                          splashColor: Colors.blueAccent,
                                          icon: Icon(Icons.edit),
                                        ),
                                      ),
                                    ]),
                              ),
                              Container(
                                margin: EdgeInsets.all(5),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(
                                          Icons.phone_android,
                                          size: 30,
                                        ),
                                        title: Text(user.phoneNumber),
                                        subtitle: Text("Phone Number"),
                                        enabled: true,
                                        trailing: IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                      title: Text(
                                                        "Update Phonenumber",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      content: Form(
                                                        key: _formKey,
                                                        child: TextFormField(
                                                            autofocus: false,
                                                            textAlign:
                                                                TextAlign.left,
                                                            validator: (value) =>
                                                                value.isEmpty
                                                                    ? 'Please enter a valid Phone number'
                                                                    : null,
                                                            onChanged: (val) {
                                                              setState(() =>
                                                                  _phoneNumber =
                                                                      val);
                                                            },
                                                            onSaved: (value) =>
                                                                _phoneNumber =
                                                                    value,
                                                            decoration: InputDecoration(
                                                                filled: true,
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    'Phone Number',
                                                                labelText:
                                                                    "Phone Number *",
                                                                hintStyle: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        400]))),
                                                      ),
                                                      actions: <Widget>[
                                                        FlatButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child:
                                                                Text("Cancel")),
                                                        FlatButton(
                                                            onPressed:
                                                                () async {
                                                              updatePhone(
                                                                  _phoneNumber);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child:
                                                                Text("Update"))
                                                      ],
                                                      elevation: 24,
                                                    ));
                                          },
                                          splashColor: Colors.blueAccent,
                                          icon: Icon(Icons.edit),
                                        ),
                                      )
                                    ]),
                              ),
                              Container(
                                margin: EdgeInsets.all(5),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(
                                          Icons.email,
                                          size: 30,
                                        ),
                                        title: Text(user.email),
                                        subtitle: Text("Email Address"),
                                        enabled: false,
                                      )
                                    ]),
                              ),
                            ],
                          )),
                    )
                  ])
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    Container(
                        height: screenData.size.height / 3,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/Pbackground.png'),
                                fit: BoxFit.cover)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                    top: 30,
                                    left: 25,
                                    right: 25,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ClipOval(
                                        clipper: ProfileClipper(),
                                        child: CachedNetworkImage(
                                          imageUrl: user.photoUrl,
                                          width: screenData.size.height / 6,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      )
                                    ],
                                  )),
                              SizedBox(height: 5.0),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(user.name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenData.size.height / 25,
                                          fontFamily: 'Calibre-Semibold',
                                        ))
                                  ],
                                ),
                              ),
                            ])),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(5),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(
                                          Icons.phone_android,
                                          size: 30,
                                        ),
                                        title: Text(user.phoneNumber),
                                        subtitle: Text("Phone Number"),
                                        enabled: true,
                                      )
                                    ]),
                              ),
                              Container(
                                margin: EdgeInsets.all(5),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(
                                          Icons.email,
                                          size: 30,
                                        ),
                                        title: Text(user.email),
                                        subtitle: Text("Email Address"),
                                        enabled: true,
                                      )
                                    ]),
                              ),
                              SizedBox(height: 20.0),
                              FlatButton(
                                onPressed: editModeEnabled,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 20.0, left: 20.0),
                                    child: Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          gradient: LinearGradient(colors: [
                                            Color.fromRGBO(16, 127, 246, 1),
                                            Color.fromRGBO(16, 127, 246, .6),
                                          ])),
                                      child: Center(
                                        child: Text("Edit Account",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    )),
                              ),
                              FlatButton(
                                onPressed: logoutUser,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 20.0, left: 20.0),
                                    child: Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          gradient: LinearGradient(colors: [
                                            Color.fromRGBO(171, 31, 21, 1),
                                            Color.fromRGBO(128, 18, 10, .6),
                                          ])),
                                      child: Center(
                                        child: Text("Log out",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    )),
                              ),
                            ],
                          )),
                    )
                  ]));
  }
}
