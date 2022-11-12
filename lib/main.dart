import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lesson4/model/photomemo.dart';
import 'package:lesson4/viewscreen/createaccount_screen.dart';
import 'package:lesson4/viewscreen/detailview_screen.dart';
import 'package:lesson4/viewscreen/sharedwith_screen.dart';
import 'package:lesson4/viewscreen/startdispatcher.dart';
import 'package:lesson4/viewscreen/view/createphotomemo_screen.dart';
import 'package:lesson4/viewscreen/view/error_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const PhotoMemoApp());
}

class PhotoMemoApp extends StatelessWidget {
  const PhotoMemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: StartDispatcher.routeName,
      routes: {
        StartDispatcher.routeName: (context) => const StartDispatcher(),
        CreatePhotoMemoScreen.routeName: (context) =>
            const CreatePhotoMemoScreen(),
        SharedWithScreen.routeName: (context) => const SharedWithScreen(),
        DetailViewScreen.routeName: (context) {
          Object? args = ModalRoute.of(context)?.settings.arguments;
          if (args == null) {
            return const ErrorScreen('arg is null from HomeScreen');
          } else {
            var photoMemo = args as PhotoMemo;
            return DetailViewScreen(photoMemo: photoMemo);
          }
        },
        CreateAccountScreen.routeName: (context) => const CreateAccountScreen(),
      },
    );
  }
}
