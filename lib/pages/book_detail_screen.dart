import 'package:flutter/material.dart';
import 'package:reader_app/models/book.dart';
import 'package:reader_app/utils/book_details_aurgments.dart';

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

    var themecolor = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themecolor.inversePrimary,
        title: Text(book.title, style: textTheme.displayMedium),
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
                  Text(
                    'Publisher : ${book.publisher}',
                    style: textTheme.displaySmall,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Authors : ${book.authors.join(' , ')}',
                    style: textTheme.displaySmall,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Language : ${book.language}',
                    style: textTheme.displaySmall,
                  ),
                  SizedBox(height: 10),
                  Text('Pages Count : ${book.pageCount}'),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: .spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.save),
                        onPressed: () {},
                        label: Text('Save'),
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.favorite),
                        onPressed: () {},
                        label: Text('Favorite'),
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
                child: Text(book.description, style: textTheme.displaySmall),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
