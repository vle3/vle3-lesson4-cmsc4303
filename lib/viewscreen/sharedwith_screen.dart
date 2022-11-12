import 'package:flutter/material.dart';
import 'package:lesson4/controller/auth_controller.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shared With',
        ),
      ),
    );
  }
}

class _Controller {
  _SharedWithState state;
  _Controller(this.state);
}
