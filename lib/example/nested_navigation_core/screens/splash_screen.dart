import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/fake_ioc_container.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/navigation_models.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(Duration(seconds: 3))
        .then((value) => FakeIcoContainer.outerNavigator.navigate(NavigateToMainPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
