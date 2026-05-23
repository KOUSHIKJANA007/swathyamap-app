import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../feature/auth/domain/entities/user.dart';
import '../../feature/auth/presentation/bloc/auth_bloc.dart';

extension AuthContextExtension on BuildContext {
  User? get currentUser {
    final state = read<AuthBloc>().state;
    return state.currentUser;
  }
}