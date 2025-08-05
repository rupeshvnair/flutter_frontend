import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main(){
    runApp(JewelryApp());
}

class JewelryApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title:'Jewelry Shop',
            home: JewelryList(),
        );
    }
}

class JewelryItem {
    final String name;
    final String price;
    final List<dynamic> images;

    JewelryItem({required this.name, required this.price, required this.images});
    factory JewelryItem.fromJson(Map<String, dynamic> json) {
        return JewelryItem(
            name: json['name'],
            price: json['price'],
            images: json['images'] ?? [],
        );
    }
}

class JewelryList extends StatefulWidget {
    @override
    _JewelryListState createState() => _JewelryListState();
}

class _JewelryListState extends State<JewelryList> {
    List <JewelryItem> items = [];

    @override
    void initState() {
        super.initState();
        fetchJewelry();
    }

    Future<void> fetchJewelry() async {
        final response = await http.get(Uri.parse('http://192.168.29.126:8000/api/jewelry'));
        if (response.statusCode == 200) {
            List jsonData = json.decode(response.body);
            setState (() {
                items = jsonData.map((e) => JewelryItem.fromJson(e)).toList();
            });
        } else {
            throw Exception('Failed to load Jewelry');
        }
    }

    @override
    Widget build(BuildContext context) {  
        return Scaffold(
            appBar: AppBar(title: Text('Jewelry Collection')),
            body: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                        leading: Image.network(item.images[0]['image']),
                        title: Text(item.name),
                        subtitle: Text("Rs${item.price}"),
                    );
                },
            ),
        );
    }
}
