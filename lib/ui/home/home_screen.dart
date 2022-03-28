import 'package:flutter/material.dart';
import 'package:my_circle/repositories/auth_repo.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(Icons.logout),
          onPressed: ()async{
            final _repo = AuthRepo();
            await _repo.removeToken();
          },
        ),
      ),
    );
  }
}
