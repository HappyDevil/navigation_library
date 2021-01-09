import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class NavigatorInfrastructureProvider implements NavigatorInfrastructure {
  NavigatorInfrastructureProvider._create() : infrastructure = NavigatorInfrastructureImpl();

  static final NavigatorInfrastructureProvider I = NavigatorInfrastructureProvider._create();

  NavigatorInfrastructure infrastructure;

  @override
  Logger get logger => infrastructure.logger;
}

abstract class NavigatorInfrastructure {
  Logger get logger;
}

class NavigatorInfrastructureImpl implements NavigatorInfrastructure {
  NavigatorInfrastructureImpl({final Logger? logger}) : _logger = logger ?? Logger(printer: SimplePrinter());

  final Logger _logger;

  @override
  Logger get logger => _logger;
}

mixin NavigatorInfrastructureMixin implements NavigatorInfrastructure {
  @protected
  String get tag => '${this.runtimeType}(${identityHashCode(this)})';

  @override
  @protected
  Logger get logger => NavigatorInfrastructureProvider.I.logger;

  @protected
  void logWithTag(final String message, {Level? logLevel}) {
    logger.log(logLevel ?? Level.debug, '[$tag] $message');
  }
}
