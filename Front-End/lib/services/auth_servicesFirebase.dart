import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



Future<void> loginUser(
    BuildContext context,
    TextEditingController controllerUsername,
    TextEditingController controllerPassword, GlobalKey<FormState> formKey) async {
  if (formKey.currentState != null && formKey.currentState!.validate()) {
    final url = Uri.parse('http://37.63.57.37:3000/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userName': controllerUsername.text,
          'password': controllerPassword.text,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, "/contacts",
            arguments: controllerUsername.text);
        print('Login successful');
      } else {
        final responseBody = json.decode(response.body);
        print('Login failed: ${responseBody['message']}');
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Login Failed'),
              content: Text(responseBody['message']),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Error: $error');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Failed to connect to server. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}


Future<void> registerUser(
    BuildContext context,TextEditingController controllerUsername,
    TextEditingController controllerEmail,
    TextEditingController controllerPassword,GlobalKey<FormState> formKey) async {
  if (formKey.currentState != null && formKey.currentState!.validate()) {
    final url = Uri.parse('http://37.63.57.37:3000/register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userName': controllerUsername.text,
          'email': controllerEmail.text,
          'password': controllerPassword.text,
        }),
      );

      if (response.statusCode == 201) {
        print('User registered successfully');
        print(json.decode(response.body));
        await loginUser(context,controllerUsername, controllerPassword, formKey);
      } else {
        final responseBody = json.decode(response.body);
        print('Failed to register user: ${responseBody['error']}');
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Registration Failed'),
              content: Text(responseBody['error']),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Error: $error');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Failed to connect to server. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
