import 'package:flutter_modular/flutter_modular.dart';

import '../../repositories/gifs_repository.dart';
import 'home_cubit.dart';
import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => GifsRepository()),
        Bind((i) => HomeCubit(i())),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
