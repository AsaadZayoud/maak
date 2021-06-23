import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:maak/providers/auth_provider.dart';
import 'package:maak/providers/language_provider.dart';
import "dart:async";
import "package:google_maps_webservice/places.dart";
import "package:flutter_google_places/flutter_google_places.dart";
import 'dart:ui' as ui;

import 'package:maak/providers/utils.dart';
import 'package:provider/provider.dart';
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

  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: " AIzaSyAOx7d6re9a-HN200-BfkDCCnzendmhq3A");
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
    getaddress();
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
  Future<String> getaddress() async {
     coordinates = await new Coordinates(_lastMapPosition.latitude, _lastMapPosition.longitude);
    var addresses =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    locationTex = " ${first.addressLine}";

    print("${first.postalCode } : ${first.addressLine}");
    return "${first.featureName}";
  }

  Future<void> handlePressButton() async {
    try {

      Prediction? p = await PlacesAutocomplete.show(
          context: context,
          strictbounds: _center == null ? false : true,
          apiKey: "AIzaSyCykaQAJWh7T33fy95TzqLfOFTCgWwmtDQ",

          mode: Mode.fullscreen,


          radius: _center == null ? null : 10000);
      print("this is place ${p!.placeId}");
    } catch (e) {
      return;
    }
  }
  Future displayPrediction(Prediction p) async {
        print('this P $p');

     try {
       PlacesDetailsResponse detail =
       await _places.getDetailsByPlaceId(p.placeId!);

       var placeId = p.placeId;
       double lat = detail.result.geometry!.location.lat;
       double lng = detail.result.geometry!.location.lng;

       var address = await Geocoder.local.findAddressesFromQuery(p.description);

       print(lat);
       print(lng);
     }catch(error){
       print('asaad');
     }
  }

  @override
  initState() {
    getaddress();

    _center =
        LatLng(widget.locationData!.latitude, widget.locationData!.longitude);

    _markers.add(
      Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _center,
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



    var lan = Provider.of<LanguageProvider>(context, listen: true);
    var isAuth = Provider.of<AuthProvider>(context, listen: true).isAuth;
    widthscreen = MediaQuery.of(context).size.width;
    heightscreen = MediaQuery.of(context).size.height;

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    // LatLng temp = LatLng(widget.temp.lat, widget.temp.lang);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {

              var city;
              Prediction? p = await PlacesAutocomplete.show(
                  offset: 0,
                  radius: 1000,
                  strictbounds: false,
                  region: "us",
                  language: "en",
                  context: context,
                  mode: Mode.overlay,
                 // "AIzaSyCykaQAJWh7T33fy95TzqLfOFTCgWwmtDQ"

                  apiKey: " AIzaSyAOx7d6re9a-HN200-BfkDCCnzendmhq3A",
                  components: [new Component(Component.country, "us")],
                  types: ["(cities)"],
                  hint: "Search City",
                  startText: city == null || city == "" ? "" : city
              );

              displayPrediction(p!);
            },
          ),
        ],),
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
                      onCameraMove: _onCameraMove,
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
                              height: MediaQuery.of(context).size.height * 0.18,
                              child:
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                     Text('${locationTex}',style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),),
                                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                      Text("${coordinates}",style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold)),
                                    ],
                                  )


                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: Container(
                                    child: SvgPicture.asset(
                                      'assets/svg/x.svg',
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Utils.NavigatorKey.currentState!.pushReplacementNamed("/otp");
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
