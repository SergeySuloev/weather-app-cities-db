import "package:hive/hive.dart";
import "package:path_provider/path_provider.dart";

part 'main.g.dart';

@HiveType(typeId: 0)
class OpenWeatherMapCity {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String state;

  @HiveField(3)
  String countryCode;

  @HiveField(4)
  double coordLon;

  @HiveField(5)
  double coordLat;

  OpenWeatherMapCity(this.id, this.name, this.state, this.countryCode,
      this.coordLon, this.coordLat);
}

void main() async {}
