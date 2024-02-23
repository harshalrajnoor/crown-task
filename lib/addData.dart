import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crud_app/updateData.dart';
import 'package:crud_app/deleteData.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final _formKey = GlobalKey<FormState>();

  var user_code = "";
  var first_name = "";
  var middle_name = "";
  var last_name = "";
  var phone_number = "";
  var phone_country_code = "";
  var email = "";

  postData() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://glexas.com/hostel_data/API/raj/new_admission_insert.php'));
    request.body = json.encode({
      "user_code": "${user_code.toString()}",
      "first_name": "${first_name.toString()}",
      "middle_name": "${middle_name.toString()}",
      "last_name": "${last_name.toString()}",
      "phone_number": "${phone_number.toString()}",
      "phone_country_code": "+${phone_country_code.toString()}",
      "email": "${email.toString()}"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: const Text(
            'Insert Data',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
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
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'User Code',
                            hintText: 'Enter Your Code',
                            prefixIcon: Icon(
                              Icons.numbers,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            user_code = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter User Code';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                            hintText: 'Enter Your First Name',
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            first_name = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter your First Name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: 'Middle Name',
                            hintText: 'Enter Your Middle Name',
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            middle_name = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter your Middle Name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                            hintText: 'Enter Your Last Name',
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            last_name = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter your Last Name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            hintText: 'Enter Your Phone Number',
                            prefixIcon: Icon(
                              Icons.phone,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            phone_number = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Phone Number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Country Code',
                            hintText: 'Enter Your Country Code',
                            prefixIcon: Icon(
                              Icons.place,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            phone_country_code = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Your Country Code';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter Your Email',
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            email = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        MaterialButton(
                          height: 40,
                          minWidth: double.infinity,
                          onPressed: () {
                            if (_formKey.currentState!.validate() == true) {
                              postData();
                              Navigator.pop(context);
                            }
                          },
                          color: Colors.blue,
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        MaterialButton(
                          height: 40,
                          minWidth: double.infinity,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UpdateData(),
                              ),
                            );
                          },
                          color: Colors.blue,
                          child: const Text(
                            'Update Data',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                        MaterialButton(
                          height: 40,
                          minWidth: double.infinity,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DeleteData(),
                              ),
                            );
                          },
                          color: Colors.blue,
                          child: const Text(
                            'Delete Data',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
