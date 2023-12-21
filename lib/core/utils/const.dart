import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibration/vibration.dart';
import 'package:contract_bank/injector.dart';

import '../services/shared_prefrences_service.dart';

///////  STATIC VAIRIABLES ////////
const BASE_URL = 'https://majidmovahedi.liara.run/';
final HEADER_URL = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${prefs.getString(storageDeviceAccessToken)}'
};
late final SharedPreferencesService prefs;
const storageDeviceIsLoggedIn = 'APP_FIRST_OPEN';
const storageDeviceAccessToken = 'ACCESS_TOKEN';
const storageDevicePhoneNumber = 'PHONE_NUMBER';
const storageDevicePassword = 'PASSWORD';
var vibration = Vibration.vibrate(duration: 80);

//////// UI CONSTANTS ///////
const kPrimaryColor = Color(0xff4b8f46);
const kSecondColor = Color(0xffdbe9da);
const kButtonColor = Color(0xffc9da29);
const kBackGroundColor = Color(0xffdcdcdf);

TextStyle kLargeTextStyle = TextStyle(
  color: Colors.black87,
  fontSize: 25.sp,
  fontFamily: 'yekan',
);
TextStyle kMediumTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16.sp,
  fontFamily: 'yekan',
);
TextStyle kOutLineTextStyle = TextStyle(
  color: Colors.black87,
  fontSize: 16.sp,
  fontFamily: 'yekan_outline',
);

final kGreyBoxDecoration = BoxDecoration(
    border: Border.all(color: Colors.grey, width: .7),
    color: kBackGroundColor,
    borderRadius: BorderRadius.circular(16));
final kGreenBoxDecoration = BoxDecoration(
    color: kPrimaryColor, borderRadius: BorderRadius.circular(16));
////////  STATIC FUNCTIONS //////
Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  prefs = await SharedPreferencesService().init();
  injectionSetup();
}
