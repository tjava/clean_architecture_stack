class AboutModel extends AboutEntity {
  const AboutModel({required super.id});

  factory AboutModel.fromJson(Map<String, dynamic> json) => AboutModel(
        id: json["id"],
      );
}
  