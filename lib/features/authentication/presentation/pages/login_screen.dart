import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socially/features/authentication/data/repositories/auth_repository.dart';
import 'package:socially/features/authentication/presentation/cubit/login_cubit.dart';
import 'package:socially/features/authentication/presentation/extension/form_extension.dart';
import 'package:socially/features/authentication/presentation/pages/signup_screen.dart';
import 'package:socially/features/authentication/presentation/utils/const.dart';
import 'package:socially/features/authentication/presentation/widgets/custom_button.dart';
import 'package:socially/features/authentication/presentation/widgets/error_dialog.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  LoginScreen({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
        settings: const RouteSettings(name: routeName),
        transitionDuration: const Duration(seconds: 0),
        pageBuilder: (context, _, __) => BlocProvider<LoginCubit>(
            create: (_) =>
                LoginCubit(authRepository: context.read<AuthRepository>()),
            child: LoginScreen()));
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool? _passwordVisible;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.error) {
              showDialog(
                context: context,
                builder: (context) =>
                    ErrorDialog(content: state.failure.message),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              // resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Socially',
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).focusColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 30),
                              SizedBox(
                                height: 55,
                                child: TextFormField(
                                  controller: _email,
                                  keyboardType: TextInputType.emailAddress,
                                  onFieldSubmitted: (_) => node.unfocus(),
                                  decoration: textFormFieldDecoration.copyWith(
                                    hintText: 'Username or email',
                                    fillColor: Theme.of(context).hintColor,
                                  ),
                                  style: GoogleFonts.lato(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).focusColor,
                                  ),
                                  onChanged: (value) => context
                                      .read<LoginCubit>()
                                      .emailChanged(value),
                                  validator: (String? v) {
                                    if (v!.isValidEmail) {
                                      return null;
                                    } else {
                                      return 'Please enter a valid email';
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                height: 55,
                                child: TextFormField(
                                  controller: _password,
                                  obscureText: !_passwordVisible!,
                                  keyboardType: TextInputType.visiblePassword,
                                  onFieldSubmitted: (_) => node.unfocus(),
                                  decoration: textFormFieldDecoration.copyWith(
                                    hintText: 'Password',
                                    fillColor: Theme.of(context).hintColor,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible!
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Theme.of(context).focusColor,
                                      ),
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible!;
                                        });
                                      },
                                    ),
                                  ),
                                  style: GoogleFonts.lato(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).focusColor,
                                  ),
                                  onChanged: (value) => context
                                      .read<LoginCubit>()
                                      .passwordChanged(value),
                                  validator: (String? v) {
                                    if (v!.isValidPassword) {
                                      return null;
                                    } else {
                                      return 'Must be at least 8 characters';
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 35),
                              CustomButton(
                                title: 'Log In',
                                bordersideColor: Colors.blue,
                                textColor: Colors.white,
                                backgroundColor: Colors.blue,
                                onPress: () => _submitForm(context,
                                    state.status == LoginStatus.submitting),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, left: 20, right: 20),
                        child: Column(
                          children: [
                            Divider(color: Theme.of(context).dividerColor),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don\'t have an account?',
                                    style: GoogleFonts.roboto(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).focusColor,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () => Navigator.of(context)
                                        .pushNamed(SignupScreen.routeName),
                                    child: Text(
                                      'Sign Up.',
                                      style: GoogleFonts.roboto(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromRGBO(41, 170, 225, 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState!.validate() && !isSubmitting) {
      context.read<LoginCubit>().logInWithCredentials();
    }
  }
}
