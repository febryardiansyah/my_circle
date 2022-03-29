import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_circle/bloc/auth/auth_cubit.dart';
import 'package:my_circle/bloc/login/login_cubit.dart';
import 'package:my_circle/bloc/register/register_cubit.dart';
import 'package:my_circle/utils/base_color.dart';
import 'package:my_circle/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>RegisterCubit()),
        BlocProvider(create: (_)=>LoginCubit()),
        BlocProvider(create: (context)=>AuthCubit(context.read<LoginCubit>())),
      ],
      child: MaterialApp(
        title: 'My Circle',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: BaseColor.mainColor),
        ),
        initialRoute: rIndex,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
