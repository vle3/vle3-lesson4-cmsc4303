import 'package:flutter/material.dart';
import 'package:lesson4/controller/auth_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeScreen> {
  late _Controller con;

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
          'Home',
        ),
      ),
      drawer: drawerView(),
      body: Text('home: ${Auth.user?.email!}'),
    );
  }

  Widget drawerView() {
    return Drawer(
      child: ListView(children: [
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Sign out'),
          onTap: con.signOut,
        )
      ]),
    );
  }
}

class _Controller {
  _HomeState state;
  _Controller(this.state);

  void signOut() {
    Auth.signOut();
  }
}