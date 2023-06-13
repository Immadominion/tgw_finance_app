import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tgw_finance_app/auth_functions_tgw/auth.dart';

class LoginSignUp extends StatefulWidget {
  const LoginSignUp({Key? key, required this.auth, required this.loggedIn})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback loggedIn;

  @override
  _LoginSignUpState createState() => _LoginSignUpState();
}

enum FormType { signup, login }

class _LoginSignUpState extends State<LoginSignUp> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  FormType _form = FormType.login;
  String? _errorMsg;
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return MaterialApp(
      title: 'TGW Finance App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Set default text direction to LTR
      // You can also set this to RTL if your app's default text direction is right-to-left
      // textDirection: TextDirection.ltr,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Login To TGW',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Stack(
              children: <Widget>[
                _buildBody(height, width),
                if (_loading) _showCircularLoading(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(double height, double width) {
    return Form(
      key: _formKey,
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          _showAvatar(height, width),
          _buildEmailField(height, width),
          _buildPasswordField(height, width),
          _buildLoginButton(height, width),
          _buildToggleSignupAndLogin(height, width),
        ],
      ),
    );
  }

  Widget _showAvatar(double height, double width) {
    return Hero(
      tag: 'hero',
      child: Padding(
        padding:
            EdgeInsets.fromLTRB(width * 0.5 - 70, 60, width * 0.5 - 70, 0.0),
        child: const CircleAvatar(
          radius: 70,
          backgroundImage: ExactAssetImage('assets/images/avatar.png'),
          backgroundColor: Colors.black,
        ),
      ),
    );
  }

  Widget _buildEmailField(double height, double width) {
    return Padding(
      padding: EdgeInsets.fromLTRB(width * 0.05, 50, width * 0.05, 0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: Colors.black,
          ),
          hintText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) => value!.isEmpty ? "Email can't be empty." : null,
        onSaved: (value) => _emailController.text = value!,
      ),
    );
  }

  Widget _buildPasswordField(double height, double width) {
    return Padding(
      padding: EdgeInsets.fromLTRB(width * 0.05, 25, width * 0.05, 20),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        obscureText: true,
        autofocus: false,
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.black,
          ),
          hintText: 'Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) =>
            value!.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _passwordController.text = value!,
      ),
    );
  }

  Widget _buildLoginButton(double height, double width) {
    return Padding(
      padding: EdgeInsets.fromLTRB(width * 0.05, 25, width * 0.05, 0),
      child: ElevatedButton(
        onPressed: _validateAndSubmit,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text('Login'),
      ),
    );
  }

  Widget _buildToggleSignupAndLogin(double height, double width) {
    return Padding(
      padding:
          EdgeInsets.fromLTRB(width * 0.05, height * 0.05, width * 0.05, 0),
      child: TextButton(
        onPressed: _toggleFormType,
        child: _form == FormType.login
            ? const Text("Don't have an account? Sign up here.")
            : const Text("Already have an account? Log in here."),
      ),
    );
  }

  void _toggleFormType() {
    _formKey.currentState!.reset();
    _errorMsg = null;
    setState(() {
      _form = _form == FormType.login ? FormType.signup : FormType.login;
    });
  }

  bool _validateAndSave() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _validateAndSubmit() async {
    setState(() {
      _loading = true;
    });
    if (_validateAndSave()) {
      try {
        if (_form == FormType.login) {
          await widget.auth
              .signIn(_emailController.text, _passwordController.text);
        } else {
          await widget.auth
              .signUp(_emailController.text, _passwordController.text);
        }
        widget.loggedIn();
      } catch (e) {
        _displayError(e.toString());
      }
    }
    setState(() {
      _loading = false;
    });
  }

  void _displayError(String error) {
    setState(() {
      _errorMsg = error;
    });
    final snackbar = SnackBar(
      content: Text(_errorMsg!),
      duration: const Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  Widget _showCircularLoading() {
    return const Center(
      child: SpinKitWaveSpinner(
        color: Color.fromARGB(255, 244, 77, 74),
      ),
    );
  }
}
