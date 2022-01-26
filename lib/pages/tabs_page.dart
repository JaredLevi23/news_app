import 'package:flutter/material.dart';
import 'package:news_app/pages/tab1_page.dart';
import 'package:news_app/pages/tab2_page.dart';
import 'package:news_app/services/news_service.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: ( _ ) => _NavegacionModel(),
      child: const Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final navegacionModel = Provider.of<_NavegacionModel>(context);
    

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (i) => navegacionModel.paginaActual = i,
      items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Para ti'
      ),

      BottomNavigationBarItem(
        icon: Icon(Icons.star),
        label: 'Encabezados'
      )

    ],);
  }

}

class _Paginas extends StatelessWidget {
  const _Paginas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [

        Tab1Page(),

        Tab2Page()

      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier{

  int _paginaActual = 0;
  final PageController _pageController = PageController(initialPage: 0);


  int get paginaActual => _paginaActual;

  set paginaActual(int paginaActual) {
    _paginaActual = paginaActual;
    _pageController.animateToPage( paginaActual, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;



}