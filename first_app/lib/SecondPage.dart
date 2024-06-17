import 'package:flutter/material.dart';
import 'WeatherPage.dart';
import 'NewsPage.dart';

void main() {
  runApp(SecondPage());

}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int cuIn = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('WeNew'),
            backgroundColor: Colors.black,
            actions: <Widget>[
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.notification_add))
            ],
          ),
          body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 65,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/weather2.jpg'),
                          radius: 60,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 10,
                        height: 10,
                      ),
                      FloatingActionButton.large(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WeatherPage()));
                        },
                        child: const Icon(Icons.cloud),
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.black,
                      ),
                    ]),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 20,
                      height: 20,
                    ),
                  ],
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 65,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/news2.jpg'),
                          radius: 60,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 10,
                        height: 10,
                      ),
                      FloatingActionButton.large(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsPage()));
                        },
                        child: const Icon(Icons.newspaper),
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.black,
                      ),
                    ]),
              ]),
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: const Color.fromARGB(255, 27, 30, 32),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  
                  label: 'Settings',
                ),
              ],
              currentIndex: cuIn,
              onTap: (int value) {
                setState(() {
                  cuIn = value;
                });
              }),
        ));
  }
}
