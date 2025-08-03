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