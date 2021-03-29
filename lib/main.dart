import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:location/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VTSitpi',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'Choisisez votre service'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Location location = new Location();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        children: [
          IconButton(
            icon: Image.asset("assets/hugober.jpg"),
            iconSize: 350,
            onPressed: () async {
              // https://www.google.fr/maps/place/47°47'58.0"N+2°38'37.2"E
              var locationData = await location.getLocation();
              print(locationData);
              _sendSMS(
                  "Salut Hugo, J'aurai besoin de toi, peut-tu venir me chercher ? 🚕 \n \n https://www.google.fr/maps/place/" +
                      locationData.latitude.toString() +
                      "+" +
                      locationData.longitude.toString(),
                  ["+33666666666"]);
            },
          ),
          IconButton(
            icon: Image.asset('assets/lukapten.jpg'),
            iconSize: 350,
            onPressed: () async {
              var locationData = await location.getLocation();
              _sendSMS(
                  "Salut Luca, J'aurai besoin de toi, peut-tu venir me chercher ? 🚕 \n \n https://www.google.fr/maps/place/" +
                      locationData.latitude.toString() +
                      "+" +
                      locationData.longitude.toString(),
                  ["+33666666666"]);
            },
          )
        ],
      )),
    );
  }

  void _sendSMS(String message, List<String> recipents) async {
    await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
  }
}
