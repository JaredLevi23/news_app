import 'package:flutter/material.dart';
import 'package:news_app/pages/tabs_page.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/theme/tema.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ( _ ) => NewsService()
        )
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: const TabsPage(),
        theme: miTema,
      ),
    );
  }
}