import 'package:flutter/material.dart';
import 'package:test_project/models/enums.dart';
import 'package:test_project/providers/api_provider.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget(
      {Key? key, required this.onNavigatePages, required this.onTokenAcquired})
      : super(key: key);

  final Function(Views) onNavigatePages;
  final Function(String) onTokenAcquired;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late String _email = '';
  late String _password = '';

  void _processLogin() async {
    if (_email.isNotEmpty && _password.isNotEmpty) {
      widget.onNavigatePages(Views.loading);
      var loginResponse = await APIProvider.login(_email, _password);
      widget.onTokenAcquired(loginResponse.result!.ssAuthToken!);
      widget.onNavigatePages(Views.feed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(
                    top: 35,
                  ),
                  child: Text(
                    'LOG IN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter a valid email',
                    ),
                    onChanged: (value) => {
                      _email = value,
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: 15,
                    bottom: 0,
                  ),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter a valid password',
                    ),
                    onChanged: (value) => {
                      _password = value,
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 60,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      _processLogin();
                    },
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
