abstract class LaunchMode {}

class Default extends LaunchMode {}

class MoveToTop extends LaunchMode {}

class DropToSingle extends LaunchMode {}

class NoHistory extends LaunchMode {}

/**
 * States with this type add only with interceptor and not processed with navigationStackHandler
 */
class VirtualState extends LaunchMode {}