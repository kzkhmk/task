import 'package:flutter/material.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('お気に入り'),
      ),
      body: const MyListviewApp(),
    );
  }
}

class MyListviewApp extends StatefulWidget {
  const MyListviewApp({Key? key}) : super(key: key);

  @override
  State<MyListviewApp> createState() => _MyListviewAppState();
}

class _MyListviewAppState extends State<MyListviewApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Card(
                color: index % 2 == 1 ? Colors.blue : Colors.green,
                child: Container(
                  width: 200,
                ),
              );
            },
            itemCount: 10,
          ),
        ),
      ),
    );
  }
}
