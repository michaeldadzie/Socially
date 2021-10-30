import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socially/features/authentication/presentation/extension/form_extension.dart';
import 'package:socially/features/authentication/presentation/utils/const.dart';
import 'package:socially/features/authentication/presentation/widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';
  LoginScreen({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
        settings: const RouteSettings(name: routeName),
        transitionDuration: const Duration(seconds: 0),
        pageBuilder: (_, __, ___) => LoginScreen());
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Socially',
                          style: GoogleFonts.lato(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          decoration: textFormFieldDecoration.copyWith(
                            hintText: 'Email',
                          ),
                          style: GoogleFonts.lato(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(136, 147, 164, 1),
                          ),
                          onChanged: (value) => print(value),
                          validator: (String? v) {
                            if (v!.isValidEmail) {
                              return null;
                            } else {
                              return 'Please enter a valid email';
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          decoration: textFormFieldDecoration.copyWith(
                            hintText: 'Password',
                          ),
                          style: GoogleFonts.lato(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(136, 147, 164, 1),
                          ),
                          onChanged: (value) => print(value),
                          validator: (String? v) {
                            if (v!.isValidPassword) {
                              return null;
                            } else {
                              return 'Must be at least 8 characters';
                            }
                          },
                        ),
                        const SizedBox(height: 28),
                        CustomButton(
                          title: 'Log In',
                          bordersideColor: Colors.blue,
                          textColor: Colors.white,
                          backgroundColor: Colors.blue,
                          onPress: () {},
                        ),
                        const SizedBox(height: 12),
                        CustomButton(
                          title: 'Sign Up',
                          bordersideColor: Colors.grey.shade200,
                          textColor: Colors.black,
                          backgroundColor: Colors.grey.shade200,
                          onPress: () {},
                        ),
                      ],
                    ),
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
