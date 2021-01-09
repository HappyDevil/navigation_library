import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/fake_ioc_container.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/inner_router_delegate.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/navigation_models.dart';
import 'package:navigation_library_impl/navigation_core/navigator_infrastructure.dart';

class HomeScreen extends StatefulWidget with NavigatorInfrastructureMixin {
  HomeScreen({required this.outerLinkToInnerState}) {
    logWithTag('constructor $outerLinkToInnerState');
  }

  final OuterLinkToInnerState outerLinkToInnerState;

  @override
  _HomeScreenState createState() {
    logWithTag('createState $outerLinkToInnerState');
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> with NavigatorInfrastructureMixin {
  late final InnerRouterDelegate _routerDelegate;
  late final ChildBackButtonDispatcher? _backButtonDispatcher;

  void initState() {
    super.initState();
    _routerDelegate = InnerRouterDelegate(widget.outerLinkToInnerState);
    FakeIcoContainer.innerNavigator = _routerDelegate;

    logWithTag('initState ${widget.outerLinkToInnerState}');
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    logWithTag('Did update widget from old ${oldWidget.outerLinkToInnerState} to ${widget.outerLinkToInnerState}');
    super.didUpdateWidget(oldWidget);
    _routerDelegate.didUpdateRouter(widget.outerLinkToInnerState);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logWithTag('didChangeDependencies ${widget.outerLinkToInnerState}');
    // Defer back button dispatching to the child router
    _backButtonDispatcher = Router.of(context).backButtonDispatcher?.createChildBackButtonDispatcher();
  }

  @override
  Widget build(BuildContext context) {
    _backButtonDispatcher?.takePriority();

    logWithTag('build ${widget.outerLinkToInnerState}');

    return Scaffold(
      body: Router(
        routerDelegate: _routerDelegate,
        backButtonDispatcher: _backButtonDispatcher,
      ),
      appBar: AppBar(
        title: Text('Hello Worlds'),
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
