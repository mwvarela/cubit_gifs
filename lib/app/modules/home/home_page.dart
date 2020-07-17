import 'package:cubit_gifs/app/modules/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cubit Gifs'),
        centerTitle: true,
      ),
      body: CubitProvider(
        create: (context) => Modular.get<HomeCubit>()..findRandomGifs(),
        child: buildGifs(),
      ),
    );
  }

  Widget buildGifs() {
    return CubitBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.gifs.isNotEmpty) {
          return buildResult(state);
        }

        return Container();
      },
    );
  }

  Widget buildResult(HomeState state) {
    return Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: state.gifs.length,
        itemBuilder: (context, index) {
          final gif = state.gifs[index];
          return Image.network(
            gif.url,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
