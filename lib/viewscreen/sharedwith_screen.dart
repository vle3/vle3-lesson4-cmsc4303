// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:lesson4/controller/auth_controller.dart';
import 'package:lesson4/controller/firestore_controller.dart';
import 'package:lesson4/model/constants.dart';
import 'package:lesson4/model/sharedwithscreen_model.dart';

class SharedWithScreen extends StatefulWidget {
  static const routeName = '/sharedWithScreen';

  const SharedWithScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SharedWithState();
  }
}

class _SharedWithState extends State<SharedWithScreen> {
  late _Controller con;
  late SharedWithScreenModel screenModel;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
    screenModel = SharedWithScreenModel(user: Auth.user!);
    con.loadSharedWithList();
  }

  void render(fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shared With: ${screenModel.user.email}',
        ),
      ),
      body: bodyView(),
    );
  }

  Widget bodyView() {
    if (screenModel.loadingErrorMessage != null) {
      return Text(
          'SharedWith List loaidng error\n ${screenModel.loadingErrorMessage}');
    } else if (screenModel.sharedWithList == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SingleChildScrollView(
        child: Column(children: [
          for (var photoMemo in screenModel.sharedWithList!)
            Text('${photoMemo.title}'),
        ]),
      );
    }
  }
}

class _Controller {
  _SharedWithState state;
  _Controller(this.state);

  Future<void> loadSharedWithList() async {
    try {
      state.screenModel.sharedWithList =
          await FirestoreController.getSharedWithList(
              email: state.screenModel.user.email!);
      //await Future.delayed(const Duration(seconds: 3)); //testing purpose
      state.render(() {
        state.screenModel.loadingErrorMessage = null;
      });
    } catch (e) {
      state.render(() {
        state.screenModel.loadingErrorMessage =
            'Internal Loading error. Restart the app\n $e';
      });
      if (Constant.devMode) print('=========== getSharedWith error: $e');
    }
  }
}
