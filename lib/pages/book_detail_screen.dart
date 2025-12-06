import 'package:flutter/material.dart';
import 'package:reader_app/db/database_helper.dart';
import 'package:reader_app/models/book.dart';
import 'package:reader_app/utils/book_details_aurgments.dart';
import 'package:reader_app/widgets/theme_button.dart';

class BookDetailScreen extends StatefulWidget {
  const BookDetailScreen({super.key});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as BookDetailsArguments;
    final Book book = args.itemsbook;
    final bool isFromSavedScreen = args.isFromSavedScreen;

    final List<String> imageUrl = book.imageLinks.values.toList();

    var themecolor = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themecolor.inversePrimary,
        title: Text(book.title, style: textTheme.displayMedium),
        centerTitle: true,
        actions: [ThemeWidget()],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              if (book.imageLinks.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.network(
                    book.imageLinks['thumbnail'] ?? '',
                    fit: BoxFit.cover,
                    scale: 0.6,
                  ),
                ),

              Column(
                children: [
                  Text(
                    book.title,
                    style: textTheme.displayMedium!.copyWith(fontSize: 22),
                  ),

                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Published Date : ',
                          style: textTheme.displayMedium,
                        ),
                        TextSpan(
                          text: book.publishedDate,
                          style: textTheme.displayMedium?.copyWith(
                            fontWeight: .w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Publisher : ',
                          style: textTheme.displayMedium,
                        ),
                        TextSpan(
                          text: book.publisher,
                          style: textTheme.displayMedium?.copyWith(
                            fontWeight: .w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Authors : ',
                          style: textTheme.displayMedium,
                        ),
                        TextSpan(
                          text: book.authors.join(' , '),
                          style: textTheme.displayMedium?.copyWith(
                            fontWeight: .w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Language : ',
                          style: textTheme.displayMedium,
                        ),
                        TextSpan(
                          text: book.language,
                          style: textTheme.displayMedium?.copyWith(
                            fontWeight: .w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Page Count : ',
                          style: textTheme.displayMedium,
                        ),
                        TextSpan(
                          text: '${book.pageCount}',
                          style: textTheme.displayMedium?.copyWith(
                            fontWeight: .w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Subtitle : ',
                          style: textTheme.displayMedium,
                        ),
                        TextSpan(
                          text: book.subtitle,
                          style: textTheme.displayMedium?.copyWith(
                            fontWeight: .w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Catergories : ',
                          style: textTheme.displayMedium,
                        ),
                        TextSpan(
                          text: book.categories.join(' , '),
                          style: textTheme.displayMedium?.copyWith(
                            fontWeight: .w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),
                  isFromSavedScreen
                      ? Row(
                          mainAxisAlignment: .center,
                          children: [
                            ElevatedButton.icon(
                              icon: Icon(
                                book.isFavorite
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_outline_rounded,
                                color: book.isFavorite ? Colors.red : null,
                              ),
                              onPressed: () async {
                                book.isFavorite = !book.isFavorite;
                                await DatabaseHelper.instance
                                    .toggleFavoriteStatus(
                                      book.id,
                                      book.isFavorite,
                                    );

                                SnackBar snackBar1 = SnackBar(
                                  content: Center(
                                    child: Text(
                                      'Add to Favorite',
                                      style: textTheme.displaySmall?.copyWith(
                                        color: themecolor.inverseSurface,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  backgroundColor: themecolor.inversePrimary,
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
                                SnackBar snackBar2 = SnackBar(
                                  content: Center(
                                    child: Text(
                                      'Remove from Favorite',
                                      style: textTheme.displaySmall?.copyWith(
                                        color: themecolor.inverseSurface,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  backgroundColor: themecolor.inversePrimary,
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
                                book.isFavorite
                                    ? 'Favorite'
                                    : 'Add to Favorite',
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: .center,
                          children: [
                            ElevatedButton.icon(
                              icon: Icon(Icons.save),
                              onPressed: () async {
                                try {
                                  int savedInt = await DatabaseHelper.instance
                                      .insert(book);
                                  SnackBar snackBar = SnackBar(
                                    content: Text("Book Saved $savedInt"),
                                  );
                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(snackBar);
                                } catch (e) {
                                  print('Error Saving Book');
                                }
                              },
                              label: Text('Save'),
                            ),
                          ],
                        ),
                ],
              ),
              SizedBox(height: 30),
              Text('Descriptions', style: textTheme.displayMedium),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: themecolor.onSecondary,
                  border: Border.all(width: 2, color: themecolor.secondary),
                ),
                child: RichText(
                  text: TextSpan(
                    text: book.description,
                    style: textTheme.displaySmall,
                  ),
                ),
              ),
              imageUrl.isEmpty
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imageUrl.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Image.network(
                                  imageUrl[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

// SizedBox(
//                       height: 200,
//                       width: double.infinity,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: movie.images.length,
//                         itemBuilder: (context, index) {
//                           return Card(
//                             elevation: 5,
//                             child: Image.network(
//                               movie.images[index],
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Container(
//                                   color: currentColorScheme
//                                       .surfaceContainerHighest,
//                                   child: Center(
//                                     child: Icon(
//                                       Icons.broken_image,
//                                       size: 40,
//                                       color:
//                                           currentColorScheme.onSurfaceVariant,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                     ),
