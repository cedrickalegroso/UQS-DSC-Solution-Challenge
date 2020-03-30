import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:UQS/Models/service.dart';
import 'package:UQS/Services/serviceDatabase.dart';
import 'package:UQS/Screens/Home/viewService.dart';

class Government extends StatefulWidget {
  @override
  _GovernmentState createState() => _GovernmentState();
}

class _GovernmentState extends State<Government> {
  @override
  Widget build(BuildContext context) {
    print('university');
    final services = Provider.of<List<GovernmentCategory>>(context) ?? [];
    return Container(
      height: 600,
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage('assets/1.png'), fit: BoxFit.cover)),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient:
                      LinearGradient(begin: Alignment.bottomRight, colors: [
                    Colors.black.withOpacity(.4),
                    Colors.black.withOpacity(.2),
                  ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Goverment",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: GridView.builder(
                  physics: ScrollPhysics(),
                  itemCount: services.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return StreamProvider<List<GovernmentCategory>>.value(
                      value: ServiceDatabase().governmentCategory,
                      child: GovernmentTile(service: services[index]),
                    );
                  }))
        ],
      ),
    );
  }
}

/*

 child: GridView.builder(
            physics: ScrollPhysics(),
            itemCount: services.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return StreamProvider<List<GovernmentCategory>>.value(
                value: ServiceDatabase().governmentCategory,
                child: GovernmentTile(service: services[index]),
              );
            })

*/
class GovernmentTile extends StatelessWidget {
  final GovernmentCategory service;
  GovernmentTile({this.service, int index});

  //show snackbar method
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    final snackBar = SnackBar(
      content: Text(
        'Ticket created succesfully',
        style: TextStyle(fontSize: 15.0),
      ),
      duration: new Duration(seconds: 5),
      backgroundColor: Colors.green,
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return service != null
        ? Container(
            child: Card(
            color: Colors.transparent,
            elevation: 0,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image:
                            AssetImage('assets/${service.categoryIndex}.png'),
                        fit: BoxFit.cover)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient:
                          LinearGradient(begin: Alignment.bottomRight, colors: [
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(.2),
                      ])),
                  child: Transform.translate(
                    offset: Offset(0, -0),
                    child: GestureDetector(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewService(
                                displayName: service.displayName,
                                abbreviation: service.abbreviation,
                                email: service.email,
                                phoneNumber: service.phoneNumber,
                                photoUrl: service.photoUrl,
                                categoryIndex: service.categoryIndex,
                                ticketCount: service.ticketCount,
                                uid: service.uid)));
                      },
                      child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CachedNetworkImage(
                                imageUrl: '${service.photoUrl}',
                                width: 90.0,
                                height: 90.0,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '${service.abbreviation}',
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white,
                                ),
                              )
                            ]),
                      ),
                    ),
                  ),
                )),
          ))
        : null;
  }
}
