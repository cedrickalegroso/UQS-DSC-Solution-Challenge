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
    final userData = Provider.of<UserData>(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 1, child: _UserPhoto(user: userData)),
          Expanded(flex: 2, child: _UserProfile(user: userData)),
        ],
      ),
    );
  }
}

class _UserPhoto extends StatelessWidget {
  final UserData user;
  _UserPhoto({this.user});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('${user.photoUrl}'),
            backgroundColor: Colors.transparent,
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
}
