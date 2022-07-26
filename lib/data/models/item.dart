// ignore_for_file: public_member_api_docs, sort_constructors_first

class Item {
  String id;
  String title;
  String description;
  String imageUrl;
  DateTime dateofloss;
  String category;
  String governorate;
  int found;
  Map<String, dynamic> user;

  Item(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.dateofloss,
      required this.category,
      required this.governorate,
      required this.found,
      required this.user});
  factory Item.fromDynamic(d) {
    return Item(
        id: d["_id"].toString(),
        title: d["title"].toString(),
        dateofloss: DateTime.parse(d["dateOfLoose"].toString()),
        description: d["description"].toString(),
        category: d["category"].toString(),
        governorate: d["governorate"].toString(),
        imageUrl: d["imageUrl"].toString(),
        user: d["user"]!,
        found: d["found"].runtimeType == String
            ? int.parse(d["found"])
            : d["found"]);
  }

  /*  @override
  String toString() {
    return 'Item(id: $id, title: $title, description: $description, imageUrl: $imageUrl, dateofloss: $dateofloss, found: $found, user: $user)';
  } */
}
