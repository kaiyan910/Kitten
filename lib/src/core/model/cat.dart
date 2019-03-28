class Cat {

  String id;
  String url;

  Cat.fromJSON(Map<String, dynamic> json)
    : id = json["id"],
      url = json["url"];

  Cat.fromDatabase(Map<String, dynamic> schema)
    : id = schema["cat_id"],
      url = schema["cat_url"];

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      "cat_id": id,
      "cat_url": url,
    };
  }
}