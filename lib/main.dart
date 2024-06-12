import "dart:convert";
import "dart:io";
import "package:flutter/widgets.dart";
import "package:hive/hive.dart";
import 'package:flutter/services.dart' show rootBundle;
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
  final String? countryCode;

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

  factory OpenWeatherMapCity.fromJson(Map<String, dynamic> json) {
    return OpenWeatherMapCity(
        id: json['id'],
        name: json['name'],
        state: json['state'],
        countryCode: json['countryCode'] as String?,
        coordLon: json['coordLon'],
        coordLat: json['coordLat']);
  }
}

Future<void> loadJson() async {
  WidgetsFlutterBinding.ensureInitialized();
  String jsonString = await rootBundle.loadString('assets/city.list.json');
  final jsonResponse = jsonDecode(jsonString) as List;

  List<OpenWeatherMapCity> cities =
      jsonResponse.map((item) => OpenWeatherMapCity.fromJson(item)).toList();

  final box = await Hive.openBox<OpenWeatherMapCity>('cities');
  for (var city in cities) {
    await box.add(city);
  }
  await box.close();
}

Future<void> exportDb() async {
  final appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();
  final dbFile = File('${appDocumentDirectory.path}/cities.hive');

  final exportDir = await pathProvider.getExternalStorageDirectory();
  final exportedFile = File('${exportDir!.path}/exported_cities.hive');

  await dbFile.copy(exportedFile.path);
}

void main() async {
  final appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(OpenWeatherMapCityAdapter());

  await loadJson();
  await exportDb();

  exit(0);
}
