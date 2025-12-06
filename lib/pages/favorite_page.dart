import 'package:flutter/material.dart';
import 'package:reader_app/db/database_helper.dart';
import 'package:reader_app/models/book.dart';
import 'package:reader_app/utils/book_details_aurgments.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _HomePageState();
}

class _HomePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: FutureBuilder<List<Book>>(
        future: DatabaseHelper.instance.getFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error : ${snapshot.error}'));
          } else {
            final List<Book> favBooks = snapshot.data ?? [];
            return favBooks.isNotEmpty
                ? ListView.builder(
                    itemCount: favBooks.length,
                    itemBuilder: (context, index) {
                      Book book = favBooks[index];
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "/details",
                            arguments: BookDetailsArguments(
                              itemsbook: book,
                              isFromSavedScreen: true,
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: colorTheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 3,
                              color: colorTheme.onPrimaryContainer,
                            ),
                          ),
                          child: ListTile(
                            leading: Image.network(
                              book.imageLinks['thumbnail'] ?? '',
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              book.title,
                              style: textTheme.displayMedium,
                            ),
                            trailing: IconButton(
                              onPressed: () async {
                                book.isFavorite = !book.isFavorite;
                                await DatabaseHelper.instance
                                    .toggleFavoriteStatus(
                                      book.id,
                                      book.isFavorite,
                                    );
                                SnackBar snackBar = SnackBar(
                                  content: Center(
                                    child: Text(
                                      'Remove from Favorite',
                                      style: textTheme.displaySmall?.copyWith(
                                        color: colorTheme.inverseSurface,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  backgroundColor: colorTheme.inversePrimary,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      20,
                                    ),
                                    side: BorderSide(
                                      width: 2,
                                      style: BorderStyle.solid,
                                    ),
                                  ),

                                  behavior: SnackBarBehavior.floating,
                                  padding: EdgeInsets.all(10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                );
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(snackBar);
                                setState(() {});
                              },
                              icon: Icon(Icons.favorite, color: Colors.red),
                            ),
                            subtitle: Column(
                              children: [
                                SizedBox(height: 20),
                                Text(book.authors.join(' , ')),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'You have no Favorite Book yet.',
                      style: textTheme.displayMedium,
                    ),
                  );
          }
        },
      ),
    );
  }
}
