import 'package:flutter/material.dart';
class ServiceDetails {
  String svg = '';
  Color color = Colors.green;
  String title = '';
  String subtitle = '';
  bool  isDetails = false;
  String time = '';
  bool isAvailable = false;

  ServiceDetails(
  {required this.svg,required this.color,required this.title,required this.subtitle,required this.isDetails,required this.time, required this.isAvailable});

}