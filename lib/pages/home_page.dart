import 'package:flutter/material.dart';
import 'package:reader_app/models/book.dart';
import 'package:reader_app/network/network.dart';

import 'package:reader_app/widgets/grid_view_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book> _books = [];
  Network network = Network();
  Future<void> _searchBooks(String query) async {
    try {
      List<Book> books = await network.searchBooks(query);
      setState(() {
        _books = books;
      });
    } catch (e) {}
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var colortheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for a book',
                prefixIcon: Icon(Icons.book),
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: colortheme.inversePrimary,
                    width: 2.0,
                  ),
                ),
              ),
              keyboardType: TextInputType.text,
              onSubmitted: (query) => _searchBooks(query),
            ),
          ),
          GridViewWidget(
            books: _books,
            colortheme: colortheme,
            textTheme: textTheme,
          ),
          //   child: Container(
          //     padding: EdgeInsets.all(5),
          //     width: double.infinity,
          //     child: ListView.builder(
          //       itemCount: _books.length,
          //       itemBuilder: (context, index) {
          //         Book book = _books[index];

          //         return GridView(gridDelegate: gridDelegate)
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
