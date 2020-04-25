import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:UQS/Miscellaneous/loading.dart';
import 'package:UQS/Models/user.dart';
import 'package:UQS/Services/userDatabase.dart';

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
                                  child:
                                      CachedNetworkImage(imageUrl: '${userData.photoUrl}',
                                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) => Icon(Icons.error),),
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

