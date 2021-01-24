import 'package:navigation_library_impl/navigation_core/model/base_launch_modes.dart';
import 'package:navigation_library_impl/navigation_core/model/base_state.dart';

//states

mixin OuterNavigationState implements NavigationBaseState {}

class SplashState with OuterNavigationState {
  @override
  LaunchMode get launchMode => NoHistoryMode();

  @override
  bool operator ==(Object other) => identical(this, other) || other is SplashState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class OuterNotFoundState with OuterNavigationState {
  @override
  LaunchMode get launchMode => NoHistoryMode();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is OuterNotFoundState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class OuterLinkToInnerState extends ChildNavigationStubState with OuterNavigationState {
  OuterLinkToInnerState(int startIndex, int endIndex) : super(startIndex, endIndex);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || super == other && other is OuterLinkToInnerState && runtimeType == other.runtimeType;

  @override
  int get hashCode => super.hashCode;

  @override
  ChildNavigationStubState withNewIndex({int? startIndex, int? endIndex}) {
    if ((startIndex == null || identical(startIndex, this.startIndex)) &&
        (endIndex == null || identical(endIndex, this.endIndex))) {
      return this;
    }

    return new OuterLinkToInnerState(
      startIndex ?? this.startIndex,
      endIndex ?? this.endIndex,
    );
  }

  @override
  String toString() {
    return 'OuterLinkToInnerState{startIndex: $startIndex, endIndex: $endIndex}';
  }
}

//events

abstract class OuterNavigationEvents {}

class NavigateToMainPage extends OuterNavigationEvents {
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NavigateToMainPage && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
