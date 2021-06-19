import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maploc extends StatefulWidget {
  const Maploc({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Maploc> {
  MapType _currentMapType=MapType.normal;
  var _lastMapPosition;
  double latitude_data=0;
  double longitude_data = 0;
   LatLng _center = LatLng(0, 0);
  Set<Marker> _markers = {};
    LatLng temp = LatLng(0, 0);
   late Completer<GoogleMapController> _controller ;


  @override
  void initState() {
    _getCurrentLocation();

  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true)
        .then((Position position) {
      setState(()  {
        latitude_data = position.latitude;
        longitude_data = position.longitude;
        _getAddressFromLatLng();
        _center = LatLng(latitude_data, longitude_data);
        _lastMapPosition = _center;
        temp =  LatLng(latitude_data, longitude_data);
        _center =  LatLng(latitude_data, longitude_data);
        _markers.add(
          Marker(
            // This marker id can be anything that uniquely identifies each marker.
            markerId: MarkerId(_lastMapPosition.toString()),
            position: temp,
// icon: await getMarkerIcon(img, Size(150.0, 150.0))
          ),
        );
        latitude_data = _lastMapPosition.latitude;
        longitude_data = _lastMapPosition.longitude;

      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude_data, longitude_data);

      Placemark place = placemarks[0];



    } catch (e) {
      print(e);
    }
  }



  void _onMapTypeButtonPressed() {
    setState(() {

      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }



  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onAddMarkerButtonPressed() async {
    setState(
          () {
        _markers.add(
          Marker(
            // This marker id can be anything that uniquely identifies each marker.
            markerId: MarkerId(_lastMapPosition.toString()),
            position: _lastMapPosition,
          ),
        );
        latitude_data = _lastMapPosition.latitude;
        longitude_data = _lastMapPosition.longitude;
        _getAddressFromLatLng();
      },
    );

    print("markerId^^^" + _lastMapPosition.toString());
  }


  @override
  Widget build(BuildContext context) {




// print("markerId^^^"+_lastMapPosition.toString());




    return Container(
      child: Stack(
        children: [
          GoogleMap(
            mapType: _currentMapType,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            compassEnabled: true,
            markers: _markers,
            onCameraMove: _onCameraMove,
            myLocationEnabled: true,
          ),
          Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                onPressed: _onMapTypeButtonPressed,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                backgroundColor: Colors.green,
                child: const Icon(Icons.map, size: 36.0),
              )),
          SizedBox(height: 16.0),
          Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                return _onAddMarkerButtonPressed();
              },
              // materialTapTargetSize: MaterialTapTargetSize.padded,
              // backgroundColor: Colors.green,
              icon: const Icon(
                Icons.add_location,
                size: 55.0,
                color: Colors.green,
              ),
            ),
          ),
          Align(alignment: Alignment.bottomCenter,
          child:ElevatedButton(onPressed: (){},
          child: Text('Next'),
            style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20),elevation: 5),
          ),
          )
        ],
      ),
    );

  }











}

