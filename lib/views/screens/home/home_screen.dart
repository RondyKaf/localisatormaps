import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:localisatormaps/models/maps_eglise.dart';
import 'package:localisatormaps/models/user/user.dart';
import 'package:localisatormaps/util/constants.dart';
import 'package:localisatormaps/views/screens/hopital/hopital_proche/hopital_proche.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: RessourcesColor.COLOR_WHITE.withOpacity(0.0),
          leading: const Center(
              child: Text(
            "GKH",
            style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: RessourcesColor.COLOR_BLACK),
          )),
          elevation: 0.0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: RessourcesColor.COLOR_BLACK,
                ))
          ],
        ),
        body: SingleChildScrollView(
            child: ConstrainedBox(
          constraints: const BoxConstraints(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //en tete
              const carousel_hopital(),
              Container(),
              //carte
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Emplacement de l'utilisateur",
                      style: TextStyle(color: RessourcesColor.COLOR_BLACK),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HopitalProche();
                          }));
                        },
                        child: const Text("Voir l'hopital"))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const carteMapsUser(),
              //pied
            ],
          ),
        )));
  }
}

// ignore: camel_case_types
class carteMapsUser extends StatefulWidget {
  const carteMapsUser({
    Key? key,
  }) : super(key: key);

  @override
  State<carteMapsUser> createState() => _carteMapsUserState();
}

// ignore: camel_case_types
class _carteMapsUserState extends State<carteMapsUser> {
  late User activateser;
  var markers = <Marker>[
    Marker(
        height: 30,
        width: 30,
        point: LatLng(-4.437018, 15.277850),
        builder: (context) {
          return GestureDetector(
              onTap: () {},
              child: Container(
                decoration: const BoxDecoration(
                    color: RessourcesColor.COLOR_GREEN, shape: BoxShape.circle),
              ));
        })
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 500,
        width: 400,
        child: FlutterMap(
          //options: MapOptions(center: LatLng(-4.437018, 15.277850), zoom: 9.2,maxZoom: 16),
          options: MapOptions(
              center: LatLng(-4.437018, 15.277850),
              zoom: 13,
              maxZoom: 17,
              minZoom: 12.3),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(markers: markers)
          ],
          nonRotatedChildren: [
            AttributionWidget.defaultWidget(
              source: 'OpenStreetMap contributors',
              onSourceTapped: null,
            ),
          ],
        ));
  }
}

// ignore: camel_case_types
class carousel_hopital extends StatelessWidget {
  const carousel_hopital({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            "Les hopitaux le plus proches",
            style: TextStyle(
                color: RessourcesColor.COLOR_WHITE,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CarouselSlider(
            items: listMapsEglise.map((itemHopital) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      itemHopital.image.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            }).toList(),
            options: CarouselOptions(
              height: 220,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 16 / 9,
              initialPage: 0,
              autoPlayAnimationDuration: const Duration(seconds: 3),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ))
      ],
    );
  }
}
