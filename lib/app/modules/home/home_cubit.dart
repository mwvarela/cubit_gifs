import 'package:cubit/cubit.dart';
import 'package:cubit_gifs/app/models/gif_model.dart';
import 'package:cubit_gifs/app/repositories/gifs_repository.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GifsRepository _repository;

  HomeCubit(this._repository) : super(HomeState.initialState());

  Future<void> findRandomGifs() async {
    try {
      emit(HomeState.loading());
      final gifs = await _repository.getRandomGifs();
      emit(HomeState.result(gifs));
    } catch (e) {
      emit(HomeState.error('Erro ao buscar Gifs'));
    }
  }

  Future<void> findGif(String value) async {
    try {
      emit(HomeState.loading());
      List<GifModel> gifs;
      if (value.length > 0) {
        gifs = await _repository.searchGif(value);
      } else {
        gifs = await _repository.getRandomGifs();
      }
      emit(HomeState.result(gifs));
    } catch (e) {
      emit(HomeState.error('Erro ao buscar Gifs'));
    }
  }

  void selectGif(GifModel gif) {
    emit(state.copyWith(gifSelecionado: gif));
  }
}
