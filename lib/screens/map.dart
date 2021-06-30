import 'dart:async';
import 'dart:convert';

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:maak/providers/appointmen_provider.dart';
import 'package:maak/providers/auth_provider.dart';
import 'package:maak/providers/language_provider.dart';
import "dart:async";
import "package:google_maps_webservice/places.dart";
import 'dart:ui' as ui;

import 'package:maak/providers/utils.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'login/otp.dart';

class LocationmapPage extends StatefulWidget {
  LocationData? locationData;
  LocationmapPage({this.locationData});
  @override
  LocationmapPageBody createState() => LocationmapPageBody();
}

class LocationmapPageBody extends State<LocationmapPage> {
  double widthscreen = 0;
  double heightscreen = 0;
  String locationTex = '';
  Coordinates coordinates = Coordinates(0, 0);
  //Locationn loc;

  String val = '';

  Completer<GoogleMapController>? _controller;
  static LatLng _center = const LatLng(45.521563, -122.677433);
  LatLng _lastMapPosition = _center;
  LatLng temp = _center;
  final Set<Marker> _markers = {};
  MapType _currentMapType = MapType.normal;

  void _onCameraMove(CameraPosition position) {
    setState(() {
      getaddress();
      _lastMapPosition = position.target;
    });
  }

  Future<String> getaddress() async {
    coordinates =
        new Coordinates(_lastMapPosition.latitude, _lastMapPosition.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    locationTex = " ${first.addressLine}";

    return "${first.featureName}";
  }

  @override
  initState() {
    _center =
        LatLng(widget.locationData!.latitude, widget.locationData!.longitude);
    _lastMapPosition = _center;
    getaddress();

    super.initState();
    // Add listeners to this class
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    var isAuth = Provider.of<AuthProvider>(context, listen: true).isAuth;
    widthscreen = MediaQuery.of(context).size.width;
    heightscreen = MediaQuery.of(context).size.height;

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    // LatLng temp = LatLng(widget.temp.lat, widget.temp.lang);

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.green[400],
          child: Column(
            children: [
              Flexible(
                flex: 3,
                child: Stack(
                  children: [
                    GoogleMap(
                      zoomControlsEnabled: false,
                      mapToolbarEnabled: true,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      mapType: _currentMapType,
                      onMapCreated: (GoogleMapController controller) {
                        _controller?.complete(controller);
                      },
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 11.0,
                      ),
                      compassEnabled: true,
                      // markers: _markers,
                      onCameraMove: _onCameraMove,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              //  _onAddMarkerButtonPressed();

                              print(
                                  "markerId is" + _lastMapPosition.toString());
                            });
                          },
                          //   materialTapTargetSize: MaterialTapTargetSize.padded,
                          //  backgroundColor: Colors.green,
                          icon: const Icon(
                            Icons.add_location,
                            size: 35.0,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Theme.of(context).canvasColor,
                                ),
                                padding: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.18,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${locationTex}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,fontFamily: 'Exo'),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                    Text("${_lastMapPosition}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontWeight: FontWeight.bold)),
                                  ],
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // GestureDetector(
                                //   child: Container(
                                //     child: SvgPicture.asset(
                                //       'assets/svg/x.svg',
                                //     ),
                                //   ),
                                // ),
                                GestureDetector(
                                  onTap: () {
                                    Provider.of<appointmenProvider>(context,
                                        listen: false)
                                        .setaddress(locationTex, _lastMapPosition.latitude, _lastMapPosition.longitude);
                                    Utils.NavigatorKey.currentState!
                                        .pushReplacementNamed("/otp");
                                  },
                                  child: Container(
                                    child: SvgPicture.asset(
                                      'assets/svg/icon_map.svg',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),

          //  clipBehavior: Clip.antiAliasWithSaveLayer,
        ),
      ),
    );
  }
}
