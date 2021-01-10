import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/fake_ioc_container.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/inner_router_delegate.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/navigation_models.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({required this.outerLinkToInnerState});

  final OuterLinkToInnerState outerLinkToInnerState;

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  late final InnerRouterDelegate _routerDelegate;
  late final ChildBackButtonDispatcher? _backButtonDispatcher;

  void initState() {
    super.initState();
    _routerDelegate = InnerRouterDelegate(widget.outerLinkToInnerState);
    FakeIcoContainer.innerNavigator = _routerDelegate;
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _routerDelegate.didUpdateRouter(widget.outerLinkToInnerState);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Defer back button dispatching to the child router
    _backButtonDispatcher = Router.of(context).backButtonDispatcher?.createChildBackButtonDispatcher();
  }

  @override
  Widget build(BuildContext context) {
    _backButtonDispatcher?.takePriority();
    return Scaffold(
      body: Router(
        routerDelegate: _routerDelegate,
        backButtonDispatcher: _backButtonDispatcher,
      ),
      appBar: AppBar(
        title: Text('Hello Worlds'),
        leading: (widget.outerLinkToInnerState.length > 1)
            ? BackButton(
                onPressed: () {
                  _routerDelegate.popRoute();
                },
              )
            : null,
      ),
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
        onTap: (i) => FakeIcoContainer.innerNavigator.navigate(ChangeScreenEvent(i)),
        currentIndex: _routerDelegate.currentBottomIndex,
      ),
    );
  }
}
