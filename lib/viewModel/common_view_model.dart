import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../global/global_vars.dart';

class CommonViewModel{


  getCurrentLocation()async{

    Position cPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    position = cPosition;
    placeMark = await placemarkFromCoordinates(cPosition.latitude, cPosition.longitude);
    Placemark placeMarkVar = placeMark![0];

    fullAddress = "${placeMarkVar.subThoroughfare} ${placeMarkVar.thoroughfare},${placeMarkVar.subLocality} ${placeMarkVar.locality},${placeMarkVar.subAdministrativeArea},${placeMarkVar.administrativeArea} ${placeMarkVar.postalCode}, ${placeMarkVar.country}";

    return fullAddress;
  }

  showSnackBar(String message, BuildContext context){
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}