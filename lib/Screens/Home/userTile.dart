import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uqsbeta/Miscellaneous/loading.dart';
import 'package:uqsbeta/Models/user.dart';
import 'package:uqsbeta/Services/userDatabase.dart';

class UserTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return user != null
        ? StreamBuilder<User>(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                User userData = snapshot.data;
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: userData.photoUrl.isNotEmpty
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      NetworkImage('${userData.photoUrl}'),
                                  backgroundColor: Colors.transparent,
                                )
                              : Icon(
                                  Icons.add_photo_alternate,
                                  size: 50,
                                )),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    child: Text(
                                      '${userData.name}',
                                      softWrap: true,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    child: Text(
                                      '${userData.email}',
                                      softWrap: true,
                                      maxLines: 1,
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                );
              } else {
                return Container(child: Loading());
              }
            })
        : Container();
  }
}

/*class _UserPhoto extends StatelessWidget {
  final User user;
  _UserPhoto({this.user});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage('${user.photoUrl}'),
      backgroundColor: Colors.transparent,
    );
  }
}*/

/*class _UserProfile extends StatelessWidget {
  final User user;
  _UserProfile({this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              child: Text(
                '${user.name}',
                softWrap: true,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22.0,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              child: Text(
                '${user.email}',
                softWrap: true,
                maxLines: 1,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/
