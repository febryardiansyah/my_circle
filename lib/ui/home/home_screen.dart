import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_circle/bloc/get_groups/get_groups_cubit.dart';
import 'package:my_circle/repositories/auth_repo.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetGroupsCubit>().fetchGroups();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: ()async{
              final _repo = AuthRepo();
              await _repo.removeToken();
            },
          ),
        ],
      ),
      body: BlocBuilder<GetGroupsCubit, GetGroupsState>(
        builder: (context, state) {
          if (state is GetGroupsLoading) {
            return Center(child: CupertinoActivityIndicator(),);
          }
          if (state is GetGroupsFailure) {
            return Center(child: Text(state.msg),);
          }
          if (state is GetGroupsSuccess) {
            final _data = state.data!;
            return _data.groups == null?Center(
              child: Text('Empty'),
            ):ListView.builder(
              itemCount: _data.groups!.length,
              itemBuilder: (context,i){
                final _item = _data.groups![i];
                return ListTile(
                  title: Text(_item.groupName!),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
