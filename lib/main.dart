
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rumah_sakit/blocs/auth/login/login_bloc.dart';
import 'package:rumah_sakit/blocs/auth/registration/registration_bloc.dart';
import 'package:rumah_sakit/repositories/auth_repository.dart';

import 'package:rumah_sakit/routes.dart';
import 'package:rumah_sakit/screens/splash_screen.dart';
import 'package:rumah_sakit/models/layar_screens.dart';
import 'package:rumah_sakit/screens/test_fetch_article.dart';
import 'package:rumah_sakit/screens/reservasi.dart';
import 'package:rumah_sakit/models/dokter_model.dart';
import 'package:rumah_sakit/screens/test_fetch_article.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {

    WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  final authRepository = AuthRepository(sharedPreferences);

  runApp(MyApp(sharedPreferences, authRepository));
}

class MyApp extends StatelessWidget {

  final SharedPreferences sharedPreferences;
  final AuthRepository authRepository;
  MyApp(this.sharedPreferences, this.authRepository);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    screens.setwidth(MediaQuery.of(context).size.width);

    screens.height = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(sharedPreferences, authRepository)),
        BlocProvider(create: (context) => RegistrationBloc(authRepository)),
      ],
      child: MaterialApp(
        title: 'MediFast',
        initialRoute: '/Splash',
        routes: routes,

        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

        debugShowCheckedModeBanner: false,

        home: const SplashScreen(),
        //home: Reservasi(dokter: data_dokter[0])
      ),
    );
  }
}
