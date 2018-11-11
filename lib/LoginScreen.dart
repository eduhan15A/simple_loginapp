import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'HomeScreen.dart';
import 'RegisterScreen.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _userName;
  String _password;
  final _formKey = GlobalKey<FormState>();

  bool _formValidate(){
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
      return true;
    }
          else{
            return false;
    }
  }

  void _loginAuth() async{

    if(_formValidate()){
      print("Username: $_userName");
      print("Password: $_password");
      //Firebase authentication
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _userName, password: _password);
        print("Signed In Ok: ${user.uid}");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen(userName: _userName,)));
      }catch(ex){print("Error: $ex");}


    }


  }
  void _registerAccount() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => RegisterScreen()));
  }
  @override
  Widget build(BuildContext context) {
    String _validateEmail(String value) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(value))
        return 'El Email no es válido';
      else
        return null;
    }

    String _validatePassword(String value) {
      if (value.isEmpty)
        return "Escriba una contraseña";
      else if (value.length < 6)
        return "La contraseña debe tener por lo menos 6 caracteres";
      else
        return null;
    }

    return Scaffold(
      appBar: AppBar(title: Text("Login Screen"),),
      body: ListView(
        padding: EdgeInsets.all(32.0),
        children: <Widget>[
          SizedBox(height: 80.0,),
          FlutterLogo(size:100.0),
          Center(child: Text("Simple Login App", style: TextStyle(fontSize: 20.0,),)),
          SizedBox(height: 80.0,),
          Form(
            key: _formKey,
            child:Column(
                children: <Widget>[
                  TextFormField(
                   decoration: InputDecoration(
                     labelText: 'Email',
                   ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (input) => _validateEmail(input),
                    onSaved: (input) => _userName = input,

                  ),
                  SizedBox(height: 15.0,),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    validator: (input) => _validatePassword(input),
                    onSaved: (input) => _password = input,
                  )
                ],

            ),

          ),
          SizedBox(height: 15.0,),
          RaisedButton(
            child: Text('Entrar'),
            onPressed: () => _loginAuth(),
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            elevation: 7.0,
          ),
          FlatButton(
            child: Text('¿No tiene cuenta? Regístrate'),
              onPressed: () => _registerAccount()

          )


        ],
      ),
    );
  }//Widget
}
