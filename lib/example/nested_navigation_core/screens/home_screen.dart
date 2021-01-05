import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/inner_router_delegate.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/outer_router_delegate.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({required this.outerLinkToInnerState});

  final OuterLinkToInnerState outerLinkToInnerState;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final InnerRouterDelegate _routerDelegate;
  late final ChildBackButtonDispatcher? _backButtonDispatcher;

  void initState() {
    super.initState();
    _routerDelegate = InnerRouterDelegate(widget.outerLinkToInnerState);
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _routerDelegate.didUpdateRouter(oldWidget.outerLinkToInnerState);
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
      ),
      drawer: Center(
        child: Column(
          children: [
            Text('Its drawer'),
            FlatButton(
              child: Text('Some Buttton'),
              onPressed: () {},
            ),
            Image.network(
                'https://www.google.com/url?sa=i&url=https%3A%2F%2Fdeveloper.mozilla.org%2Fen-US%2Fdocs%2FWeb%2FHTML%2FElement%2Fimg&psig=AOvVaw18IjKMyelnGCa6-S0Tithi&ust=1609141341798000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCJCcquLU7e0CFQAAAAAdAAAAABAD'),
          ],
        ),
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
        onTap: (i) => OuterRouterDelegate.navigator.navigate(ChangeScreenEvent(i)),
        currentIndex: _routerDelegate.currentBottomIndex,
      ),
    );
  }
}
