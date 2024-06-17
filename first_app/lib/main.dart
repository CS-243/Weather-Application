import 'package:flutter/material.dart';
import 'SecondPage.dart';
//flutter build apk --build-name=1.0  --build-number=1
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: HomePage());
  }
}

// home Page

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('We_Ne'),
          backgroundColor: const Color.fromARGB(255, 27, 30, 32),

          //actions: <Widget>[
          //IconButton(onPressed: () {}, icon: const Icon(Icons.notification_add)),
          //],
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              const CircleAvatar(
                backgroundColor: Colors.black,
                radius: 100,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/user.png'),
                  radius: 90,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 50,
                height: 50,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
              ),
              FloatingActionButton.large(
                child: const Icon(Icons.login_outlined),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SecondPage()));
                },
              ),
            ])));
  }
}