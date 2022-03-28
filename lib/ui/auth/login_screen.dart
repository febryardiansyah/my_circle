import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_circle/bloc/login/login_cubit.dart';
import 'package:my_circle/utils/base_color.dart';
import 'package:my_circle/utils/routes.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool isInvisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.mainColor,
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text('Loading..')));
          }
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.msg)));
          }
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.msg)));
            Navigator.pushReplacementNamed(context, rHome);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  'Login to access the app',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: BaseColor.white,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: BaseColor.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          filled: true,
                          fillColor: BaseColor.grey1,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                            BorderSide(width: 1, color: BaseColor.grey2),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: passCtrl,
                        obscureText: isInvisible,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          filled: true,
                          fillColor: BaseColor.grey1,
                          suffixIcon: IconButton(
                            icon: Icon(isInvisible?FontAwesomeIcons.eyeSlash:FontAwesomeIcons.eye),
                            onPressed: (){
                              setState(() {
                                isInvisible = !isInvisible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                            BorderSide(width: 1, color: BaseColor.grey2),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: (){
                            context.read<LoginCubit>().login(email: emailCtrl.text, password: passCtrl.text);
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: BaseColor.mainColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 1,
                                  spreadRadius: 2,
                                  color: Colors.black.withOpacity(0.3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.arrowRight,
                                color: BaseColor.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context,rRegister),
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(fontWeight: FontWeight.normal),
                      children: [
                        TextSpan(
                          text: 'Create new one here',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
