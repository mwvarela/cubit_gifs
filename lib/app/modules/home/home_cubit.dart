import 'package:cubit/cubit.dart';
import 'package:cubit_gifs/app/models/gif_model.dart';
import 'package:cubit_gifs/app/repositories/gifs_repository.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GifsRepository _repository;

  HomeCubit(this._repository) : super(HomeState.initialState());

  Future<void> findRandomGifs() async {
    final gifs = await _repository.getRandomGifs();
    emit(HomeState.result(gifs));
  }
}
