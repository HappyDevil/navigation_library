import 'package:navigation_library_impl/navigation_core/model/result_model.dart';

abstract class OpenNavigator<E> {
  Future<void> navigate(E event);

  Stream<ResultModel> get results;

  Stream<ResultModel> resultsByCode(final String code);

  bool pop({ResultModel? result});
}
