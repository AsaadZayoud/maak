import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


import 'dart:ui' as ui;

import 'package:maak/providers/utils.dart';



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




  //Locationn loc;

  String val = '';

  Completer<GoogleMapController>? _controller;
  static LatLng _center = const LatLng(45.521563, -122.677433);
  LatLng _lastMapPosition = _center;
   LatLng temp = _center;
  final Set<Marker> _markers = {};
  MapType _currentMapType = MapType.normal;
  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }




  void _onCameraMove(CameraPosition position) {


    setState(() {

      _lastMapPosition = position.target;


    });
  }

  void _onAddMarkerButtonPressed() {

    _markers.clear();

    setState(() {






      _markers.add(
        Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(_lastMapPosition.toString()),

          position: _lastMapPosition,

          infoWindow: InfoWindow(

            // snippet: val.toString(),
          ),
          //  icon: await getMarkerIcon(img, Size(150.0, 150.0))
        ),
      );

    });
  }

  Future<ui.Image> getImageFromPath(String imagePath) async {
    File imageFile = File(imagePath);

    Uint8List imageBytes = imageFile.readAsBytesSync();

    final Completer<ui.Image> completer = new Completer();

    ui.decodeImageFromList(imageBytes, (ui.Image img) {
      return completer.complete(img);
    });

    return completer.future;
  }

  Future<BitmapDescriptor> getMarkerIcon(String imagePath, Size size) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Radius radius = Radius.circular(size.width / 2);

    final Paint tagPaint = Paint()..color = Colors.blue;
    final double tagWidth = 40.0;

    final Paint shadowPaint = Paint()..color = Colors.blue.withAlpha(100);
    final double shadowWidth = 15.0;

    final Paint borderPaint = Paint()..color = Colors.white;
    final double borderWidth = 3.0;

    final double imageOffset = shadowWidth + borderWidth;

    // Add shadow circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowPaint);

    // Add border circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(shadowWidth, shadowWidth,
              size.width - (shadowWidth * 2), size.height - (shadowWidth * 2)),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint);

    // Add tag circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(size.width - tagWidth, 0.0, tagWidth, tagWidth),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        tagPaint);

    // Add tag text
    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: '1',
      style: TextStyle(fontSize: 20.0, color: Colors.white),
    );

    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(size.width - tagWidth / 2 - textPainter.width / 2,
            tagWidth / 2 - textPainter.height / 2));

    // Oval for the image
    Rect oval = Rect.fromLTWH(imageOffset, imageOffset,
        size.width - (imageOffset * 2), size.height - (imageOffset * 2));

    // Add path for oval image
    canvas.clipPath(Path()..addOval(oval));

    // Add image
    ui.Image image = await getImageFromPath(
        imagePath); // Alternatively use your own method to get the image
    // ui.Image image = await getUiImage(imagePath, 50, 50);
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);

    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());

    // Convert image to bytes
    final ByteData? byteData =
    await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }




  @override
  initState() {
    _center = LatLng(widget.locationData!.latitude, widget.locationData!.longitude);

    _markers.add(
      Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _center ,
        infoWindow: InfoWindow(
          //  title: title,
          snippet: val.toString(),
        ),
      ),

    );
    super.initState();
    // Add listeners to this class


  }

  @override
  Widget build(BuildContext context) {

    widthscreen = MediaQuery.of(context).size.width;
    heightscreen = MediaQuery.of(context).size.height;
    locationTex = "dont location";

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

   // LatLng temp = LatLng(widget.temp.lat, widget.temp.lang);


    return Scaffold(
      body: Container(
        color: Colors.green[400],
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: Stack(
                children: [
                  GoogleMap(
                    mapType: _currentMapType,
                    onMapCreated: (GoogleMapController controller) {
                      _controller?.complete(controller);
                    },
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 11.0,
                    ),
                    // compassEnabled: true,
                    markers: _markers,
                    onCameraMove:_onCameraMove,
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
                        setState(() {

                          _onAddMarkerButtonPressed();

                          print("markerId is" + _lastMapPosition.toString());


                        });
                      },
                      //   materialTapTargetSize: MaterialTapTargetSize.padded,
                      //  backgroundColor: Colors.green,
                      icon: const Icon(
                        Icons.add_location,
                        size: 55.0,
                        color: Colors.green,
                      ),
                    ),
                  ),

                ],
              ),
            ),
             Container(
                 child:ElevatedButton(
                onPressed: () {
                  Utils.NavigatorKey.currentState!
                      .pushReplacementNamed('/otp');

                },
                child: Text('Next'),
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                    elevation: 5,
                    fixedSize: Size(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height * 0.06)),
             )
             )
          ],
        ),

        //  clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
    );
  }


}
