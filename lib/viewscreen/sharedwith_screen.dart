// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:lesson4/controller/auth_controller.dart';
import 'package:lesson4/controller/firestore_controller.dart';
import 'package:lesson4/model/constants.dart';
import 'package:lesson4/model/photomemo.dart';
import 'package:lesson4/model/sharedwithscreen_model.dart';
import 'package:lesson4/viewscreen/view/webimage.dart';

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

  Widget photoMemoCardView(PhotoMemo photoMemo) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WebImage(
              url: photoMemo.photoURL,
              context: context,
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            Text(
              photoMemo.title,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(photoMemo.memo),
            Text('Created by: ${photoMemo.createdBy}'),
            Text('Posted At:  ${photoMemo.timestamp}'),
            Text('Shared With: ${photoMemo.sharedWith}'),
          ],
        ),
      ),
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
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (screenModel.sharedWithList!.isEmpty)
                Text(
                  'No shared photomemo found',
                  style: Theme.of(context).textTheme.headline6,
                )
              else
                for (var photoMemo in screenModel.sharedWithList!)
                  photoMemoCardView(photoMemo),
            ],
          ),
        ),
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
