import 'package:flutter/material.dart';
import 'package:maak/models/appointment.dart';
import 'package:maak/models/service_details.dart';

import 'models/service.dart';

 // ignore: non_constant_identifier_names
 List<Service> DUMMY_SERVICE =  [
 Service(svg: 'assets/svg/Vector_Art_1.svg', color: Colors.green.withOpacity(0.3), title: 'Doctors Service', subtitle:'Doctors Available To Book' ),
   Service(svg: 'assets/svg/Vector_Art2.svg', color: Colors.blue.withOpacity(0.3), title: 'Doctors Service', subtitle:'Doctors Available To Book' )
   ,Service(svg: 'assets/svg/Vector_Art_1.svg', color: Colors.blue.withOpacity(0.3), title: 'Doctors Service', subtitle:'Doctors Available To Book' )
   ,Service(svg: 'assets/svg/Vector_Art_1.svg', color: Colors.green.withOpacity(0.3), title: 'Doctors Service', subtitle:'Doctors Available To Book' )
 ];

List<ServiceDetails> DUMMY_SERVICE_Details =  [
ServiceDetails(svg:'assets/svg/Vector_Art_1.svg' , color:  Colors.green.withOpacity(0.3), title: 'Doctors Service', subtitle: 'Date: 12 June,2021', isDetails: true,isAvailable: true, time: ' Time: 12:00 PM'),
  ServiceDetails(svg:'assets/svg/Vector_Art2.svg' , color:  Colors.blue.withOpacity(0.3), title: 'Doctors Service', subtitle: 'Date: 12 June,2021', isDetails: true,isAvailable: false, time: ' Time: 11:00 PM'),
  ServiceDetails(svg:'assets/svg/Vector_Art_1.svg' , color:  Colors.green.withOpacity(0.3), title: 'Doctors Service', subtitle: 'Date: 12 June,2021', isDetails: true,isAvailable: false, time: ' Time: 8:00 PM'),
  ServiceDetails(svg:'assets/svg/Vector_Art2.svg' , color:  Colors.blue.withOpacity(0.3), title: 'Doctors Service', subtitle: 'Date: 10 June,2021', isDetails: true,isAvailable: true, time: ' Time: 7:00 PM'),
  ServiceDetails(svg:'assets/svg/Vector_Art_1.svg' , color:  Colors.green.withOpacity(0.3), title: 'Doctors Service', subtitle: 'Date: 11 June,2021', isDetails: true,isAvailable: true, time: ' Time: 12:00 PM'),
  ServiceDetails(svg:'assets/svg/Vector_Art_1.svg' , color:  Colors.green.withOpacity(0.3), title: 'Doctors Service', subtitle: 'Date: 15 June,2021', isDetails: true,isAvailable: false, time: ' Time: 5:00 PM'),
  ServiceDetails(svg:'assets/svg/Vector_Art2.svg' , color:  Colors.blue.withOpacity(0.3), title: 'Doctors Service', subtitle: 'Date: 30 June,2021', isDetails: true,isAvailable: false, time: ' Time: 12:00 PM'),
  ServiceDetails(svg:'assets/svg/Vector_Art_1.svg' , color:  Colors.green.withOpacity(0.3), title: 'Doctors Service', subtitle: 'Date: 23 June,2021', isDetails: true,isAvailable: true, time: ' Time: 2:00 PM'),


];

List<Appointment> DUMMY_APPOINTMENT = [
  Appointment(serviceDetails:   ServiceDetails(svg:'assets/svg/Vector_Art2.svg' ,
      color:  Colors.blue.withOpacity(0.3), title: 'Doctors Service', subtitle: 'Date: 23 June,2021',
      isDetails: true,isAvailable: true, time: ' Time: 2:00 PM'),
      address: "Hama,Syria", lat: 33.234, lng: 43.21323),
  Appointment(serviceDetails:   ServiceDetails(svg:'assets/svg/Vector_Art_1.svg' ,
      color:  Colors.green.withOpacity(0.3), title: 'Doctors Service', subtitle: 'Date: 23 June,2021',
      isDetails: true,isAvailable: true, time: ' Time: 2:00 PM'),
      address: "Hama,Syria", lat: 33.234, lng: 43.21323),
  Appointment(serviceDetails:   ServiceDetails(svg:'assets/svg/Vector_Art2.svg' ,
      color:  Colors.blue.withOpacity(0.3), title: 'Doctors Service', subtitle: 'Date: 23 June,2021',
      isDetails: true,isAvailable: true, time: ' Time: 2:00 PM'),
      address: "Hama,Syria", lat: 33.234, lng: 43.21323),
  Appointment(serviceDetails:   ServiceDetails(svg:'assets/svg/Vector_Art_1.svg' ,
      color:  Colors.green.withOpacity(0.3), title: 'Doctors Service', subtitle: 'Date: 23 June,2021',
      isDetails: true,isAvailable: true, time: ' Time: 2:00 PM'),
      address: "Hama,Syria", lat: 33.234, lng: 43.21323),
  Appointment(serviceDetails:   ServiceDetails(svg:'assets/svg/Vector_Art_1.svg' ,
      color:  Colors.green.withOpacity(0.3), title: 'Doctors Service', subtitle: 'Date: 23 June,2021',
      isDetails: true,isAvailable: true, time: ' Time: 2:00 PM'),
      address: "Hama,Syria", lat: 33.234, lng: 43.21323),
  Appointment(serviceDetails:   ServiceDetails(svg:'assets/svg/Vector_Art2.svg' ,
      color:  Colors.blue.withOpacity(0.3), title: 'Doctors Service', subtitle: 'Date: 23 June,2021',
      isDetails: true,isAvailable: true, time: ' Time: 2:00 PM'),
      address: "Hama,Syria", lat: 100.234, lng: 43.21323),
];