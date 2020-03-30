import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:UQS/Models/user.dart';
import 'package:UQS/Services/userDatabase.dart';

class Profilepage extends StatefulWidget {
  @override
  _ProfilepageState createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    return StreamBuilder<User>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          final User data = snapshot.data;
          return Scaffold(
              backgroundColor: Colors.lightBlueAccent,
              appBar: AppBar(
                
                title: Text("Profile"),
                elevation: 0,
                backgroundColor: Colors.lightBlueAccent,
              ),
              body: Container(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 28.0, top: 7),
                              child: CircleAvatar(
                                radius: 50,
                                child: IconButton(
                                  onPressed: () => {},
                                  splashColor: Colors.white,
                                  icon: Icon(Icons.add_a_photo),
                                  tooltip: "Add photo",
                                  //dri ma part ang image//
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    data.name, // dri ang name default plang
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.email,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8.0,
                                          ),
                                          child: Text(
                                            data.email,
                                            style: TextStyle(
                                              color: Colors.white,
                                              wordSpacing: 2,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 20, left: 20, top: 15, bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Active ticket',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text('0',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      )),
                                ],
                              ),
                              Container(
                                color: Colors.white,
                                width: 0.2,
                                height: 22,
                              ),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.only(
                                            left: 100,
                                            right: 90,
                                            top: 50,
                                            bottom: 40),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(29)),
                                          color: Colors.white,
                                        ))
                                  ])
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 15,),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 33,
                                      right: 28,
                                      left: 28,
                                    ),
                                    child: Text(
                                      'information',
                                      style: TextStyle(
                                        color: Colors.lightBlueAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(2),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(
                                              Icons.person_outline,
                                              size: 30,
                                            ),
                                            title: Text(data.name),
                                            subtitle: Text("Name"),
                                            enabled: true,
                                            trailing: IconButton(
                                              onPressed: () {},
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
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(
                                              Icons.email,
                                              size: 30,
                                            ),
                                            title: Text(data.email),
                                            subtitle: Text("Email Address"),
                                            enabled: true,
                                            trailing: Icon(Icons.edit),
                                          )
                                        ]),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(
                                              Icons.phone_android,
                                              size: 30,
                                            ),
                                            title: Text("Contact number: "),
                                            subtitle: Text("Edit"),
                                            enabled: true,
                                            trailing: Icon(Icons.edit),
                                          )
                                        ]),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(
                                              Icons.email,
                                              size: 30,
                                            ),
                                            title: Text("Email address: "),
                                            subtitle: Text("Edit"),
                                            enabled: true,
                                            trailing: Icon(Icons.edit),
                                          )
                                        ]),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}
