// Task 1 - Login Page with TextField for username and password

import 'dart:convert';
import 'package:crud_app/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var userNameTextField;
  var passwordTextField;

  var responseMessage;

  final _formKey = GlobalKey<FormState>();

  // void showToast(String message) {
  //   Fluttertoast.showToast(
  //       msg: "This is Center Short Toast",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }

  // login api call function
  loginCall() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'PATCH',
        Uri.parse(
            'https://glexas.com/hostel_data/API/raj/new_admission_update.php'));
    request.body = json.encode({
      "username": "${userNameTextField.toString()}",
      "password": "${passwordTextField.toString()}"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());

      // responseMessage = await response.stream.bytesToString();
      // showToast(responseMessage.toString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Task 1',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  height: 24.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    color: connected ? Colors.green : Colors.red,
                    child: Center(
                      child: Text("${connected ? 'ONLINE' : 'OFFLINE'}"),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // Username text field
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  labelText: 'Username',
                                  hintText: 'Enter your Username',
                                  prefixIcon: Icon(
                                    Icons.person,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (String value) {},
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    userNameTextField = value;
                                    return 'Please enter Username';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(
                                height: 10.0,
                              ),

                              // Password Text Field
                              TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  hintText: 'Enter your Password',
                                  prefixIcon: Icon(
                                    Icons.lock,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (String value) {},
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    passwordTextField = value;
                                    return 'Please enter Password';
                                  }
                                  return null;
                                },
                              ),
                              MaterialButton(
                                height: 40,
                                minWidth: double.infinity,
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // Login Post request
                                    loginCall();

                                    // Navigation to HomePage
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const MaterialApp(
                                          home: HomePage(),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                color: Colors.blue,
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'There are no bottons to push :)',
              ),
              Text(
                'Just turn off your internet.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
