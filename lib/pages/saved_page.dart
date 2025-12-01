import 'package:flutter/material.dart';
import 'package:reader_app/db/database_helper.dart';
import 'package:reader_app/models/book.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _HomePageState();
}

class _HomePageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Book>>(
        future: DatabaseHelper.instance.readAllBook(),
        builder: (context, snapshoot) => snapshoot.hasData
            ? ListView.builder(
                itemCount: snapshoot.data!.length,
                itemBuilder: (context, index) {
                  Book book = snapshoot.data![index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        book.imageLinks['smallThumbnail'] ?? '',
                      ),
                    ),
                    title: Text(
                      book.title,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    subtitle: Text(book.authors.join(' , ')),
                  );
                },
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
