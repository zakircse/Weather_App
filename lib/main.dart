import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather App",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var temp;
  var description;
  var currently;
  var humidity;
  var wind;
  Future getweather() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=Dhaka&units=imperial&appid=f002423e07cbc378b2d2e044f3cd4d44"));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.wind = results['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getweather();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              color: Colors.redAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Currently in Dhaka",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      temp != null ? temp.toString() + "\u00B0" : "Loading",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    currently != null ? currently.toString() : "Loading",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(Icons.thermostat),
                      title: Text("Temperature"),
                      trailing: Text(
                        temp != null ? temp.toString() + "\u00B0" : "Loading",
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.cloud),
                      title: Text("Weather"),
                      trailing: Text(
                        description != null
                            ? description.toString()
                            : "Loading",
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.wb_sunny),
                      title: Text("Humidity"),
                      trailing: Text(
                        humidity != null ? humidity.toString() : "Loading",
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.air),
                      title: Text("Wind Speed"),
                      trailing: Text(
                        wind != null ? wind.toString() : "Loading",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
