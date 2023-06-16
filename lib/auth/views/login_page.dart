import 'package:bluetouch_admin/auth/models/auth_status.dart';
import 'package:bluetouch_admin/auth/providers/auth_provider.dart';
import 'package:bluetouch_admin/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authProvider, (previous, next) {
      if (next.status == AuthStatus.failed) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            showCloseIcon: true,
            content: Text("Email ou mot de passe incorrect")));
      }
    });

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Builder(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!ResponsiveUtils.isMobile(context))
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/f/f4/Madagascar_%2828262716001%29.jpg"))),
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          "https://upload.wikimedia.org/wikipedia/commons/f/f4/Madagascar_%2828262716001%29.jpg"),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text("Connexion", style: TextStyle(fontSize: 36)),
                    const SizedBox(
                      height: 16,
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            label: Text("Email"), icon: Icon(Icons.email)),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            label: Text("Mot de passe"),
                            icon: Icon(Icons.lock)),
                        onFieldSubmitted: (_) {
                          ref.read(authProvider.notifier).login(
                              password: passwordController.text,
                              email: emailController.text);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          ref.read(authProvider.notifier).login(
                              password: passwordController.text,
                              email: emailController.text);
                        },
                        child: const Text("Se connecter"))
                  ],
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
