import 'package:flutter/material.dart';
import 'package:lesson4/controller/auth_controller.dart';
import 'package:lesson4/model/signin_screen_model.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignInScreen> {
  late _Controller con;
  late SignInScreenModel screenModel;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
    screenModel = SignInScreenModel();
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign In',
        ),
      ),
      body: signInForm(),
    );
  }

  Widget signInForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(children: [
            Text(
              'PhotoMemo',
              style: Theme.of(context).textTheme.headline3,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Email address',
              ),
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              validator: screenModel.validateEmail,
              onSaved: screenModel.saveEmail,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
              autocorrect: false,
              obscureText: true,
              validator: screenModel.validatePassword,
              onSaved: screenModel.savePassword,
            ),
            ElevatedButton(
              onPressed: con.signIn,
              child: Text(
                'Sign In',
                style: Theme.of(context).textTheme.button,
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class _Controller {
  _SignInState state;
  _Controller(this.state);

  Future<void> signIn() async {
    FormState? currentState = state.formKey.currentState;
    if (currentState == null) return;
    if (!currentState.validate()) return;
    currentState.save();

    try {
      await Auth.signIn(
          email: state.screenModel.email!,
          password: state.screenModel.password!);
    } catch (e) {
      print('$e');
    }
  }
}
