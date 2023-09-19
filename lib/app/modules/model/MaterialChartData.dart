// To parse this JSON data, do
//
//     final materialChartData = materialChartDataFromJson(jsonString);

import 'dart:convert';

List<MaterialChartData> materialChartDataFromJson(String str) => List<MaterialChartData>.from(json.decode(str).map((x) => MaterialChartData.fromJson(x)));

String materialChartDataToJson(List<MaterialChartData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaterialChartData {
  MaterialChartData({
    required this.domain,
    required this.measure,
  });

  String domain;
  int measure;

  factory MaterialChartData.fromJson(Map<String, dynamic> json) => MaterialChartData(
    domain: json["domain"],
    measure: json["measure"],
  );

  Map<String, dynamic> toJson() => {
    "domain": domain,
    "measure": measure,
  };
}
