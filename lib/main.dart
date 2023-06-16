import 'package:bluetouch_admin/auth/models/auth_state.dart';
import 'package:bluetouch_admin/auth/models/auth_status.dart';
import 'package:bluetouch_admin/auth/models/auth_user.dart';
import 'package:bluetouch_admin/auth/providers/auth_provider.dart';
import 'package:bluetouch_admin/auth/views/login_page.dart';
import 'package:bluetouch_admin/company/views/company_list_page.dart';
import 'package:bluetouch_admin/drawer.dart';
import 'package:bluetouch_admin/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        ref.read(authProvider.notifier).setState(AuthState(
            status: AuthStatus.success,
            currentUser: AuthUser(
                email: event.email!, id: event.uid, role: AuthUserRole.admin)));
      }
    });
    return MaterialApp(
      title: 'Bluetouch Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Builder(builder: (context) {
        if (authState.status != AuthStatus.success) {
          return const Scaffold(body: LoginPage());
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Bluetouch Admin"),
          ),
          drawer: const AppDrawer(),
          body: Container(
            padding: const EdgeInsets.all(16.0),
            child: const CompanyListPage(),
          ),
        );
      }),
    );
  }
}
