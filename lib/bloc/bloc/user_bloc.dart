import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:technical_test/models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is FetchUsers) {
        emit(UserLoading());
        try {
          final response =
              await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
          if (response.statusCode == 200) {
            emit(UserLoaded(UserResponse.fromJson(jsonDecode(response.body))));
          } else {
            emit(UserError('Failed to fetch data'));
          }
        } catch (e) {
          emit(UserError(e.toString()));
        }
      }
    });
  }
}
