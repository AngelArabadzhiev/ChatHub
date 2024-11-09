import 'package:Chat_App/services/auth_servicesFirebase.dart';
import 'package:Chat_App/utils/brand_colors.dart';
import 'package:Chat_App/utils/glass_box.dart';
import 'package:Chat_App/utils/spaces.dart';
import 'package:Chat_App/widgets/login_field.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:social_media_buttons/social_media_button.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  Widget _buildHeader(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.27,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage('assets/images/login-background.png'),
          ),
        ),
      ),
    );
  }

  Widget _buildMain(BuildContext context) {
    return Stack(children: [
       GlassBox(height: MediaQuery.of(context).size.height * 0.73,width: MediaQuery.of(context).size.width,),
      Center(
          child: Column(children: [
        verticalSpacing(40),
        AutoSizeText(
          "Welcome back!",
          style: GoogleFonts.poppins(
              fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
        ),
          verticalSpacing(10),
          AutoSizeText(
          "welcome back we missed you",
          style: GoogleFonts.poppins(
              fontSize: 15, color: BrandColors.loginScreenColor),
        ),
        verticalSpacing(35),
        Form(
          key: _formKey,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText('Username',
                        style: GoogleFonts.poppins(
                            color: BrandColors.loginScreenColor,
                            fontSize: 15))),
                verticalSpacing(10),
                LoginField(
                  icon: Icon(Icons.person),
                  controller: controllerUsername,
                  type: "Username",
                  obscureTextEnabled: false,
                ),
                verticalSpacing(15),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Password',
                        style: TextStyle(
                          color: BrandColors.loginScreenColor,
                        ))),
                verticalSpacing(10),
                LoginField(
                    icon: Icon(Icons.key),
                    secondIcon: Icon(Icons.remove_red_eye),
                    controller: controllerPassword,
                    type: "Password",
                    obscureTextEnabled: true),
                verticalSpacing(15),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text('Forgot password?',
                        style: TextStyle(
                          color: BrandColors.loginScreenColor,
                        ))),
                verticalSpacing(15),
                Container(
                  height: MediaQuery.of(context).size.height * 0.056,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(colors: [
                        Color.fromRGBO(156, 63, 228, 100),
                        Color.fromRGBO(198, 86, 71, 100)
                      ])),
                  child: ElevatedButton(
                    onPressed: () async {
                      await loginUser(context, controllerUsername,
                          controllerPassword, _formKey);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: Text(
                      'Sign in',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        verticalSpacing(15),
        Center(
            child: AutoSizeText(
          "Or",
          style: GoogleFonts.poppins(color: BrandColors.loginScreenColor),
        )),
        verticalSpacing(15),
            Container(
              height: MediaQuery.of(context).size.height * 0.056,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(colors: [
                    Color.fromRGBO(156, 63, 228, 100),
                    Color.fromRGBO(198, 86, 71, 100)
                  ])),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    "/register",
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent),
                child: Text(
                  'Sign up',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
      ]))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BrandColors.backgroundColor,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [_buildHeader(context), _buildMain(context)],
          ),
        ));
  }
}
