import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Helper/Constant.dart';
import 'Helper/SharedManaged.dart';
import 'Screens/LoginScreen/LoginPage.dart';
import 'Screens/OrderDetailsScreen/OrderDetailsScreen.dart';
import 'Screens/TabBarScreens/DashboardScreen/DashboardScreen.dart';
import 'Screens/TabBarScreens/OrdersScreen/OrdersScreen.dart';
import 'Screens/TabBarScreens/TabbarScreen/TabbarScreen.dart';
import 'generated/i18n.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

NotificationAppLaunchDetails notificationAppLaunchDetails;

AndroidNotificationChannel channel;

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

Future<void> main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
  // of the `IOSFlutterLocalNotificationsPlugin` class
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
  });

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: SharedManager.shared.locale,
        builder: (context, Locale value, _) {
          print(value);
          return MaterialApp(
            // initialRoute:'/LoginPage',
            // onGenerateRoute: RouteGenerator.generateRoute,
            debugShowCheckedModeBanner: false,
            locale: value,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            localeListResolutionCallback:
                S.delegate.listResolution(fallback: const Locale('en', '')),
            color: Colors.blue,
            home: new Splash(),
          );
        });
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  void _requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> _showNotification(String title, String message) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, '$title', '$message', platformChannelSpecifics,
        payload: 'item x');
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _seen = prefs.getString('isLoogedIn');

    if (_seen == "yes") {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => TabbarScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    _requestIOSPermissions();
    super.initState();
    // FirebaseApp.initializeApp(this);
    new Timer(new Duration(milliseconds: (Platform.isAndroid ? 2000 : 100)),
        () {
      checkFirstSeen();
    });
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        // final message1 = message.;
        // final title = message['notification']['title'];
        // print("Notification Message:$message1");
        // // displayTostForNotification(message1, myContext);
        // _showNotification(title, message1);

        // DashboardScreen().updateOrder();
        // OrdersScreen().updateOrder();
        // OrderDetailsScreen().updateOrder();
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
      DashboardScreen().updateOrder();
      OrdersScreen().updateOrder();
      OrderDetailsScreen().updateOrder();
    });
    // _firebaseMessaging.(
    //   onMessage: (Map<String, dynamic> message) {
    //     // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    //     // SharedManager.shared.isNotificationComes = true;
    //     final message1 = message['notification']['body'];
    //     final title = message['notification']['title'];
    //     print("Notification Message:$message1");
    //     // displayTostForNotification(message1, myContext);
    //     _showNotification(title, message1);

    //     DashboardScreen().updateOrder();
    //     OrdersScreen().updateOrder();
    //     OrderDetailsScreen().updateOrder();

    //     return;
    //   },
    // );
    _firebaseMessaging.requestPermission(sound: true, badge: true, alert: true);
    _firebaseMessaging.getToken().then((String token) async {
      assert(token != null);
      print(token);
      SharedManager.shared.token = token;
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString(token,DefaultKeys.pushToken);
    });

    /*Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new SecondScreen(payload)),
    );*/
  }

  displayTostForNotification(String message, BuildContext myContext) async {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future onDidRecieveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
  }
  // Notifier notifier;

  @override
  Widget build(BuildContext context) {
    // notifier = NotifierProvider.of(context);
    return new Scaffold(
      body: new Center(
          child: Platform.isAndroid
              ? new Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: new BorderRadius.circular(75),
                      image: DecorationImage(image: AppImages.appLogo)),
                )
              : new Text('')),
    );
  }
}
