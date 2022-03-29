import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_circle/bloc/auth/auth_cubit.dart';
import 'package:my_circle/bloc/create_group/create_group_cubit.dart';
import 'package:my_circle/bloc/get_groups/get_groups_cubit.dart';
import 'package:my_circle/bloc/join_group/join_group_cubit.dart';
import 'package:my_circle/bloc/login/login_cubit.dart';
import 'package:my_circle/bloc/register/register_cubit.dart';
import 'package:my_circle/utils/base_color.dart';
import 'package:my_circle/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = new MyHttpOverrides();
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
        BlocProvider(create: (_)=>GetGroupsCubit()),
        BlocProvider(create: (_)=>CreateGroupCubit()),
        BlocProvider(create: (_)=>JoinGroupCubit()),
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true; }
}