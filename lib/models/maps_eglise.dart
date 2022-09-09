import 'package:latlong2/latlong.dart';

class MapsEglise {
  String? id;
  String? nom;
  final LatLng location;
  String? image;
  String? iconMaps;
  String? description;

  MapsEglise(
      {required this.id,
      required this.nom,
      required this.location,
      required this.image,
      required this.iconMaps,
      required this.description});
}

final _locations = [
  LatLng(-4.438028, 15.277231),
  LatLng(-4.434866, 15.279741),
  LatLng(-4.432517, 15.279010),
  LatLng(-4.425142, 15.2854420),
];
List<MapsEglise> listMapsEglise = [
  MapsEglise(
      id: "1",
      nom: "PolyClinique ma kembi",
      location: _locations[0],
      image: "assets/pexel1.jpg",
      iconMaps: "",
      description: ""),
  MapsEglise(
      id: "2",
      nom: "Centre Grace shallom",
      location: _locations[1],
      image: "assets/pexel2.jpg",
      iconMaps: "",
      description: ""),
  MapsEglise(
      id: "3",
      nom: "Hopital de soeurs de santé",
      location: _locations[2],
      image: "assets/pexel3.jpg",
      iconMaps: "",
      description: ""),
  MapsEglise(
      id: "4",
      nom: "Hopital Monkole",
      location: _locations[3],
      image: "assets/pexel4.jpg",
      iconMaps: "",
      description: ""),
];
