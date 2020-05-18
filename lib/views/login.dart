import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gpl/models/api.dart';
import 'package:gpl/models/user.dart';
import 'package:gpl/services/apiService.dart';
import 'package:gpl/views/showAllPOI.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  APIService get service => GetIt.I<APIService>();
  APIResponse<User> _api;
  bool _validated = false;
  APIResponse<int> loggedUser;
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  _fetchUserID(String email) async {
    setState(() {
      _validated = false;
    });

    loggedUser = await service.getIdFromEmail(email);
    print(loggedUser);
    _api = await service.getUsers(loggedUser.data);
    if (userNameController.text == _api.data.userEmail &&
        userPasswordController.text == _api.data.userPassword) {
      setState(() {
        _validated = true;
      });
    }
  }

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
                height: 250,
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
                  controller: userNameController,
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
                onPressed: () {
                  _fetchUserID(userNameController.text).then(() {
                    print('hello');
                  });
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 106.0),
                  child: Text(
                    'Sign up',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
