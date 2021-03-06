import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/handling_result/model/navigation_event.dart';
import 'package:navigation_library_impl/example/handling_result/model/navigation_state.dart';
import 'package:navigation_library_impl/example/handling_result/navigation/pages/book_detail_page.dart';
import 'package:navigation_library_impl/example/handling_result/navigation/pages/book_list_page.dart';
import 'package:navigation_library_impl/example/handling_result/navigation/pages/enter_value_page.dart';
import 'package:navigation_library_impl/example/handling_result/navigation/pages/not_found_page.dart';
import 'package:navigation_library_impl/navigation_core/delegate/base_router_delegate_impl.dart';
import 'package:navigation_library_impl/navigation_core/interceptor/base_interceptor.dart';

class BookRouterDelegate extends ParentBaseRouterDelegate<BookAppNavigationState, BookAppNavigationEvent> {
  BookRouterDelegate._create() : super();
  static final BookRouterDelegate I = BookRouterDelegate._create();

  @override
  Page mapStateToPage(state) {
    if (state is OpenBookState) return BookDetailPage(state);
    if (state is BookListState) return BookListPage(state);
    if (state is EnterValueState) return EnterValuePage(state);
    if (state is NotFoundState) return NotFoundPage(state);
    throw UnimplementedError('state not supported ${state.runtimeType}');
  }

  @override
  List<BookAppNavigationState> get initState => [BookListState()];

  @override
  Future<List<BookAppNavigationState>> mapEventToStates(final BookAppNavigationEvent event) async {
    if (event is NavigateToBook) return [OpenBookState(event.id)];
    if (event is EnterValue) return [EnterValueState()];
    throw UnimplementedError('event type is not supports ${event.runtimeType}');
  }

  @override
  CompositeStatesInterceptor<BookAppNavigationState> get statesInterceptor => CompositeStatesInterceptor.EMPTY();
}
