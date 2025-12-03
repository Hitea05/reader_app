import 'package:reader_app/models/book.dart';

class BookDetailsArguments {
  final Book itemsbook;
  final bool isFromSavedScreen;

  BookDetailsArguments({
    required this.itemsbook,
    required this.isFromSavedScreen,
  });
}
