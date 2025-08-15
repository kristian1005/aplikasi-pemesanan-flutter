import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.all(18.0),
            child: Column(
              children: [
                // 1. Gambar,
                Image.asset(
                  "lib/assets/images/login.png",
                  width: 300,
                ),
                // 2. Teks Judul,
                const SizedBox(height: 12),
                Text(
                  "Notes App",
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // 3. Inputan Username,
                const SizedBox(height: 12),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Username",
                    prefixIcon: Icon(Icons.person),
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 13),
                  ),
                ),
                // 4. Inputan Password,
                const SizedBox(height: 12),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.key),
                    suffixIcon: Icon(Icons.visibility),
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 13),
                  ),
                ),
                // 5. Tombol Login,
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {},
                    label: Text("Login"),
                    icon: Icon(Icons.login),
                  ),
                ),
                // 6. Teks Buat Akun,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Create account"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
