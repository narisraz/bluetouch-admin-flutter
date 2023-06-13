import 'package:bluetouch_admin/auth/bloc/auth_bloc.dart';
import 'package:bluetouch_admin/auth/models/auth_user.dart';
import 'package:bluetouch_admin/auth/repository/auth_repository.dart';
import 'package:bluetouch_admin/auth/views/login_page.dart';
import 'package:bluetouch_admin/firebase_options.dart';
import 'package:bluetouch_admin/infrastructure/auth_firebase_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetouch Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RepositoryProvider<AuthProvider>(
        create: (context) => AuthFirebaseProvider(),
        child: BlocProvider(
          create: (context) => AuthBloc(context),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              FirebaseAuth.instance.authStateChanges().listen((user) {
                if (user != null) {
                  context.read<AuthBloc>().add(AuthEventInitial(
                      authStatus: AuthStatus.loggedIn,
                      authUser: AuthUser(id: user.uid, email: user.email!)));
                }
              });
              if (state.authStatus == AuthStatus.loggedIn) {
                return ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthEventLogout());
                    },
                    child: const Text("Se déconnecter"));
              }
              return const LoginPage();
            },
          ),
        ),
      ),
    );
  }
}
