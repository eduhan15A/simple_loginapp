import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'HomeScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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

  void _registerAccount() async{
    if (_formValidate()){
      try {
        print("UserName:"+ _userName);
        print("Password:"+ _password);
        FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _userName,password: _password);
        print ("Create user Ok: ${user.uid}");
        Navigator.pop(context);
      } catch (e) {
        print("AuthError: $e");
      }

    }
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
      appBar: AppBar(title: Text("Register Screen"),),
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
              child: Text('Crear Usuario'),
              onPressed: () => _registerAccount(),
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            elevation: 7.0,
          ),
          FlatButton(
          child: Text('Ya tienes cuenta? Iniciar sesión'),
    onPressed: () => Navigator.pop(context)

          )


        ],
      ),
    );
  }//Widget
}
