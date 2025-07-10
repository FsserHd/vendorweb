import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:vendor/pages/orders/mobile/mobile_order_page.dart';
import 'package:vendor/pages/splash/splash_screen.dart';
import 'package:vendor/utils/preference_utils.dart';
import 'package:vendor/utils/validation_utils.dart';

import 'PushNotifications.dart';
import 'constants/app_colors.dart';
import 'constants/app_style.dart';
import 'firebase/firebase_options.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'language/app_localizations.dart';
import 'model/firebase/firebase_order_response.dart';
import 'navigation/navigation_service.dart';


final navigatorKey = GlobalKey<NavigatorState>();

// function to lisen to background changes
@pragma('vm:entry-point')
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  print("hjellasdfs");
  playSound();
  print("Handling a background message: ${message.messageId}");
  if (message.notification != null) {
    print("Some notification Received");
  }
}

final AudioPlayer _audioPlayer = AudioPlayer();
bool isPlaying = false;

playSound() async {
  await _audioPlayer.play(AssetSource("sound/alert.mp3"));
}

// to handle notification on foreground on web platform
void showNotification({required String title, required String body}) {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok"))
      ],
    ),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // on background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("Background Notification Tapped");
    if (message.notification != null) {
      print("Background Notification Tapped");
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    }
  });

  PushNotifications.init();
  // only initialize if platform is not web
  if (!kIsWeb) {
    PushNotifications.localNotiInit();
  }
  // Listen to background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  // to handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("hello");
    // String payloadData = jsonEncode(message.data);
    // print("Got a message in foreground");
    // if (message.notification != null) {
    //   if (kIsWeb) {
    //     FirebaseOrderResponse firebaseOrderResponse = FirebaseOrderResponse();
    //     firebaseOrderResponse.type = message.data['type'];
    //     firebaseOrderResponse.orderid = message.data['orderid'];
    //     firebaseOrderResponse.message = message.data['message'];
    //     if(firebaseOrderResponse.type == "order_message" ) {
    //       showSimpleNotification(
    //         Text("New Order Note Message\n#${firebaseOrderResponse.orderid} \n${firebaseOrderResponse.message}"),
    //         leading: Icon(Icons.add_alert, color: Colors.white),
    //         background: Colors.green,
    //         duration: Duration(seconds: 3),
    //       );
    //     }
    //   }
    // }
  });

  // for handling in terminated state
  final RemoteMessage? message =
  await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Launched from terminated state");
    Future.delayed(Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: GlobalLoaderOverlay(
        overlayColor: Colors.grey.withOpacity(0.5),
        useDefaultLoading: false,
        overlayWidgetBuilder: (_) { //ignored progress for the moment
          return Center(
            child: SpinKitThreeBounce(
              color: AppColors.themeColor,
              size: 50.0,
            ),
          );
        },
        child: MaterialApp(
          navigatorKey: NavigationService.navigatorKey, // set property
          locale: Locale('en'), // Default locale
          supportedLocales: [
            Locale('en', ''),
            Locale('es', ''),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData(brightness: Brightness.light),
          themeMode: ThemeMode.light,
          title: 'Thee4square',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.themeColor),
              useMaterial3: true,
              fontFamily: AppStyle.robotoRegular
          ),
          home: SplashScreen(),
        ),
      ),
    );
  }
}