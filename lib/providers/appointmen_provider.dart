import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maak/models/appointment.dart';
import 'package:maak/models/service_details.dart';
import '../dummy_data.dart';

class appointmenProvider with ChangeNotifier {
  List<Appointment> _appointment = [];
  String address = '';
  double lat = 0.0;
  double lng = 0.0;
  ServiceDetails _serviceDetails = ServiceDetails(
      svg: '',
      color: Colors.red,
      title: '',
      subtitle: '',
      isDetails: true,
      time: '',
      isAvailable: true);

  void serviceDetails(ServiceDetails value) async {
    _serviceDetails = value;
  }

  void setaddress(String address, double lat, double lng) {
    this.address = address;
    this.lat = lat;
    this.lng = lng;
    print('${this.address} ${_serviceDetails.title}');
  }

  void setAppointment() async {
    try {
      DUMMY_APPOINTMENT.add(Appointment(
          serviceDetails: _serviceDetails,
          lng: this.lng,
          lat: this.lat,
          address: this.address));
      print('${DUMMY_APPOINTMENT.last}');
    } catch (error) {
      print(error);
    }
  }

  Future<List<Appointment>> getAppointment() async {
    try {
      _appointment = await DUMMY_APPOINTMENT;
      notifyListeners();
      return _appointment;
    } catch (e) {
      print('error in appointment');
      throw e;
    }
  }
}
