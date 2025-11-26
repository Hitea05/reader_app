import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reader_app/pages/book_detail_screen.dart';
import 'package:reader_app/pages/favorite_page.dart';
import 'package:reader_app/pages/home_page.dart';
import 'package:reader_app/pages/saved_page.dart';
import 'package:reader_app/provider/theme_provider.dart';
import 'package:reader_app/widgets/theme_button.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProviderModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeProviderModel>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reader App',
      initialRoute: '/',
      routes: {
        '/home': (context) => HomePage(),
        '/saved': (context) => SavedPage(),
        '/favorite': (context) => FavoritePage(),
        '/details': (context) => BookDetailScreen(),
      },
      theme: themeprovider.currentTheme,
      home: const MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _currentIndex = 0;

  final List<Widget> _screen = [
    const HomePage(),
    const FavoritePage(),
    const SavedPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeProviderModel>(context);

    var text = Theme.of(context).textTheme;
    var themeModel = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        actions: [ThemeWidget(themeprovider: themeprovider)],
        backgroundColor: themeModel.inversePrimary,
        title: Text('Reader App', style: text.titleMedium),
        centerTitle: true,
      ),
      drawer: Drawer(),
      body: _screen[_currentIndex],
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.save), label: 'Saved'),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Favorite'),
        ],
        selectedIndex: _currentIndex,
        backgroundColor: themeModel.inversePrimary,
        indicatorColor: themeModel.onPrimary,
        elevation: 10,
        overlayColor: WidgetStatePropertyAll(themeModel.inversePrimary),
        onDestinationSelected: (int value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
