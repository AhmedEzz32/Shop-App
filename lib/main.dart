import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'layout/shop_layout.dart';
import 'modules/login/shop_login_screen.dart';
import 'shared/bloc_observer.dart';
import 'shared/components/constants.dart';
import 'shared/network/local/cashe_helper.dart';
import 'shared/network/remote/diohelper.dart';
import 'shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // BY2KD EN KOL HAGA FY METHOD KHELST w b3den yf7 app
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CasheHelper.init();
  late Widget widget;
   uId = CasheHelper.getData(key: 'uId');

  if(uId != null)
    {
      widget = const ShopLayout();
    }else
      {
        widget = ShopLoginScreen();
      }

  runApp(MyApp(
    startWidget: widget,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Widget? startWidget;

  MyApp({super.key,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavourite()
            ..getUserData(),
        ),

      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
