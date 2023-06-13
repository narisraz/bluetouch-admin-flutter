import 'dart:async';

import 'package:bluetouch_admin/auth/models/auth_user.dart';
import 'package:bluetouch_admin/auth/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final BuildContext _context;
  late final AuthProvider _authProvider;

  AuthBloc(this._context) : super(const AuthState()) {
    _authProvider = RepositoryProvider.of(_context);
    on<AuthEventLogin>(_onLogin);
    on<AuthEventInitial>(_onAuthInitial);
    on<AuthEventLogout>(_onLogout);
  }

  FutureOr<void> _onLogin(AuthEventLogin event, Emitter<AuthState> emit) async {
    try {
      final authUser = await _authProvider.login(event.email, event.password);
      if (authUser != null) {
        emit(AuthState(
            authenticatedUser: authUser, authStatus: AuthStatus.loggedIn));
      } else {
        emit(const AuthState(authStatus: AuthStatus.fail));
      }
    } catch (e) {
      emit(const AuthState(authStatus: AuthStatus.fail));
    }
  }

  FutureOr<void> _onAuthInitial(
      AuthEventInitial event, Emitter<AuthState> emit) async {
    try {
      final loggedInUser = await _authProvider.getCurrentLoggedInUser();
      if (loggedInUser != null) {
        emit(AuthState(
            authStatus: AuthStatus.loggedIn,
            authenticatedUser: event.authUser));
      } else {
        emit(const AuthState());
      }
    } catch (e) {
      emit(const AuthState(authStatus: AuthStatus.fail));
    }
  }

  FutureOr<void> _onLogout(
      AuthEventLogout event, Emitter<AuthState> emit) async {
    try {
      await _authProvider.logout();
      emit(const AuthState(authStatus: AuthStatus.loggedOut));
    } catch (e) {
      emit(const AuthState(authStatus: AuthStatus.fail));
    }
  }
}
