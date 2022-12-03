import 'package:flutter/material.dart';

class MyInventoryScreen extends StatefulWidget {
  static const routeName = '/myInventoryScreen';

  const MyInventoryScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyInventoryState();
  }
}

class _MyInventoryState extends State<MyInventoryScreen> {
  late _Controller con;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Inventory',
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'Add new item',
                    ),
                    content: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Item name',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: con.addButton,
                        child: const Text(
                          'Add',
                        ),
                      ),
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  );
                });
          },
          child: const Icon(Icons.add),
        ));
  }
}

class _Controller {
  _MyInventoryState state;
  _Controller(this.state);

  void addButton() {}
}
