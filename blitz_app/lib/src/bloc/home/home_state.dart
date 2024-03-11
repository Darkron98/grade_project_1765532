part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.indexPage = 0,
    this.newOrder = false,
  });

  final int indexPage;
  final bool newOrder;

  HomeState copyWith({int? indexPage, bool? newOrder}) => HomeState(
        indexPage: indexPage ?? this.indexPage,
        newOrder: newOrder ?? this.newOrder,
      );

  @override
  List<Object> get props => [
        indexPage,
        newOrder,
      ];
}
