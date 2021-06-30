import 'package:maak/models/service_details.dart';
import 'package:flutter/material.dart';
class Appointment{
  ServiceDetails serviceDetails = ServiceDetails(svg: '', color: Colors.red, title: '', subtitle: '', isDetails: true, time: '', isAvailable: true);
  String address = '';
  double lat = 0.0;
  double  lng = 0.0;

  Appointment({required  this.serviceDetails,required this.address,required this.lat,required this.lng});

}