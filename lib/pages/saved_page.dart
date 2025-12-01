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
    var colortheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Book', style: textTheme.headlineMedium),
        centerTitle: false,
        backgroundColor: colortheme.surfaceContainer,
      ),
      body: FutureBuilder<List<Book>>(
        future: DatabaseHelper.instance.readAllBook(),
        builder: (context, snapshoot) => snapshoot.hasData
            ? ListView.builder(
                itemCount: snapshoot.data!.length,
                itemBuilder: (context, index) {
                  Book book = snapshoot.data![index];

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: BoxBorder.all(
                        width: 2,
                        color: colortheme.outlineVariant,
                      ),
                      color: colortheme.surfaceContainerHighest,
                    ),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          book.imageLinks['smallThumbnail'] ?? '',
                        ),
                      ),
                      title: Text(book.title, style: textTheme.displayMedium),
                      subtitle: Text(book.authors.join(' , ')),
                      trailing: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.favorite_outlined),
                      ),
                    ),
                  );
                },
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
