import 'package:flutter/material.dart';
import '../componentes/custom_app_bar.dart';
import '../componentes/custom_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: "Lista de Contatos"),
        drawer: CustomDrawer(),
      ),
    );
  }
}
