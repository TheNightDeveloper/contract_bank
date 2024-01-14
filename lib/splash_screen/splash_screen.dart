import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:contracts_bank/config/routes/routes.dart';
import 'package:contracts_bank/core/params/auth_params.dart';
import 'package:contracts_bank/features/article/presentation/provider/article_provider.dart';
import 'package:contracts_bank/features/auth/presentation/provider/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkConnectivityAndFetchData() async {
    /// CHECK WHETHER IS INTERNET CONNECT
    bool networkInfo = await DataConnectionChecker().hasConnection;
    if (!networkInfo) {
      /// INTERNET NOT CONNECT
      netwokErrorDialog();
    } else {
      /// CHECK WHETHER HAS  USER LOGGED IN BEFORE OF IT IS FIRST TIME LAUNCH APPLICATION
      if (prefs.getBool(storageDeviceIsLoggedIn)) {
        /// USER ALREADY LOGGED IN BEFORE AND CONTINIUE TO FETCH DATA
        await fetchData();
      } else {
        /// USER HAS NOT LOGGED IN BEFORE OR IT IS FIRST TIME TO LAUNCH APPLICATION
        /// AND CONTINIUE TO REGISTER
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRoutes.onBoarding, (route) => false);
      }
    }
  }

  Future<void> fetchData() async {
    /// GET DEPENDENCIES
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var articleProvider = Provider.of<ArticleProvider>(context, listen: false);
    String phone_number = prefs.getString(storageDevicePhoneNumber);
    String password = prefs.getString(storageDevicePassword);

    /// WAIT FOR USER LOGIN WITH PREVIUESLY REGISTERED SPECIFICATIONS
    bool userCredential = await authProvider.eitherFailureOrLogin(
        LoginParams(phone_number, password), context);

    /// CHECK WHETHER LOGIN SUCCESSFUL WITH PROVIDED SPECIFICATION
    if (userCredential) {
      /// CHECK WHETHE IS JWT EXPIRED OR NOT
      if (authProvider.user!.access_token ==
          prefs.getString(storageDeviceAccessToken)) {
        /// JWT IS NOT EXPIRED AND GO TO FETCH DATA AND NAVIGATE TO APPLICATION MAIN PAGE
        await articleProvider.fetchData();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRoutes.skeletonPage, (route) => false);
      } else {
        /// JWT IS EXPIRED AND USER MUST LOGIN OR REGISTER AGAIN
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRoutes.loginPage, (route) => false);
      }
    } else {
      /// If for any reason the user fails to login NAVIGATE TO LOGIN PAGE
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRoutes.onBoarding, (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    checkConnectivityAndFetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      color: kPrimaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox.shrink(),
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 4),
                    blurRadius: 5,
                    spreadRadius: 1,
                  )
                ],
                image: const DecorationImage(
                    image: AssetImage('assets/img/logo.png'),
                    fit: BoxFit.cover)),
          ),
          const SpinKitThreeBounce(
            color: Colors.white,
            size: 30.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'مخزن قرارداد ها',
                style: kMediumTextStyle.copyWith(
                    color: Colors.white,
                    fontSize: 18.sp,
                    decoration: TextDecoration.none),
              ),
              Text('بانک جامع نمونه قرارداد حقوقی',
                  style: kMediumTextStyle.copyWith(
                      color: Colors.white.withOpacity(.6),
                      fontSize: 18.sp,
                      // fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none)),
              Text('v 1.0.1',
                  style: kMediumTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 12.sp,
                      // fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none))
            ],
          )
        ],
      ),
    );
  }

  Future<dynamic> netwokErrorDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Dialog(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(12, 26),
                          blurRadius: 50,
                          spreadRadius: 0,
                          color: Colors.grey.withOpacity(.1)),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: Icon(
                        Icons.network_check,
                        color: kPrimaryColor,
                        size: 50,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text("به اینترنت متصل نیستید",
                        style: kMediumTextStyle.copyWith(
                            fontSize: 22.sp, color: Colors.black87)),
                    const SizedBox(
                      height: 3.5,
                    ),
                    Text("برای استفاده از اپلیکیشن اینترنت خود را روشن کنید",
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style:
                            kMediumTextStyle.copyWith(color: Colors.black54)),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutes.initial, (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        child: Text(
                          'تلاش مجدد',
                          style: kMediumTextStyle,
                        ))
                  ],
                ),
              ),
            ));
  }
}
