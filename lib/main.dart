import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Person{
  final String name;
  final int age;

  Person({required this.name, required this.age});

  Person.frromJson(Map<String, dynamic> json) 
  
  : name = json['name'] as String,
  age = json['age'] as int; 
}

Future<I>

void _getPersons (SendPort sp) async {
  const url = 'http://127.0.0.1:5500/apis/people1.json';
  final persons = await HttpClient()
  .getUrl(Uri.parse(url))
  .then((req) => req.close())
  .then((response) => response.transform(utf8.decoder).join())
  .then((jsonString) => json.decode(jsonString) as List<dynamic>)
  .then((json) => json.map((map) => Person.frromJson(map)));

  Isolate.exit(
    sp,
    persons,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('hello world'),
    ));
  }
}
