enum LaunchMode { MoveToTop, DropToSingle, NoHistory }

abstract class NavigationBaseState {
  LaunchMode get launchMode;
}
