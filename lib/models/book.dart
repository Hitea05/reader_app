class Book {
  final String id;
  final String title;
  final List<String> authors;
  final String publisher;
  final String publishedDate;
  final bool isFavorite;
  final String description;
  final Map<String, String> industryIndentifiers;
  final int pageCount;
  final List<String> categories;
  final String previewLink;
  final String infoLink;
  final String language;
  final Map<String, String> imageLinks;
  final String subtitle;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.publisher,
    required this.publishedDate,
    this.isFavorite = false,
    required this.description,
    required this.industryIndentifiers,
    required this.pageCount,
    required this.categories,
    required this.previewLink,
    required this.infoLink,
    required this.language,
    required this.imageLinks,
    required this.subtitle,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    var volumeInfo = json['volumeInfo'] ?? {};
    return Book(
      id: json['id'] ?? '',
      title: volumeInfo['title'] ?? '',
      authors: (volumeInfo['authors'] as List<dynamic>? ?? [])
          .map((author) => author.toString())
          .toList(),
      publisher: volumeInfo['publisher'] ?? '',
      publishedDate: volumeInfo['publishedDate'] ?? '',
      description: volumeInfo['description'] ?? '',
      industryIndentifiers: {
        for (var item
            in volumeInfo['industryIdentifiers'] as List<dynamic>? ?? [])
          item['type'] as String? ?? '': item['identifier'] as String? ?? '',
      },
      pageCount: volumeInfo['pageCount'] ?? 0,
      categories: (volumeInfo['categories'] as List<dynamic>? ?? [])
          .map((category) => category.toString())
          .toList(),
      previewLink: volumeInfo['previewLink'] ?? '',
      infoLink: volumeInfo['infoLink'] ?? '',
      language: volumeInfo['language'] ?? '',
      imageLinks: (volumeInfo['imageLinks'] as Map<String, dynamic>? ?? {}).map(
        (key, value) => MapEntry(key, value.toString()),
      ),
      subtitle: volumeInfo['subtitle'] ?? '',
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Books : ${this.title}";
  }
}
