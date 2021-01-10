import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/handling_result/model/navigation_state.dart';
import 'package:navigation_library_impl/example/handling_result/screens/book_details_screen.dart';
import 'package:navigation_library_impl/example/handling_result/screens/enter_value_screen.dart';
import 'package:navigation_library_impl/navigation_core/page/base_page.dart';

class EnterValuePage extends BasePage<EnterValueState> {
  EnterValuePage(EnterValueState state) : super(state);

  @override
  Route createRoute(BuildContext context) => MaterialPageRoute<dynamic>(
        settings: this,
        builder: (BuildContext context) {
          return EnterValueScreen();
        },
      );
}
