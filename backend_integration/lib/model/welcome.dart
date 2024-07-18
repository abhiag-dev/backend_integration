import 'dart:convert';

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
