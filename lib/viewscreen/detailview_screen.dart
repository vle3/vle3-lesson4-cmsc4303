import 'package:flutter/material.dart';
import 'package:lesson4/model/photomemo.dart';

class DetailViewScreen extends StatefulWidget {
  static const routeName = '/detailViewScreen';
  final PhotoMemo photoMemo;

  const DetailViewScreen({required this.photoMemo, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailViewState();
  }
}

class _DetailViewState extends State<DetailViewScreen> {
  late _Controller con;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail View',
        ),
      ),
      body: Text('detail view: ${widget.photoMemo.title}'),
    );
  }
}

class _Controller {
  _DetailViewState state;
  _Controller(this.state);
}
