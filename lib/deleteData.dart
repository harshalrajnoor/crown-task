import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeleteData extends StatefulWidget {
  const DeleteData({super.key});

  @override
  State<DeleteData> createState() => _DeleteDataState();
}

class _DeleteDataState extends State<DeleteData> {
  final _formKey = GlobalKey<FormState>();
  var registration_main_id = "";

  deleteData() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'DELETE',
        Uri.parse(
            'https://glexas.com/hostel_data/API/raj/new_admission_delete.php'));
    request.body =
        json.encode({"registration_main_id": "$registration_main_id"});
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
            'Update Data',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
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
                              labelText: 'Registration Main ID',
                              hintText: 'Enter Registration Main ID',
                              prefixIcon: Icon(
                                Icons.app_registration,
                              ),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              registration_main_id = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Registration Main ID';
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
                                deleteData();
                                Navigator.pop(context);
                              }
                            },
                            color: Colors.blue,
                            child: const Text(
                              'Submit',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
