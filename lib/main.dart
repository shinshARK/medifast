import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rumah_sakit/blocs/article/article_bloc.dart';
import 'package:rumah_sakit/blocs/auth/login/login_bloc.dart';
import 'package:rumah_sakit/blocs/auth/registration/registration_bloc.dart';
import 'package:rumah_sakit/blocs/doctor/doctor_bloc.dart';
import 'package:rumah_sakit/blocs/riwayat/riwayat_bloc.dart';
import 'package:rumah_sakit/repositories/article_repository.dart';
import 'package:rumah_sakit/repositories/auth_repository.dart';
import 'package:rumah_sakit/repositories/doctor_repository.dart';
import 'package:rumah_sakit/repositories/transaction_repository.dart';

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
  final doctorRepository = DoctorRepository(sharedPreferences);
  final transactionRepository = TransactionRepository(sharedPreferences);

  final user = sharedPreferences.getString('user');
  final tokens = sharedPreferences.getString('tokens');

  final isUserLoggedIn = user != null && tokens != null;

  final initialRoute = isUserLoggedIn ? '/home' : '/login';

  runApp(
      MyApp(sharedPreferences, authRepository, initialRoute, doctorRepository,transactionRepository));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  final AuthRepository authRepository;
  final DoctorRepository doctorRepository;
  final String initialRoute;
   final TransactionRepository transactionRepository;
  MyApp(this.sharedPreferences, this.authRepository, this.initialRoute,
      this.doctorRepository, this.transactionRepository);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    screens.setwidth(MediaQuery.of(context).size.width);

    screens.height = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => LoginBloc(sharedPreferences, authRepository)),
        BlocProvider(create: (context) => RegistrationBloc(authRepository)),
        BlocProvider(
            create: (context) =>
                DoctorBloc(sharedPreferences, doctorRepository)),
        BlocProvider(
          create: (context) =>
              ArticleBloc(ArticleRepository(sharedPreferences)),
        ),
        BlocProvider(
          create: (context) => TransactionBloc(sharedPreferences, transactionRepository),
        ),
      ],
      child: MaterialApp(
        title: 'MediFast',

        initialRoute: initialRoute,

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
