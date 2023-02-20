import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'full_image_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var urlData;
  var clientIdToken =
      '896d4f52c589547b2134bd75ed48742db637fa51810b49b607e37e46ab2c0043';
  void getApiData() async {
    var url =
        Uri.parse('https://api.unsplash.com/photos/?client_id=$clientIdToken');
    final res = await http.get(url);
    setState(() {
      urlData = jsonDecode(res.body);
      print(urlData);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: urlData != null
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height),
                ),
                itemCount: urlData.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullImageScreen(
                                    urlToShow: urlData[i]["urls"]["full"],
                                  )));
                    },
                    child: GridTile(
                      child: Column(
                        children: [
                          Container(
                            child: Image.network(urlData[i]["urls"]["full"]),
                          ),
                          const SizedBox(height: 5),
                          Text(urlData[i]["user"]["name"]),
                        ],
                      ),
                    ),
                  );
                })
            : const CircularProgressIndicator(),
      ),
    );
  }
}
