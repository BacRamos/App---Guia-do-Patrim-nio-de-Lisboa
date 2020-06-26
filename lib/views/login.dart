import 'package:flutter/material.dart';
import 'package:gpleasymode/models/API.dart';
import 'package:gpleasymode/views/POIView.dart';
import 'package:gpleasymode/views/Recommended.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                color: Colors.orange[800],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Bem-vindo',
                style: Theme.of(context).textTheme.headline2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: TextFormField(
                  controller: userEmailController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.person),
                    labelText: 'Insira o seu email',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: TextFormField(
                  controller: userPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.lock),
                    labelText: 'Insira a sua password',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Atenção"),
                            content: Text("A autenticar o utilizador!"),
                          ));
                  final user = await API().getUser(userEmailController.text);
                  if (user == null) {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Atenção"),
                              content: Text("Email ou password errado!"),
                            ));
                  }

                  if (user.email == userEmailController.text &&
                      user.password == userPasswordController.text) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Recommended(user),
                      ),
                    );
                  } else {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Atenção"),
                              content: Text("Email ou password errado!"),
                            ));
                  }
                },
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  width: 260,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.vpn_key),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Login',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              RaisedButton(
                onPressed: () {},
                color: Theme.of(context).secondaryHeaderColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  width: 260,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.next_week),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Sign up',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ]),
                ),
              )
            ],
          ),
        ));
  }
}
