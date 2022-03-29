import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_circle/bloc/register/register_cubit.dart';
import 'package:my_circle/utils/base_color.dart';

import '../../bloc/register/register_cubit.dart';
import '../../bloc/register/register_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool isPassInvisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.mainColor,
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text('Loading..')));
          }
          if (state is RegisterFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.msg)));
          }
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.msg)));
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
                  height: 8,
                ),
                TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    FontAwesomeIcons.arrowLeft,
                    color: BaseColor.white,
                  ),
                  label: Text(
                    'Back',
                    style: TextStyle(color: BaseColor.white),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Text(
                  'Create new account',
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
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
                        controller: nameCtrl,
                        decoration: InputDecoration(
                          hintText: 'Enter your name',
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
                        keyboardType: TextInputType.emailAddress,
                        controller: emailCtrl,
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
                        obscureText: isPassInvisible,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          filled: true,
                          fillColor: BaseColor.grey1,
                          suffixIcon: IconButton(
                            icon: Icon(isPassInvisible?FontAwesomeIcons.eyeSlash:FontAwesomeIcons.eye),
                            onPressed: (){
                              setState(() {
                                isPassInvisible = !isPassInvisible;
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
                          onTap: () {
                            context.read<RegisterCubit>().register(
                              name: nameCtrl.text, email: emailCtrl.text,
                              password: passCtrl.text,
                            );
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
