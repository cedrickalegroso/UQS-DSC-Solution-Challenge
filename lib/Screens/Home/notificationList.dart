import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:UQS/Models/notification.dart';
import 'package:UQS/Miscellaneous/loading.dart';
import 'package:UQS/Models/service.dart';
import 'package:UQS/Services/serviceDatabase.dart';

class NotifList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifications = Provider.of<List<Notif>>(context) ?? [];
    print('active tickets: ' + notifications.length.toString());
    
      return notifications.length != 0
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return StreamProvider<Service>.value(
              
                  value: ServiceDatabase(uid: notifications[index].notifService)
                      .serviceData,
                  child: ActiveNotifications(notifications: notifications, index: index));
            },
          )
        : Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(6),
            padding: EdgeInsets.all(1),
            width: MediaQuery.of(context).size.width * .80,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  offset: Offset(2, 2),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Colors.lightBlueAccent[100],
            ),
            child: Center(
              child: Text('You have no active tickets',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  )),
            ),
          );
  }
}

class ActiveNotifications extends StatelessWidget {
  const ActiveNotifications({
    Key key,
    @required this.notifications,
    @required this.index,
  }) : super(key: key);

  final List<Notif> notifications;
  final int index;

  @override
  Widget build(BuildContext context) {
    Service service = Provider.of<Service>(context);
    return service != null
        ? Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(6),
            padding: EdgeInsets.all(1),
            width: MediaQuery.of(context).size.width * .100,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  offset: Offset(2, 2),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: ListTile(
                    title: Text(
                      '${service.displayName}',
                      textAlign: TextAlign.left,
                    ),
                    leading: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * .05,
                      // backgroundImage: NetworkImage('${service.photoUrl}'),
                      child: CachedNetworkImage(
                        imageUrl: '${service.photoUrl}',
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: ListTile(
                    subtitle: 
                    Text(
                       'TEST',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlueAccent),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(6),
            padding: EdgeInsets.all(1),
            width: MediaQuery.of(context).size.width * .70,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  offset: Offset(2, 2),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Colors.white,
            ),
            child: Loading());
  }
}

