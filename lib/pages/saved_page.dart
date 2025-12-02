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
        title: Text('Saved Book', style: textTheme.displayMedium),
        centerTitle: false,
        backgroundColor: colortheme.surfaceContainer,
      ),
      body: FutureBuilder<List<Book>>(
        future: DatabaseHelper.instance.readAllBook(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // --- 2. Handle Error State ---
          if (snapshot.hasError) {
            print(snapshot.error); // Log the error
            return Center(
              child: Text('Error loading data: ${snapshot.error.toString()}'),
            );
          }

          // Ensure data is not null and is a List<Book>
          final List<Book> books = snapshot.data ?? [];

          // --- 3. Handle Empty State ---
          if (books.isEmpty) {
            return Center(
              child: Text(
                'You have no saved books yet.',
                style: textTheme.displayMedium,
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Book book = books[index];

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
                  leading: Image.network(
                    book.imageLinks['thumbnail'] ?? '',
                    fit: BoxFit.cover,
                  ),
                  title: Text(book.title, style: textTheme.displayMedium),
                  trailing: IconButton(
                    onPressed: () async {
                      await DatabaseHelper.instance.deleteBook(book.id);

                      SnackBar snackBar = SnackBar(
                        backgroundColor: colortheme.surfaceContainerHighest,
                        content: Text(
                          'Book Delete',
                          style: textTheme.displaySmall,
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      setState(() {});
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  subtitle: Column(
                    spacing: 10,
                    children: [
                      const SizedBox(height: 10),
                      Text(book.authors.join(' , ')),
                      ElevatedButton.icon(
                        onPressed: () async {
                          await DatabaseHelper.instance
                              .toggleFavoriteStatus(book.id, book.isFavorite)
                              .then((value) => print("Book add to Favorite"));
                        },
                        label: const Text('Add to Favorites'),
                        icon: const Icon(Icons.favorite_rounded),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
