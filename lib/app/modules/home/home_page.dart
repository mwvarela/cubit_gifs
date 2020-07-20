import 'package:cubit_gifs/app/modules/home/home_cubit.dart';
import 'package:cubit_gifs/app/shared/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatelessWidget {
  final Debouncer debouncer = Debouncer(milliseconds: 500);
  HomeCubit _cubit = Modular.get<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cubit Gifs'),
        centerTitle: true,
      ),
      body: CubitProvider(
        create: (context) => _cubit..findRandomGifs(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Pesquisar', border: OutlineInputBorder()),
                onChanged: (value) => debouncer(() => _cubit.findGif(value)),
              ),
            ),
            buildSelectedGif(),
            buildGifs(),
          ],
        ),
      ),
    );
  }

  Widget buildGifs() {
    return CubitConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty) {
          Fluttertoast.showToast(
            msg: state.errorMessage,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      builder: (context, state) {
        if (state.loading != null && state.loading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state.gifs.isNotEmpty) {
          return buildResult(state);
        }

        return Container();
      },
    );
  }

  Widget buildResult(HomeState state) {
    return Container(
      child: Expanded(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: state.gifs.length,
          itemBuilder: (context, index) {
            final gif = state.gifs[index];
            return InkWell(
              onTap: () => _cubit.selectGif(gif),
              child: Image.network(
                gif.url,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildSelectedGif() {
    return CubitConsumer<HomeCubit, HomeState>(
      cubit: _cubit,
      listenWhen: (previous, current) => previous.gifSelecionado != current.gifSelecionado,
      listener: (BuildContext context, state) {},
      buildWhen: (previous, current) => previous.gifSelecionado != current.gifSelecionado,
      builder: (BuildContext context, state) {
        if (state.gifSelecionado != null) {
          return Container(
            child: Expanded(
              child: Image.network(
                state.gifSelecionado.url,
                fit: BoxFit.cover,
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
