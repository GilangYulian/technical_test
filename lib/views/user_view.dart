import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test/views/user_list.dart';

import '../bloc/bloc/user_bloc.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: BlocProvider(
        create: (context) => UserBloc()..add(FetchUsers()),
        child: const UserList(),
      ),
    );
  }
}
