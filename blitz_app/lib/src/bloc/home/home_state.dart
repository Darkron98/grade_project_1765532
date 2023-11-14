part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.indexPage = 0,
  });

  final int indexPage;

  HomeState copyWith({int? indexPage}) => HomeState(
        indexPage: indexPage ?? this.indexPage,
      );

  @override
  List<Object> get props => [indexPage];
}
