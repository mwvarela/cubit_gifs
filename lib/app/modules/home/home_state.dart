part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<GifModel> gifs;

  HomeState({this.gifs});

  HomeState.initialState() : gifs = [];
  HomeState.result(this.gifs);

  @override
  List<Object> get props => [gifs];
}
