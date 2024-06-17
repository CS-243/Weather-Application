import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const NewsPage());
}

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> articles = [];

  Future<void> getNewsData() async {
    const String apiKey = 'e189aecac01f420ea3c308114f178e90';
    const String apiUrl =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        articles = jsonData['articles'];
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    super.initState();
    getNewsData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('News'),
          backgroundColor: Colors.black,
        ),
        body: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (BuildContext context, int index) {
            final article = articles[index];
            return ListTile(
              title: Text(article['title']),
              subtitle: Text(article['description']),
              leading: Image.network(article['urlToImage']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailsPage(article: article),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class NewsDetailsPage extends StatefulWidget {
  final dynamic article;

  const NewsDetailsPage({Key? key, required this.article}) : super(key: key);

  @override
  _NewsDetailsPageState createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  String fullArticle = '';

  Future<void> getFullArticle() async {
    final String url = widget.article['url'];
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final document = parse(response.body);
      final paragraphs = document.querySelectorAll('p');

      setState(() {
        fullArticle = paragraphs.map((element) => element.text).join('\n\n');
      });
    } else {
      print('Failed to load full article with status: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    getFullArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article['title']),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.article['urlToImage']),
            SizedBox(height: 16),
            Text(
              widget.article['description'],
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  fullArticle.isNotEmpty ? fullArticle : "No content available",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   runApp(const NewsPage());
// }

// class NewsPage extends StatefulWidget {
//   const NewsPage({Key? key}) : super(key: key);

//   @override
//   State<NewsPage> createState() => _NewsPageState();
// }

// class _NewsPageState extends State<NewsPage> {
//   List<dynamic> articles = [];

//   Future<void> getNewsData() async {
//     const String apiKey = 'e189aecac01f420ea3c308114f178e90';
//     const String apiUrl =
//         'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

//     final response = await http.get(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       final jsonData = json.decode(response.body);
//       setState(() {
//         articles = jsonData['articles'];
//       });
//     } else {
//       print('Request failed with status: ${response.statusCode}.');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getNewsData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark(),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('News'),
//           backgroundColor: Colors.black,
//         ),
//         body: ListView.builder(
//           itemCount: articles.length,
//           itemBuilder: (BuildContext context, int index) {
//             final article = articles[index];
//             return ListTile(
//               title: Text(article['title']),
//               subtitle: Text(article['description']),
//               leading: Image.network(article['urlToImage']),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => NewsDetailsPage(article: article),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
// class NewsDetailsPage extends StatelessWidget {
//   final dynamic article;

//   const NewsDetailsPage({Key? key, required this.article}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(article['title']),
//         backgroundColor: Colors.black,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.network(article['urlToImage']),
//             SizedBox(height: 16),
//             Text(
//               article['description'],
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Text(
//                   article['content'] ?? "No content available",
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





// previous
// import 'package:first_app/SecondPage.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const NewsPage());
// }

// class NewsPage extends StatefulWidget {
//   const NewsPage({super.key});

//   @override
//   State<NewsPage> createState() => _NewsPageState();
// }

// class _NewsPageState extends State<NewsPage> {
//   List<dynamic> articles = [];
  

//   Future<void> getNewsData() async {
//     const String apiKey = 'e189aecac01f420ea3c308114f178e90';
//     const String apiUrl =
//         'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

//     final response = await http.get(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       final jsonData = json.decode(response.body);
//       setState(() {
//         articles = jsonData['articles'];
//       });
//     } else {
//       print('Request failed with status: ${response.statusCode}.');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getNewsData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData.dark(),
//         home: Scaffold(
//           appBar: AppBar(
//             title: const Text('News'),
//             backgroundColor: Colors.black,
            
//               leading: IconButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => SecondPage()));
//                   },
//                   icon: const Icon(Icons.arrow_back))
           
//           ),
//           body: ListView.builder(
//               itemCount: articles.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final article = articles[index];
//                 return ListTile(
//                   title: Text(article['title']),
//                   subtitle: Text(article['description']),
//                   leading: Image.network(article['urlToImage']),
//                 );
//               }),
//         ));
//   }
// }

/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: NewsScreen(),
    );
  }
}

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final String apiKey = '276d2d122086436fad14956043cd8f66';
  final String apiUrl = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=';

  List<dynamic> articles = [];

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    final response = await http.get(Uri.parse(apiUrl + apiKey));
    final data = jsonDecode(response.body);
    setState(() {
      articles = data['articles'];
    });
  }

  void _showFullNewsDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(content),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: articles.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        itemBuilder: (context, index) {
          final article = articles[index];
          return InkWell(
            onTap: () {
              _showFullNewsDialog(
                article['title'],
                article['content'],
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 150,
                    child: CachedNetworkImage(
                      imageUrl: article['urlToImage'],
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      article['title'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
*/