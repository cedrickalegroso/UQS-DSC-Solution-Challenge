import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uqsbeta/Models/user.dart';

class UserTile extends StatefulWidget {
  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    final UserData userData = Provider.of<UserData>(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          userData.photoUrl == ''
              ? Icon(
                Icons.add_a_photo,
                size: 50,
                )
              : CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('${userData.photoUrl}'),
                  backgroundColor: Colors.transparent,
                ),
          _UserProfile(user: userData),
        ],
      ),
    );
  }
}

class _UserProfile extends StatelessWidget {
  final UserData user;
  _UserProfile({this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${user.name}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 22.0,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            '${user.email}',
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
