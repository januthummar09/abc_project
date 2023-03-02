import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'model/placre_holder_model.dart';
import 'model/rick_data_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Rickdata? rickdata;
  List<PlaceHolderdata> item = [];
  PlaceHolderdata? placeHolderdata;
  @override
  void initState() {
    getRickData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Card(
              color: Colors.green,
              child: Column(
                children: [
                  Text("Id :${item[index].id}"),
                  Text("Id :${item[index].title}"),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
          itemCount: item.length),
    );
  }

  getRickData() async {
    http.Client client = http.Client();
    try {
      Response response = await client.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      );
      if (response.statusCode == 200) {
        item = (jsonDecode(response.body) as List?)!
            .map((e) => PlaceHolderdata.fromJson(e))
            .toList();
        debugPrint("data   :${response.body}");
        debugPrint("status code   :${response.statusCode}");
        setState(() {});
      } else {
        debugPrint("status code   :${response.statusCode}");
      }
    } finally {
      client.close();
    }
  }
}
