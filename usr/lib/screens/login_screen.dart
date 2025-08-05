import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();

  void _login() {
    // 注意：这只是一个用于演示的占位符。
    // 需要选择一个 Supabase 项目来实现真正的用户认证。
    if (_usernameController.text.isNotEmpty) {
      // 登录成功后，跳转到聊天页面并传递用户名
      Navigator.pushReplacementNamed(context, '/chat', arguments: _usernameController.text);
    } else {
      // 如果用户名为空，则提示用户
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入一个用户名')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登录'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: '用户名',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text('进入聊天室'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
