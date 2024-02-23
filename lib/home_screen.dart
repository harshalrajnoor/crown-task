// Task 6 - Fetch data from api and implement search sort and filter

import 'dart:convert';
import 'package:crud_app/addData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:crud_app/deleteData.dart';
import 'package:crud_app/updateData.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This list contains all the users
  List<dynamic> users = [];

  // This list contains the users after searching
  List<dynamic> foundUsers = [];

  // This list contains the result of search
  List<dynamic> result = [];

  // Filter Bool variables;
  bool filter1 = false;
  bool filter2 = false;
  bool filter3 = false;

  // variable for sorting the list
  bool isDescending = false;

  // delete function variable
  var registration_main_id = "";

  // Slidable Update Variables
  var slidableRegistrationMainID = "";
  var slidableUserCode = "";
  var slidableFirstName = "";
  var slidableMiddleName = "";
  var slidableLastName = "";
  var slidablePhoneNo = "";
  var slidableCountryCode = "";
  var slidableEmail = "";

  void _runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      result = users;
    } else {
      result = users
          .where((user) => user["first_name"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      foundUsers = result;
    });
  }

  void filterList(String enteredKeyword) {
    result = users
        .where((user) => user["first_name"]
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase()))
        .toList();

    // Refresh the UI
    setState(() {
      foundUsers = result;
    });
  }

  void fetchUsers() async {
    print('Fetch Users Called');
    final uri = Uri.parse(
        'https://glexas.com/hostel_data/API/raj/new_admission_list.php');
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['response'];
    });
    print('Fetch Users Completed');
    foundUsers = users;
  }

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
  void initState() {
    // TODO: implement initState
    fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          'Task 6',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddData(),
            ),
          );
        },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                hintText: "Search",
                suffixIcon: const Icon(Icons.search),
                // prefix: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilterChip(
                    label: const Text('Filter 1'),
                    onSelected: (bool value) {
                      setState(() {
                        filter1 = !filter1;
                        filter2 = false;
                        filter3 = false;
                        filterList('admin');
                      });
                    },
                    selected: filter1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilterChip(
                    label: const Text('Filter 2'),
                    onSelected: (bool value) {
                      setState(() {
                        filter2 = !filter2;
                        filter1 = false;
                        filter3 = false;
                        filterList('student');
                      });
                    },
                    selected: filter2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilterChip(
                    label: const Text('Filter 3'),
                    onSelected: (bool value) {
                      setState(() {
                        filter3 = !filter3;
                        filter1 = false;
                        filter2 = false;
                        filterList('meet');
                      });
                    },
                    selected: filter3,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isDescending = !isDescending;
                      });
                    },
                    child: Icon(Icons.sort))
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: foundUsers.length,
                itemBuilder: (context, index) {
                  //
                  // Sorting the list
                  final sortedUsers =
                      isDescending ? foundUsers.reversed.toList() : foundUsers;

                  // List for card
                  final user = sortedUsers[index];
                  // print(users);
                  final regId = user['registration_main_id'];
                  final firstName = user['first_name'];
                  final middleName = user['middle_name'];
                  final lastName = user['last_name'];
                  final userCode = user['user_code'];
                  final phoneNo = user['phone_number'];
                  final phoneCountryCode = user['phone_country_code'];
                  final email = user['email'];
                  final time = user['created_time'];

                  // Slidable
                  return Slidable(
                    // key: Key(index.toString()),
                    key: UniqueKey(),

                    startActionPane: ActionPane(
                      motion: const BehindMotion(),
                      dismissible: DismissiblePane(onDismissed: () {
                        registration_main_id = regId;
                        deleteData();
                      }),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DeleteData(),
                              ),
                            );
                          },
                          // An action can be bigger than the others.
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UpdateData(),
                              ),
                            );
                          },
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          icon: Icons.update,
                          label: 'Update',
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpansionTile(
                          subtitle: Text(
                              'Name: ${firstName.toString().toLowerCase()} ${middleName.toString().toLowerCase()} ${lastName.toString().toLowerCase()}',
                              style: TextStyle(fontSize: 18)),
                          title: Text(
                            'ID: $regId',
                            style: TextStyle(fontSize: 20),
                          ),
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.all(20.0),
                                    //   child: Text(
                                    //     '$regId',
                                    //     style: TextStyle(fontSize: 20),
                                    //   ),
                                    // ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'UserCode: ${userCode.toString().toLowerCase()}',
                                            style: TextStyle(fontSize: 18)),
                                        Text(
                                            'Name: ${firstName.toString().toLowerCase()} ${middleName.toString().toLowerCase()} ${lastName.toString().toLowerCase()}',
                                            style: TextStyle(fontSize: 18)),
                                        Text(
                                            'Phone No: ${phoneCountryCode.toString().toLowerCase()} ${phoneNo.toString().toLowerCase()}',
                                            style: TextStyle(fontSize: 18)),
                                        Text(
                                            'Email: ${email.toString().toLowerCase()}',
                                            style: TextStyle(fontSize: 18)),
                                        Text(
                                            'Created Time: ${time.toString().toLowerCase()}',
                                            style: TextStyle(fontSize: 12)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
