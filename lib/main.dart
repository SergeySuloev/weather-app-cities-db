import "package:hive/hive.dart";
import "package:path_provider/path_provider.dart";

class OpenWeatherMapCity {
  int id;
  String name;
  String state;
  String countryCode;
  double coordLon;
  double coordLat;

  OpenWeatherMapCity(this.id, this.name, this.state, this.countryCode,
      this.coordLon, this.coordLat);
}

void main() async {}
