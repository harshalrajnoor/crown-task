// Task 2 - Buttons for navigating to different tasks

import 'package:crud_app/home_screen.dart';
import 'package:crud_app/photos_screen.dart';
import 'package:crud_app/task_third.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/posts_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Task 2',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // Task 2 Buttons
            children: [
              MaterialButton(
                height: 40,
                minWidth: double.infinity,
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MaterialApp(
                        home: ThirdTask(),
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Task 3',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              MaterialButton(
                height: 40,
                minWidth: double.infinity,
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MaterialApp(
                        home: PostsScreen(),
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Task 4',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              MaterialButton(
                height: 40,
                minWidth: double.infinity,
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MaterialApp(
                        home: PhotosScreen(),
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Task 5',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              MaterialButton(
                height: 40,
                minWidth: double.infinity,
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MaterialApp(
                        home: HomeScreen(),
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Task 6',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
