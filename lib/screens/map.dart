import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maak/providers/utils.dart';

class Maploc extends StatefulWidget {
  @override
  _MyLocationState createState() => _MyLocationState();
}

class _MyLocationState extends State<Maploc> {
  LocationData? _currentPosition;
  String _address = '';
  String _dateTime = '';

  Marker? marker;
  Location location = Location();

  GoogleMapController? _controller;
  LatLng _initialcameraposition = LatLng(0.5937, 0.9629);
  var animateCamera;
  var currentLocation;
  @override
  void initState() {
    getLoc();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    animateCamera.cancel();
    currentLocation.cancel();
    _controller!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    setState(() {
      _controller = _cntlr;
    });

    animateCamera = location.onLocationChanged.listen((l) {
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/world.jpg'), fit: BoxFit.fill),
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Container(
          color: Colors.blueGrey.withOpacity(.8),
          child: Center(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: _initialcameraposition, zoom: 15),
                    mapType: MapType.normal,
                    onMapCreated: _onMapCreated,
                    myLocationEnabled: true,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                if (_dateTime != null)
                  Text(
                    "Date/Time: $_dateTime",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                SizedBox(
                  height: 3,
                ),
                if (_currentPosition != null)
                  Text(
                    "Latitude: ${_currentPosition?.latitude}, Longitude: ${_currentPosition?.longitude}",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                SizedBox(
                  height: 3,
                ),
                if (_address != null)
                  Text(
                    "Address: $_address",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      Utils.NavigatorKey.currentState!
                          .pushReplacementNamed('/Body');
                    },
                    child: Text('Next'),
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        elevation: 5,
                        fixedSize: Size(MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.height * 0.05)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    _initialcameraposition = LatLng(_currentPosition?.latitude ?? 36.1317595,
        _currentPosition?.longitude ?? 36.1317595);
    currentLocation =
        location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.longitude}");
      if (mounted) {
        setState(() {
          _currentPosition = currentLocation;
          _initialcameraposition = LatLng(_currentPosition?.latitude ?? 0,
              _currentPosition?.longitude ?? 0);

          DateTime now = DateTime.now();
          _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
          _getAddress(_currentPosition?.latitude ?? 30,
                  _currentPosition?.longitude ?? 0)
              .then((value) {
            setState(() {
              _address = "${value.first.addressLine}";
            });
          });
        });
      }
    });
  }

  Future<List<Address>> _getAddress(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add = await Geocoder.local
        .findAddressesFromCoordinates(coordinates)
        .catchError((error, stackTrace) {
      print('error');
    });
    return add;
  }
}
