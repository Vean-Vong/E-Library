import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libraries/Service_api/Auth_Service.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> createAccountPressed() async {
    if (_formKey.currentState?.validate() != true) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await AuthServices.register(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
        phoneController.text.trim(),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Account created successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        await Future.delayed(Duration(seconds: 2));
        Navigator.pushNamed(context, "/Login");
      } else {
        final responseMap = jsonDecode(response.body);
        final errorMessage = responseMap["message"] ?? "Registration failed";
        showErrorSnackBar(errorMessage);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error: $e");
      showErrorSnackBar("An error occurred. Please try again.");
    }
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Logo.png',
                width: 200,
                fit: BoxFit.contain,
              ),
              Text(
                'Registration',
                textAlign: TextAlign.center,
                style: GoogleFonts.adamina(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      controller: nameController,
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      icon: Icons.person,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Enter a username'
                          : null,
                    ),
                    SizedBox(height: 10),
                    _buildTextField(
                      controller: emailController,
                      labelText: 'Email',
                      hintText: 'Enter your email address',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Enter an email';
                        final emailRegExp =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegExp.hasMatch(value))
                          return 'Enter a valid email';
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    _buildTextField(
                      controller: passwordController,
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      icon: Icons.lock,
                      obscureText: true,
                      validator: (value) => value == null || value.length < 6
                          ? 'Password too short'
                          : null,
                    ),
                    SizedBox(height: 10),
                    _buildTextField(
                      controller: phoneController,
                      labelText: 'Phone',
                      hintText: 'Enter your phone number',
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Enter your phone number'
                          : null,
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : createAccountPressed,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.indigo[900],
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Register',
                                style: GoogleFonts.adamina(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/Login');
                          },
                          child: Text('Login Here!'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
    );
  }
}
