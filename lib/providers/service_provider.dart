import 'package:flutter/foundation.dart';
import 'package:maak/models/service.dart';
import 'package:maak/models/service_details.dart';

import '../dummy_data.dart';

class ServiceProvider with ChangeNotifier{

  List<Service> _availableService = [];

  List<ServiceDetails> _serviceDetails= [];


  Future<List<Service>> available() async{
  try {

    _availableService =await DUMMY_SERVICE;
    notifyListeners();
return _availableService;
  }
  catch (e) {
    print('no');
    throw e;
  }
  }
  Future<List<ServiceDetails>> availableSer() async{
    _serviceDetails = await DUMMY_SERVICE_Details;

    return _serviceDetails;
  }

}