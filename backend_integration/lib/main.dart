import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model/welcome.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Welcome? _weatherData;

  Future<void> _fetchWeatherData(String city) async {
    final response = await http.get(Uri.parse(
        'https://api.weatherapi.com/v1/current.json?key=cfd6981a95d3459a9ad84557241707&q=$city'));

    if (response.statusCode == 200) {
      setState(() {
        _weatherData = Welcome.fromJson(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_weatherData == null) ...[
              ElevatedButton(
                onPressed: () => _fetchWeatherData('Nagpur'),
                child: Text('Nagpur'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _fetchWeatherData('Bangalore'),
                child: Text('Bangalore'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _fetchWeatherData('London'),
                child: Text('London'),
              ),
            ] else
              _buildWeatherTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherTable() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Table(
        border: TableBorder.all(),
        children: [
          TableRow(
            children: [
              TableCell(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Parameter',
                          style: TextStyle(fontWeight: FontWeight.bold)))),
              TableCell(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Value',
                          style: TextStyle(fontWeight: FontWeight.bold)))),
            ],
          ),
          _buildTableRow('Location',
              '${_weatherData!.location.name}, ${_weatherData!.location.country}'),
          _buildTableRow(
              'Temperature (C)', _weatherData!.current.tempC.toString()),
          _buildTableRow(
              'Is Day', _weatherData!.current.isDay == 1 ? 'Yes' : 'No'),
          _buildTableRow('Cloud', _weatherData!.current.cloud.toString()),
          _buildTableRow(
              'Feels Like (C)', _weatherData!.current.feelslikeC.toString()),
          _buildTableRow(
              'Wind Chill (C)', _weatherData!.current.windchillC.toString()),
          _buildTableRow(
              'Heat Index (C)', _weatherData!.current.heatindexC.toString()),
          _buildTableRow(
              'Visibility (Km)', _weatherData!.current.visKm.toString()),
          _buildTableRow('UV Index', _weatherData!.current.uv.toString()),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String parameter, String value) {
    return TableRow(
      children: [
        TableCell(
            child: Padding(
                padding: const EdgeInsets.all(8.0), child: Text(parameter))),
        TableCell(
            child: Padding(
                padding: const EdgeInsets.all(8.0), child: Text(value))),
      ],
    );
  }
}

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Location location;
  Current current;

  Welcome({
    required this.location,
    required this.current,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        location: Location.fromJson(json["location"]),
        current: Current.fromJson(json["current"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "current": current.toJson(),
      };
}

class Current {
  double tempC;
  int isDay;
  int cloud;
  double feelslikeC;
  double windchillC;
  double heatindexC;
  int visKm;
  int uv;

  Current({
    required this.tempC,
    required this.isDay,
    required this.cloud,
    required this.feelslikeC,
    required this.windchillC,
    required this.heatindexC,
    required this.visKm,
    required this.uv,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        tempC: json["temp_c"]?.toDouble(),
        isDay: json["is_day"],
        cloud: json["cloud"],
        feelslikeC: json["feelslike_c"]?.toDouble(),
        windchillC: json["windchill_c"]?.toDouble(),
        heatindexC: json["heatindex_c"]?.toDouble(),
        visKm: json["vis_km"],
        uv: json["uv"],
      );

  Map<String, dynamic> toJson() => {
        "temp_c": tempC,
        "is_day": isDay,
        "cloud": cloud,
        "feelslike_c": feelslikeC,
        "windchill_c": windchillC,
        "heatindex_c": heatindexC,
        "vis_km": visKm,
        "uv": uv,
      };
}

class Location {
  String name;
  String region;
  String country;
  double lat;
  String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        region: json["region"],
        country: json["country"],
        lat: json["lat"]?.toDouble(),
        localtime: json["localtime"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "region": region,
        "country": country,
        "lat": lat,
        "localtime": localtime,
      };
}
