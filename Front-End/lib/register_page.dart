import 'package:Chat_App/services/auth_servicesFirebase.dart';
import 'package:Chat_App/utils/brand_colors.dart';
import 'package:Chat_App/utils/glass_box.dart';
import 'package:Chat_App/utils/spaces.dart';
import 'package:Chat_App/widgets/login_field.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_buttons/social_media_button.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RegisterPage({super.key});
  Widget _buildHeader(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.32,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage('assets/images/Illustration-register.png'),
            ),
          )),
    );
  }

  Widget _buildMain(BuildContext context) {
    return Stack(children: [
      GlassBox(
        height: MediaQuery.of(context).size.height * 0.68,
        width: MediaQuery.of(context).size.width,
      ),
      Center(
          child: Column(children: [
        verticalSpacing(30),
        AutoSizeText(
          "Get Started Free",
          style: GoogleFonts.poppins(
              fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        verticalSpacing(5),
        AutoSizeText(
          "Free Forever. No Credit Card Needed",
          style: GoogleFonts.poppins(
              fontSize: 15, color: BrandColors.loginScreenColor),
        ),
        verticalSpacing(25),
        Form(
          key: _formKey,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              children: [
                verticalSpacing(10),
                LoginField(
                  icon: Icon(Icons.person),
                  controller: controllerUsername,
                  type: "Username",
                  obscureTextEnabled: false,
                ),
                verticalSpacing(15),
                LoginField(
                  icon: Icon(Icons.mail),
                  controller: controllerEmail,
                  type: "Email",
                  obscureTextEnabled: false,
                ),
                verticalSpacing(15),
                LoginField(
                    icon: Icon(Icons.key),
                    secondIcon: Icon(Icons.remove_red_eye),
                    controller: controllerPassword,
                    type: "Password",
                    obscureTextEnabled: true),
                verticalSpacing(20),
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
                      await registerUser(context, controllerUsername,controllerEmail,
                          controllerPassword, _formKey);
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
              ],
            ),
          ),
        ),
        verticalSpacing(10),
        Center(
            child: Text(
          "Or",
          style: GoogleFonts.poppins(color: Colors.white),
        )),
        verticalSpacing(10),
        Container(
          height: MediaQuery.of(context).size.height * 0.045,
          width: MediaQuery.of(context).size.width * 0.46,
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
                "/login",
              );
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
        )
      ]))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BrandColors.backgroundColor,
        resizeToAvoidBottomInset: false,
        body: Column(children: [_buildHeader(context), _buildMain(context)]));
  }
}
