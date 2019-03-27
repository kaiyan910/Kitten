class Cat {

  String id;
  String url;

  List<Category> category;
  List<Breed> breed;

  Cat.from(Map<String, dynamic> json)
    : id = json["id"],
      url = json["url"],
      category = (json["categories"] as List)
          ?.map((e) => e == null
          ? null
          : new Category.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      breed = (json["breed"] as List)
          ?.map((e) => e == null
          ? null
          : new Breed.fromJson(e as Map<String, dynamic>))
          ?.toList();

}

class Category {

  int id;
  String name;

  Category.fromJson(Map<String, dynamic> json)
    : id = json["id"],
      name = json["name"];
}

class Breed {

  String id;
  String name;

  Breed.fromJson(Map<String, dynamic> json)
    : id = json["id"],
      name = json["name"];
}