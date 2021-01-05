import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/screens/home_screen.dart';
import 'package:navigation_library_impl/navigation_core/base_page.dart';

import '../navigation_models.dart';

class MainPage extends BasePage<OuterLinkToInnerState> {
  MainPage(OuterLinkToInnerState state) : super(state);

  @override
  Route createRoute(BuildContext context) => MaterialPageRoute<dynamic>(
        settings: this,
        builder: (context) => HomeScreen(outerLinkToInnerState: state),
      );
}
