class User {
  String? id;
  String? nom;
  String? lat;
  String? long;
  String? iconUser;
  User(
      {required this.id,
      required this.nom,
      required this.lat,
      required this.long,
      required this.iconUser});
  factory User.fromjson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        nom: json["nom"],
        lat: json["lat"],
        long: json["long"],
        iconUser: json["iconUser"]);
  }
}

List<User> listUser = [
  User(id: "1", nom: "rondy", lat: "-4.437018", long: "15.277854", iconUser: "")
];
