import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartlist/screens/authentication_screens/forget_password.dart';
import 'package:smartlist/widgets/palatte.dart';
import '../../user_provider.dart';
import '../../widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _staySignedIn = false;
  String? errorHandling;
  bool _isLoading = false;

  Future<void> _signInOnPressed(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      final password = _passwordController.text.trim();
      final email = _emailController.text.trim();

      if (email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Please enter a email',
            style: TextStyle(
              color: Colors.white, // Text color
            ),
          ),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.black, // Background color
        ));
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Email validation check
      final emailRegExp =
          RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
      if (!emailRegExp.hasMatch(email)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Please enter a valid email address',
            style: TextStyle(
              color: Colors.white, // Text color
            ),
          ),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.black, // Background color
        ));
        setState(() {
          _isLoading = false;
        });
        return;
      }

      if (password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Please enter a password',
            style: TextStyle(
              color: Colors.white, // Text color
            ),
          ),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.black, // Background color
        ));
        setState(() {
          _isLoading = false;
        });
        return;
      }

      if (password.length < 8) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Password is too short',
            style: TextStyle(
              color: Colors.white, // Text color
            ),
          ),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.black, // Background color
        ));
        setState(() {
          _isLoading = false;
        });
        return;
      }

      //final password = _passwordController.text.trim();

      try {
        final signInResult = await Amplify.Auth.signIn(
          username: email,
          password: password,
        );

        if (signInResult.isSignedIn) {
          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          userProvider.updateAccountEmail(email);
          _goToMainScreen(context);
        }
      } on AuthException catch (e) {
        debugPrint(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.message,
              style: const TextStyle(
                color: Colors.white, // Text color
              ),
            ),
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.black,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _goToMainScreen(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/main_route',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: SizedBox(
                        height: 200,
                        child: Center(
                          child: Image(
                            image: AssetImage('assets/images/Grocery_bag.png'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                      ),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextInput(
                                icon: Icons.email,
                                hint: 'Email',
                                inputType: TextInputType.emailAddress,
                                inputAction: TextInputAction.done,
                                controller: _emailController,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                                iconSize:
                                    MediaQuery.of(context).size.width * 0.08,
                              ),
                              TextInput(
                                icon: Icons.lock,
                                hint: 'Password',
                                inputType: TextInputType.text,
                                inputAction: TextInputAction.done,
                                controller: _passwordController,
                                obscure: _obscurePassword,
                                suffix: IconButton(
                                  color: Colors.green,
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    errorHandling = 'Please enter a password';
                                  }
                                  return null;
                                },
                                iconSize:
                                    MediaQuery.of(context).size.width * 0.08,
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ResetPasswordScreen()),
                              );
                            },
                            child: const Row(
                              children: [
                                SizedBox(width: 8),
                                Text(
                                  "Forget Password ?",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Remember Me Checkbox
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: _staySignedIn,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _staySignedIn = newValue ?? false;
                                    });
                                  },
                                  activeColor: Colors.green,
                                ),
                                const Text(
                                  'Remember Me',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Login Button
                          RoundedButton(
                            buttonText: 'Login',
                            buttonColor: Colors.green,
                            onPressed: () => _signInOnPressed(context),
                          ),

                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: [
                              Text(
                                'Don\'t have an account yet?',
                                style: kBodyText.copyWith(color: Colors.black),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/sign_up_route',
                                  );
                                },
                                child: const Text(
                                  'Create new account',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
