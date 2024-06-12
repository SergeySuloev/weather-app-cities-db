import "package:hive/hive.dart";
import "package:path_provider/path_provider.dart" as pathProvider;

part 'main.g.dart';

@HiveType(typeId: 0)
class OpenWeatherMapCity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String state;

  @HiveField(3)
  final String countryCode;

  @HiveField(4)
  final double coordLon;

  @HiveField(5)
  final double coordLat;

  OpenWeatherMapCity(
      {required this.id,
      required this.name,
      required this.state,
      required this.countryCode,
      required this.coordLon,
      required this.coordLat});
}

void main() async {
  final appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
}
