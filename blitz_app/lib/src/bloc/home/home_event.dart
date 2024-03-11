part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class ChangePage extends HomeEvent {
  const ChangePage(this.page);
  final int page;
  @override
  List<Object> get props => [page];
}

class NewOrder extends HomeEvent {
  const NewOrder(this.newOrder);
  final bool newOrder;
  @override
  List<Object> get props => [newOrder];
}
