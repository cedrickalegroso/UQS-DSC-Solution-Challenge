import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:UQS/Models/user.dart';
import 'package:UQS/Services/userDatabase.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  String _displayName;
  String _email;
  String _phoneNumber;
  String _photoUrl;
  bool _readOnly = false;
  @override
  Widget build(BuildContext context) {
    final User users = Provider.of<User>(context);
    return StreamBuilder<User>(
        stream: DatabaseService(uid: users.uid).userData,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          User user = snapshot.data;

          return Scaffold(
            body: Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Colors.white,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        readOnly: _readOnly,
                        //                        autofocus: false,
                        textAlign: TextAlign.left,
                        onChanged: (val) {
                          setState(() => _displayName = val.trim());
                        },
                        onSaved: (value) => _displayName = value.trim(),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hasFloatingPlaceholder: false,
                          hintText: users.name,
                          labelText: users.name,
                          contentPadding: EdgeInsets.all(6),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        readOnly: _readOnly,
                        autofocus: false,
                        textAlign: TextAlign.left,
                        onChanged: (val) {
                          setState(() => _email = val.trim());
                        },
                        onSaved: (value) => _email = value.trim(),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(6),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        readOnly: _readOnly,
                        autofocus: false,
                        textAlign: TextAlign.left,
                        onChanged: (val) {
                          setState(() => _phoneNumber = val.trim());
                        },
                        onSaved: (value) => _phoneNumber = value.trim(),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(6),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        readOnly: _readOnly,
                        autofocus: false,
                        textAlign: TextAlign.left,
                        onChanged: (val) {
                          setState(() => _photoUrl = val.trim());
                        },
                        onSaved: (value) => _photoUrl = value.trim(),
                        keyboardType: TextInputType.url,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(6),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 100, right: 100),
                      child: RaisedButton(
                        color: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          setState(() {
                            _readOnly = !_readOnly;
                          });
                        },
                        child: _readOnly
                            ? Text(
                                'Save',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Update',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 8)
                  ],
                ),
              ),
            ),
          );
        });
  }
}
