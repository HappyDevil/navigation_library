import 'dart:html';

import 'package:flutter/material.dart';
import 'package:navigation_library_impl/navigation_core/delegate/pop_navigator.dart';
import 'package:navigation_library_impl/navigation_core/model/result_model.dart';

class EnterValueScreen extends StatefulWidget {
  @override
  _EnterValueScreenState createState() => _EnterValueScreenState();

  static final String RESULT_CODE = 'TEXT_RESULT_CODE';
}

class _EnterValueScreenState extends State<EnterValueScreen> {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter value'),),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textEditingController,
              ),
            ),
            FlatButton(
              color: Colors.amberAccent,
              onPressed: () => PopNavigator.of(context).pop(
                  result: ResultModel(
                resultCode: EnterValueScreen.RESULT_CODE,
                result: _textEditingController.text,
              )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
