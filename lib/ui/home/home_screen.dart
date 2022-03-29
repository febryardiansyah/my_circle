import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_circle/bloc/create_group/create_group_cubit.dart';
import 'package:my_circle/bloc/get_groups/get_groups_cubit.dart';
import 'package:my_circle/bloc/join_group/join_group_cubit.dart';
import 'package:my_circle/bloc/login/login_cubit.dart';
import 'package:my_circle/utils/base_color.dart';
import 'package:my_circle/utils/routes.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final groupNameCtrl = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<GetGroupsCubit>().fetchGroups();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          showDialog(context: context, builder: (context)=>AlertDialog(
            title: Text('New Group'),
            content: TextFormField(
              controller: groupNameCtrl,
            ),
            actions: [
              IconButton(
                onPressed: (){
                  Navigator.pop(context);
                  context.read<JoinGroupCubit>().joinGroup(groupCode: groupNameCtrl.text);
                  // context.read<CreateGroupCubit>().createGroup(groupName: groupNameCtrl.text);
                },
                icon: Icon(Icons.done_all),),
            ],
          ));
        },
        label: Text('Create'),
        // child: Icon(Icons.join_full),
      ),
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: ()async{
              context.read<LoginCubit>().logout();
            },
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CreateGroupCubit, CreateGroupState>(
            listener: (context, state) {
              if (state is CreateGroupLoading) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text('Loading...')));
              }
              if (state is CreateGroupFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(state.msg)));
              }
              if (state is CreateGroupSuccess) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(state.msg)));
                context.read<GetGroupsCubit>().fetchGroups();
              }
            },
          ),
          BlocListener<JoinGroupCubit, JoinGroupState>(
            listener: (context, state) {
              if (state is JoinGroupLoading) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text('Loading...')));
              }
              if (state is JoinGroupFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(state.msg)));
              }
              if (state is JoinGroupSuccess) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(state.msg)));
                context.read<GetGroupsCubit>().fetchGroups();
              }
            },
          ),
          BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LogoutLoading) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text('Loading...')));
              }
              if (state is LogoutFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(state.msg)));
              }
              if (state is LogoutSuccess) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(state.msg)));
                Navigator.pushNamedAndRemoveUntil(context, rLogin, (route) => false);
              }
            },
          ),
        ],
        child: BlocBuilder<GetGroupsCubit, GetGroupsState>(
          builder: (context, state) {
            if (state is GetGroupsLoading) {
              return Center(child: CupertinoActivityIndicator(),);
            }
            if (state is GetGroupsFailure) {
              return Center(child: Text(state.msg),);
            }
            if (state is GetGroupsSuccess) {
              final _data = state.data!;
              return _data.isEmpty?Center(
                child: Text('Empty'),
              ):ListView.builder(
                itemCount: _data.length,
                itemBuilder: (context,i){
                  final _item = _data[i];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(_item.groupProfile!,),
                      backgroundColor: BaseColor.white,
                    ),
                    title: Text(_item.groupName!,style: TextStyle(fontWeight: FontWeight.bold)),
                  );
                },
              );
            }
            return Container();
          },
        ),
),
    );
  }
}
