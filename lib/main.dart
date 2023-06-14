import 'package:bluetouch_admin/auth/bloc/auth_bloc.dart';
import 'package:bluetouch_admin/auth/models/auth_user.dart';
import 'package:bluetouch_admin/auth/repository/auth_repository.dart';
import 'package:bluetouch_admin/auth/views/login_page.dart';
import 'package:bluetouch_admin/company/repository/company_repository.dart';
import 'package:bluetouch_admin/company/views/company_list_page.dart';
import 'package:bluetouch_admin/drawer.dart';
import 'package:bluetouch_admin/firebase_options.dart';
import 'package:bluetouch_admin/infrastructure/auth_firebase_provider.dart';
import 'package:bluetouch_admin/infrastructure/company_firestore_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    final firestore = FirebaseFirestore.instance;

    return MaterialApp(
      title: 'Bluetouch Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: RepositoryProvider<AuthProvider>(
        create: (context) => AuthFirebaseProvider(),
        child: BlocProvider(
          create: (context) => AuthBloc(context),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              var currentUser = FirebaseAuth.instance.currentUser;
              if (currentUser != null) {
                context.read<AuthBloc>().add(AuthEventInitial(
                    authStatus: AuthStatus.loggedIn,
                    authUser: AuthUser(
                        id: currentUser.uid, email: currentUser.email!)));
              }
              if (state.authStatus != AuthStatus.loggedIn) {
                return const LoginPage();
              }
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Bluetouch Admin"),
                ),
                drawer: const AppDrawer(),
                body: MultiRepositoryProvider(
                  providers: [
                    RepositoryProvider<CompanyRepository>(
                        create: (_) => CompanyFirestoreRepository(firestore)),
                  ],
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: const CompanyListPage(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
