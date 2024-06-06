import 'package:flutter/material.dart';
<<<<<<< Updated upstream
=======
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rumah_sakit/blocs/auth/login/login_bloc.dart';
import 'package:rumah_sakit/blocs/auth/registration/registration_bloc.dart';
import 'package:rumah_sakit/repositories/auth_repository.dart';
import 'package:rumah_sakit/routes.dart';
>>>>>>> Stashed changes
import 'package:rumah_sakit/screens/splash_screen.dart';
import 'package:rumah_sakit/models/layar_screens.dart';
import 'package:rumah_sakit/screens/test_fetch_article.dart';
import 'package:rumah_sakit/screens/reservasi.dart';
import 'package:rumah_sakit/models/dokter_model.dart';
import 'package:rumah_sakit/screens/test_fetch_article.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    screens.setwidth(MediaQuery.of(context).size.width);

    screens.height = MediaQuery.of(context).size.height;
<<<<<<< Updated upstream
    return MaterialApp(
      title: 'MediFast',
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
=======
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(sharedPreferences, authRepository)),
        BlocProvider(create: (context) => RegistrationBloc(authRepository)),
      ],
      child: MaterialApp(
        title: 'MediFast',
        initialRoute: '/home',
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
>>>>>>> Stashed changes
      ),

      debugShowCheckedModeBanner: false,

      // home: const SplashScreen(),
      home: Reservasi(dokter: data_dokter[0])

    );
  }
}
