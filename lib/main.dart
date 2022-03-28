import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_circle/bloc/auth/auth_cubit.dart';
import 'package:my_circle/bloc/login/login_cubit.dart';
import 'package:my_circle/bloc/register/register_cubit.dart';
import 'package:my_circle/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>RegisterCubit()),
        BlocProvider(create: (_)=>LoginCubit()),
        BlocProvider(create: (_)=>AuthCubit(LoginCubit())),
      ],
      child: MaterialApp(
        title: 'My Circle',
        debugShowCheckedModeBanner: false,
        initialRoute: rIndex,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
