import 'package:easy_money/widgets/lista/balanco_widget.dart';
import 'package:easy_money/widgets/lista/guardado_widget.dart';
import 'package:easy_money/widgets/lista/pagamentos_widget.dart';
import 'package:easy_money/widgets/lista/recebimentos_widget.dart';
import 'package:flutter/material.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const PagamentosListaWidget(),
    const RecebimentosListaWidget(),
    const BalancoListaWidget(),
    const GuardadoListaWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem mainBottomNavigationItem(
      IconData icon, Color color, String label) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: color,
      ),
      label: label,
    );
  }

  BottomNavigationBar mainBottomNavigation() {
    return BottomNavigationBar(
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
      currentIndex: _selectedIndex,
      items: <BottomNavigationBarItem>[
        mainBottomNavigationItem(Icons.attach_money, Colors.red, 'Pagamentos'),
        mainBottomNavigationItem(
            Icons.attach_money, Colors.blue, 'Recebimentos'),
        mainBottomNavigationItem(Icons.calculate, Colors.green, 'Balanço'),
        mainBottomNavigationItem(Icons.savings, Colors.green, 'Guardado'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy Money'),
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: mainBottomNavigation(),
    );
  }
}
