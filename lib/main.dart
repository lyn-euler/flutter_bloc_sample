import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sample/module/collection/widget/articles_page.dart';
import 'package:flutter_bloc_sample/module/login/bloc/login_bloc.dart';
import 'package:flutter_bloc_sample/module/login/widget/login_page.dart';

void main() {
  if (kDebugMode) {
    BlocSupervisor.delegate = SimpleBlocDelegate();
  }

  runApp(BlocProvider(
    create: (context) => LoginBloc(),
    child: MyApp(), //ArticlesPage(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
//        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          bool hasToken = false;
          if (state is LoginSuccess) {
            hasToken = state.token != null;
          }else if(state is LoginInit) {
            hasToken = state.token != null;
          }
          return hasToken ? ArticlesPage() : LoginPage();
        },
      ),
    );
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    debugPrint("$event");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint("${transition.toString()}");
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    debugPrint('$error, $stacktrace');
  }
}
