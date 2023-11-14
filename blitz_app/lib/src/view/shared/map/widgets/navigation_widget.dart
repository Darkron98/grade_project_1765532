import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grade_project_1765532/src/core/logic/functions.dart';
import 'package:grade_project_1765532/src/core/service/location_services.dart';
import 'package:grade_project_1765532/src/style/style.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../bloc/bloc.dart';
import '../../../../core/model/location/directions_model.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({super.key});

  @override
  NavigationWidgetState createState() => NavigationWidgetState();
}

class NavigationWidgetState extends State<NavigationWidget> {
  late GoogleMapController _googleMapController;
  BitmapDescriptor? shopIcon;
  BitmapDescriptor? customerIcon;
  Directions directionsInfo = const Directions();

  @override
  void initState() {
    setShopIcon();
    setCustomerIcon();
    super.initState();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  void getDirections(LatLng origin, LatLng destination) async {
    var directions =
        await LocationServices().getDirections(origin, destination);
    setState(() {
      this.directionsInfo = directions;
    });
  }

  void setShopIcon() async {
    BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(1, 1)),
      'assets/shop_marker_icon.png',
    );
    setState(() {
      this.shopIcon = icon;
    });
  }

  void setCustomerIcon() async {
    BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(1, 1)),
      'assets/customer_marker_icon.png',
    );
    setState(() {
      this.customerIcon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return GoogleMap(
              padding: const EdgeInsets.only(bottom: 20, left: 20),
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              polylines: {
                if (directionsInfo.polylinePoints != null)
                  Polyline(
                    polylineId: const PolylineId('overview_polyLine'),
                    color: ColorPalette.primary,
                    width: 5,
                    points: directionsInfo.polylinePoints!
                        .map((e) => LatLng(e.latitude, e.longitude))
                        .toList(),
                  )
              },
              markers: {
                Marker(
                    markerId: const MarkerId('origin'),
                    infoWindow: const InfoWindow(title: 'Origen'),
                    position: LatLng(state.srcLat, state.srcLng),
                    icon: shopIcon ?? BitmapDescriptor.defaultMarker),
                Marker(
                  markerId: const MarkerId('destination'),
                  infoWindow: const InfoWindow(title: 'Destino'),
                  position: LatLng(state.lat, state.lng),
                  icon: customerIcon ?? BitmapDescriptor.defaultMarker,
                ),
              },
              initialCameraPosition: CameraPosition(
                  target: LatLng(state.srcLat, state.srcLng), zoom: 17),
              onMapCreated: (controller) {
                _googleMapController = controller;
                controller.setMapStyle(
                    '[{"featureType": "poi","stylers": [{"visibility": "off"}]}]');
              },
            );
          },
        ),
        appBar: AppBar(
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: const ReturnButton(),
          backgroundColor: ColorPalette.background,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            height: 65,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 0.5,
                    blurRadius: 5,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<MapBloc, MapState>(
                  builder: (context, state) {
                    return GestureDetector(
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: ColorPalette.primary,
                            borderRadius: BorderRadius.circular(100)),
                        child: const Padding(
                          padding: EdgeInsets.only(),
                          child: Icon(
                            Remix.route_line,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () => getDirections(
                          LatLng(state.srcLat, state.srcLng),
                          LatLng(state.lat, state.lng)),
                    );
                  },
                ),
                directionsInfo.totalDistance != null
                    ? Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(),
                                Text(
                                  '${directionsInfo.totalDistance}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: ColorPalette.greyText),
                                ),
                                const SizedBox(),
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            const SizedBox(
                              width: 5,
                              height: 65,
                              child: VerticalDivider(),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(),
                                Text(
                                  '≈ ${directionsInfo.totalDuration}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: ColorPalette.greyText),
                                ),
                                const SizedBox(),
                              ],
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
                BlocBuilder<MapBloc, MapState>(
                  builder: (context, state) {
                    return GestureDetector(
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: ColorPalette.primary,
                            borderRadius: BorderRadius.circular(100)),
                        child: const Icon(
                          Remix.focus_3_line,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () => _googleMapController.animateCamera(
                        directionsInfo.bounds != null
                            ? CameraUpdate.newLatLngBounds(
                                directionsInfo.bounds!, 100.0)
                            : CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: LatLng(state.srcLat, state.srcLng),
                                  zoom: 17,
                                ),
                              ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReturnButton extends StatelessWidget {
  const ReturnButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 0, top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  color: ColorPalette.lightBg,
                  borderRadius: BorderRadius.circular(10)),
              child: const Padding(
                padding: EdgeInsets.only(right: 0),
                child: Icon(
                  Remix.arrow_left_s_line,
                  color: ColorPalette.primary,
                ),
              ),
            ),
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}
