import 'package:navigation_library_impl/navigation_core/delegate/pop_navigator.dart';
import 'package:navigation_library_impl/navigation_core/model/result_model.dart';

abstract class OpenNavigator<E> implements PopNavigator {
  Future<void> navigate(E event);

  Stream<ResultModel> get results;

  Stream<ResultModel> resultsByCode(final String code);
}
