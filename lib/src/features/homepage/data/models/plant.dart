import 'dart:convert';

class Plant {
  final int id;
  final String name;
  final String pictureUrl;
  final String description;
  final String season;
  final String diseases;
  final String treatment;
  final String properties;
  final String generalUse;
  final String medicalUse;
  final String warnings;
  final int plantCategoryId;
  final String plantCategory;
  final int plantSeasonId;
  final String plantSeason;

  Plant({
    required this.id,
    required this.name,
    required this.pictureUrl,
    required this.description,
    required this.season,
    required this.diseases,
    required this.treatment,
    required this.properties,
    required this.generalUse,
    required this.medicalUse,
    required this.warnings,
    required this.plantCategoryId,
    required this.plantCategory,
    required this.plantSeasonId,
    required this.plantSeason,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      name: json['name'],
      pictureUrl: json['pictureUrl'],
      description: json['description'],
      season: json['season'],
      diseases: json['diseases'],
      treatment: json['treatment'],
      properties: json['properties'],
      generalUse: json['generalUse'],
      medicalUse: json['medicalUse'],
      warnings: json['warnings'],
      plantCategoryId: json['plantCategoryId'],
      plantCategory: json['plantCategory'],
      plantSeasonId: json['plantSeasonId'],
      plantSeason: json['plantSeason'],
    );
  }
}
