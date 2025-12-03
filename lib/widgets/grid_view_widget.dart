import 'package:flutter/material.dart';
import 'package:reader_app/models/book.dart';
import 'package:reader_app/utils/book_details_aurgments.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    super.key,
    required List<Book> books,
    required this.colortheme,
    required this.textTheme,
  }) : _books = books;

  final List<Book> _books;
  final ColorScheme colortheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: _books.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.6,
        ),
        itemBuilder: (context, index) {
          Book book = _books[index];
          return Container(
            decoration: BoxDecoration(color: colortheme.primaryContainer),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/details',
                  arguments: BookDetailsArguments(
                    itemsbook: book,
                    isFromSavedScreen: false,
                  ),
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => BookDetailScreen(),
                //   ),
                // );
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      book.imageLinks['thumbnail'] ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    book.title,
                    style: textTheme.displayMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10),
                  Text(
                    book.authors.join(' , '),
                    style: textTheme.displaySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
