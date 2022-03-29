import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_circle/bloc/auth/auth_cubit.dart';
import 'package:my_circle/ui/auth/login_screen.dart';
import 'package:my_circle/ui/home/home_screen.dart';
import 'package:my_circle/ui/my_bottom_navbar.dart';

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {

  @override
  void initState() {
    super.initState();
    //init auth
    context.read<AuthCubit>().appStarted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthUnAuthenticated) {
            return LoginScreen();
          }
          if (state is AuthAuthenticated) {
            return MyBottomNavbar();
          }
          return Container();
        },
      ),
    );
  }
}
