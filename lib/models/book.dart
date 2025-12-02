import 'dart:convert';

class Book {
  final String id;
  final String title;
  final List<String> authors;
  final String publisher;
  final String publishedDate;
  final bool isFavorite;
  final String description;
  final Map<String, String> industryIdentifiers;
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
    required this.industryIdentifiers,
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
      industryIdentifiers: {
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      // Store Lists as comma-separated Strings (standard SQLite practice)
      'authors': authors.join(','),
      'publisher': publisher,
      'publishedDate': publishedDate,
      // Store boolean as integer (0 or 1)
      'isFavorite': isFavorite ? 1 : 0,
      'description': description,
      // Convert complex Maps to JSON string (requires dart:convert)
      'industryIdentifiers': jsonEncode(industryIdentifiers),
      'pageCount': pageCount,
      'categories': categories.join(','),
      'previewLink': previewLink,
      'infoLink': infoLink,
      'language': language,
      'imageLinks': jsonEncode(imageLinks),
      'subtitle': subtitle,
    };
  }

  // 2. Create Book object from a Map (for SELECT/reading from DB)
  factory Book.fromJsonDatabase(Map<String, dynamic> jsonObject) {
    return Book(
      id: jsonObject['id'] ?? '',
      title: jsonObject['title'] ?? '',
      // Convert comma-separated String back to List
      authors: (jsonObject['authors'] as String? ?? '')
          .split(',')
          .where((s) => s.isNotEmpty)
          .toList(),
      publisher: jsonObject['publisher'] ?? '',
      publishedDate: jsonObject['publishedDate'] ?? '',
      // Convert integer (0 or 1) back to boolean
      // isFavorite: jsonObject['isFavorite'] == 1,
      description: jsonObject['description'] ?? '',
      // Decode JSON string back to Map (requires dart:convert)
      industryIdentifiers: Map<String, String>.from(
        jsonDecode(jsonObject['industryIndentifiers'] ?? '{}'),
      ),
      pageCount: jsonObject['pageCount'] ?? 0,
      categories: (jsonObject['categories'] as String? ?? '')
          .split(',')
          .where((s) => s.isNotEmpty)
          .toList(),
      previewLink: jsonObject['previewLink'] ?? '',
      infoLink: jsonObject['infoLink'] ?? '',
      language: jsonObject['language'] ?? '',
      imageLinks: Map<String, String>.from(
        jsonDecode(jsonObject['imageLinks'] ?? '{}'),
      ),
      subtitle: jsonObject['subtitle'] ?? '',
    );
  }
}
