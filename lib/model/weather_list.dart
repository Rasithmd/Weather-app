class WeatherListModel {
  int? id;
  String? main;
  String? description;
  String? icon;

  WeatherListModel({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  WeatherListModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        main = map['main'].toString(),
        description = map['description'].toString(),
        icon = map['icon'].toString();
}
