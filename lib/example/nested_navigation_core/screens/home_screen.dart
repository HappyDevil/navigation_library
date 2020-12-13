import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/inner_router_delegate.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/inner_router_information_parser.dart';

class HomeScreen extends StatelessWidget {
  final innerRouterDelegate = InnerRouterDelegate.I;
  final innerRouteInformationParser = InnerRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('HelloWorld'),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
