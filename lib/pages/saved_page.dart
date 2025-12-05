import 'package:flutter/material.dart';
import 'package:reader_app/db/database_helper.dart';
import 'package:reader_app/models/book.dart';
import 'package:reader_app/utils/book_details_aurgments.dart';

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
      body: FutureBuilder<List<Book>>(
        future: DatabaseHelper.instance.readAllBooks(),
        builder: (context, snapshot) {
          // Ensure data is not null and is a List<Book>
          final List<Book> books = snapshot.data ?? [];

          // ---  Handle Empty State ---
          if (books.isEmpty) {
            return Center(
              child: Text(
                'You have no saved books yet.',
                style: textTheme.displayMedium,
              ),
            );
          }
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              Book book = books[index];

              return InkWell(
                onTap: () async {
                  await Navigator.pushNamed(
                    context,
                    '/details',
                    arguments: BookDetailsArguments(
                      itemsbook: book,
                      isFromSavedScreen: true,
                    ),
                  );
                  setState(() {});
                },
                child: Container(
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
                      icon: Icon(Icons.delete),
                    ),
                    subtitle: Column(
                      spacing: 10,
                      children: [
                        SizedBox(height: 10),
                        Text(book.authors.join(' , ')),
                        ElevatedButton.icon(
                          icon: Icon(
                            book.isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_outline_rounded,
                            color: book.isFavorite ? Colors.red : null,
                          ),
                          onPressed: () async {
                            book.isFavorite = !book.isFavorite;
                            await DatabaseHelper.instance.toggleFavoriteStatus(
                              book.id,
                              book.isFavorite,
                            );

                            SnackBar snackBar1 = SnackBar(
                              content: Text(
                                'Add to Favorite',
                                style: textTheme.displaySmall?.copyWith(
                                  color: colortheme.inverseSurface,
                                ),
                              ),
                              backgroundColor: colortheme.inversePrimary,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(20),
                                side: BorderSide(
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              margin: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 6,
                              ),
                              behavior: SnackBarBehavior.floating,
                            );
                            SnackBar snackBar2 = SnackBar(
                              content: Text(
                                'Removed from Favorite',
                                style: textTheme.displaySmall?.copyWith(
                                  color: colortheme.inverseSurface,
                                ),
                              ),
                              backgroundColor: colortheme.inversePrimary,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(20),
                                side: BorderSide(
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              margin: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 6,
                              ),
                              behavior: SnackBarBehavior.floating,
                            );
                            book.isFavorite
                                ? ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(snackBar1)
                                : ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(snackBar2);
                            setState(() {});
                          },
                          label: Text(
                            book.isFavorite ? 'Favorite' : 'Add to Favorite',
                          ),
                        ),
                      ],
                    ),
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
