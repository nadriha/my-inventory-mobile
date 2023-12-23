import 'package:flutter/material.dart';
import 'package:my_inventory/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';


void main() {
    runApp(const RegisterApp());
}

class RegisterApp extends StatelessWidget {
  const RegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
          title: 'Register',
          theme: ThemeData(
              primarySwatch: Colors.blue,
      ),
      home: const RegisterPage(),
      );
      }
}

class RegisterPage extends StatefulWidget {
    const RegisterPage({super.key});

    @override
    _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    bool passToggle = false;

    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
        return Scaffold(
            appBar: AppBar(
                title: Center(child: const Text('Register')),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  height: 700,
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            
                              const SizedBox(height: 30,),
                              TextField(
                                  controller: _usernameController,
                                  decoration: InputDecoration(
                                      labelText: 'Username',
                                      hintText: 'Username',
                                  ),
                              ),
                              const SizedBox(height: 20,),
                              TextField(
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                      labelText: 'Password',
                                      hintText: 'Password',
                                  ),
                                  obscureText: !passToggle,
                              ),
                              const SizedBox(height: 30,),
                              MaterialButton(
                                  onPressed: () async {
                                      String username = _usernameController.text;
                                      String password = _passwordController.text;
                                      // Cek kredensial
                                      // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                                      // Untuk menyambungkan Android emulator dengan Django pada localhost,
                                      // gunakan URL http://10.0.2.2/
                                      final response = await request.post("http://127.0.0.1:8000/register-flutter/", {
                                      'username': username,
                                      'password': password,
                                      });
                                
                                      if (response['status']) {
                                        String message = response['message'];
                                
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => const LoginPage()),
                                        );
                                        ScaffoldMessenger.of(context)
                                          ..hideCurrentSnackBar()
                                          ..showSnackBar(SnackBar(content: Text(message)));
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Register Gagal'),
                                            content: Text(response['message']),
                                            actions: [
                                              TextButton(
                                                child: const Text('OK'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                  },
                                  height: 45,
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                                  shape: RoundedRectangleBorder(
              
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: const Text('Register'),
                              ),
                              const SizedBox(height: 15.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Already have an account?"),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => LoginPage()),
                                      );
                                    },
                                    child: const Text(
                                      'Login', style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                      ),
                    ),
                ),
              ),
            ),
        );
    }
}