import 'package:flutter/material.dart';
import 'package:flutter_shared_preferences_app/auth/auth_local_datasource.dart';
import 'package:flutter_shared_preferences_app/ui/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 120,
          ),
          const Text(
            'Login',
            style: TextStyle(fontSize: 34),
          ),
          const SizedBox(
            height: 50,
          ),
          TextField(
            decoration: const InputDecoration(
              label: Text('Email'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            controller: emailController,
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: const InputDecoration(
              label: Text('Password'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            controller: passwordController,
            obscureText: true,
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: double.infinity, // Mengatur lebar tombol agar sesuai dengan lebar TextField
            child: ElevatedButton(
              onPressed: () {
                if (emailController.text == 'admin123@gmail.com' &&
                    passwordController.text == '12345678') {
                  AuthLocalDatasource().saveToken('12345678');
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const HomePage();
                  }));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Login Gagal'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue[700], 
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), 
                ),
                elevation: 5,
              ),
              child: const Text('Login'),
            ),
          ),
        ],
      ),
    ),
  );
}
}