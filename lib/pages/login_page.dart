import 'package:flutter/material.dart';
import 'package:gcl_warehouse/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  Future<void> _loadRememberMe() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!mounted) return;
      setState(() {
        _rememberMe = prefs.getBool('rememberMe') ?? false;
        if (_rememberMe) {
          _usernameController.text = prefs.getString('username') ?? '';
        }
      });
    } catch (_) {
      // Ignore errors
    }
  }

  Future<void> _saveRememberMe() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('rememberMe', _rememberMe);
      if (_rememberMe) {
        await prefs.setString('username', _usernameController.text.trim());
      } else {
        await prefs.remove('username');
      }
    } catch (_) {}
  }

  Future<bool> _attemptLogin() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if ((username == 'admin' && password == 'admin') || (username == 'user' && password == 'user')) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F172A),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 520),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(child: Image.asset('assets/images/logo.webp', height: 30)),
                      const SizedBox(height: 10),
                      const Center(
                        child: Text(
                          'Warehouse Management System',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) => setState(() => _rememberMe = value!),
                          ),
                          const Text('Remember me'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          final navigator = Navigator.of(context);
                          final messenger = ScaffoldMessenger.of(context);

                          final success = await _attemptLogin();
                          if (success) {
                            await _saveRememberMe();
                          }
                          if (!mounted) return;

                          if (success) {
                            navigator.pushReplacement(
                              MaterialPageRoute(builder: (_) => HomeGCLPage()),
                            );
                          } else {
                            messenger.showSnackBar(
                              const SnackBar(content: Text('Invalid credentials')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF214098),
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                        ),
                        child: const Text('Sign in', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}