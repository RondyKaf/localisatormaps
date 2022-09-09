import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:localisatormaps/models/maps_eglise.dart';
import '../../../../util/constants.dart';

class HopitalProche extends StatefulWidget {
  @override
  State<HopitalProche> createState() => _HopitalProcheState();
}

class _HopitalProcheState extends State<HopitalProche>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  late final AnimationController _animationController;
  int _selectIndex = 0;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Marker> _builMarkers() {
    final _markerList = <Marker>[];
    for (int i = 0; i < listMapsEglise.length; i++) {
      final mapItem = listMapsEglise[i];
      _markerList.add(Marker(
          height: 50,
          width: 50,
          point: mapItem.location,
          builder: (context) {
            return GestureDetector(
                onTap: () {
                  _selectIndex = i;
                  setState(() {
                    _pageController.animateToPage(i,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.elasticInOut);
                    print(mapItem.nom);
                    print(i);
                  });
                },
                child: LocationMakers(
                  selected: _selectIndex == i,
                ));
          }));
    }
    return _markerList;
  }

  List<Polyline> _polyline() {
    final _polylineList = <Polyline>[];
    for (int i = 0; i < listMapsEglise.length; i++) {
      final itemPolyline = listMapsEglise[i];
      _polylineList.add(
        Polyline(
          points: [itemPolyline.location, itemPolyline.location],
          color: RessourcesColor.COLOR_BLUE,
        ),
      );
    }
    return _polylineList;
  }

  var markersUser = <Marker>[
    Marker(
        height: 15,
        width: 15,
        point: LatLng(-4.437018, 15.277850),
        builder: (context) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              decoration: const BoxDecoration(
                  color: RessourcesColor.COLOR_GREEN, shape: BoxShape.circle),
            ),
          );
        })
  ];

  @override
  Widget build(BuildContext context) {
    final markers = _builMarkers();
    final polylines = _polyline();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: RessourcesColor.COLOR_BLACK.withOpacity(0.2),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios))),
      body: Stack(
        children: [
          FlutterMap(
            //options: MapOptions(center: LatLng(-4.437018, 15.277850), zoom: 9.2,maxZoom: 16),
            options: MapOptions(
              center: LatLng(-4.437018, 15.277850),
              zoom: 15,
              maxZoom: 19,
              minZoom: 12.3,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(
                markers: markersUser,
              ),
              MarkerLayerOptions(markers: markers),
              PolylineLayerOptions(polylineCulling: true, polylines: [
                Polyline(
                    points: [
                      LatLng(-4.437018, 15.277850),
                      LatLng(-4.434866, 15.279741),
                    ],
                    color: RessourcesColor.COLOR_BLUE,
                    borderColor: RessourcesColor.COLOR_BLUE)
              ])
            ],

            nonRotatedChildren: [
              AttributionWidget.defaultWidget(
                source: 'OpenStreetMap contributors',
                onSourceTapped: null,
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            height: MediaQuery.of(context).size.height * 0.3,
            child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final item = listMapsEglise[index];
                  return MapItemDetails(mapsEglise: item);
                }),
          )
        ],
      ),
    );
  }
}

class LocationMakers extends StatelessWidget {
  const LocationMakers({Key? key, this.selected = false}) : super(key: key);

  final bool selected;
  @override
  Widget build(BuildContext context) {
    final size = selected ? MARKER_SIZE_EXPAND : MARKER_SIZE_SHRINK;
    return Center(
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: size,
          width: size,
          child: const Icon(
            Icons.location_on_rounded,
            color: RessourcesColor.COLOR_BLUE,
          )),
    );
  }
}

class MapItemDetails extends StatelessWidget {
  const MapItemDetails({Key? key, required this.mapsEglise}) : super(key: key);

  final MapsEglise mapsEglise;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: RessourcesColor.COLOR_BLUE.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  width: 100,
                  decoration: BoxDecoration(
                      color: RessourcesColor.COLOR_WHITE,
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mapsEglise.nom!,
                      style: const TextStyle(
                        color: RessourcesColor.COLOR_WHITE,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      mapsEglise.nom!,
                      style:
                          const TextStyle(color: RessourcesColor.COLOR_WHITE),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Description",
                  style: TextStyle(color: RessourcesColor.COLOR_BLACK),
                ),
                Text(
                  "lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem",
                  style: TextStyle(color: RessourcesColor.COLOR_WHITE),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
