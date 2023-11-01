import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:smartlist/screens/authentication_screens/sign_up_confirmation_screen.dart';
import '../../widgets/palatte.dart';
import '../../widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String? errorHandling;

  // Initialize the text fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _obscurePassword = true;
  // Show loading icon
  bool _isLoading = false;

  // Validation error colors
  Color _usernameBorderColor = Colors.transparent;
  Color _emailBorderColor = Colors.transparent;
  Color _phoneNumberBorderColor = Colors.transparent;
  Color _passwordBorderColor = Colors.transparent;

  // Sign up auth method
  Future<void> _signUpOnPressed(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true; // Show loading icon
      });
      try {
        final password = _passwordController.text.trim();
        if (password.length < 8) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'Password must be at least 8 characters long',
              style: TextStyle(
                color: Colors.white, // Text color
              ),
            ),

            duration: Duration(seconds: 5),
            backgroundColor: Colors.red, // Background color
          ));
          setState(() {
            _isLoading = false;
          });
          return;
        }
        final username = _usernameController.text.trim();
        if (username.length < 4) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'username  must be at least 4 characters long',
              style: TextStyle(
                color: Colors.white, // Text color
              ),
            ),
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red, // Background color
          ));
          setState(() {
            _isLoading = false;
          });
          return;
        }
        final signUpResult = await Amplify.Auth.signUp(
          username: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          options: CognitoSignUpOptions(
            userAttributes: {
              CognitoUserAttributeKey.email: _emailController.text.trim(),
              CognitoUserAttributeKey.preferredUsername:
                  _usernameController.text.trim(),
              CognitoUserAttributeKey.phoneNumber:
                  _phoneNumberController.text.trim(),
            },
          ),
        );
        if (signUpResult.isSignUpComplete) {
          _goToSignUpConfirmationScreen(context, _emailController.text.trim());
          debugPrint("Sign Up done, forwarded to confirm");
        }
      } on AuthException catch (e) {
        debugPrint(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            errorHandling!,
            style: const TextStyle(
              color: Colors.white, // Text color
            ),
          ),
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red, // Background color
        ));
      } finally {
        setState(() {
          _isLoading = false; // Hide loading icon
        });
      }
    }
  }

  void _goToSignUpConfirmationScreen(BuildContext context, String email) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SignUpConfirmationScreen(
          email: email,
        ),
      ),
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
                    // ignore: sized_box_for_whitespace
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: SizedBox(
                        height: 200,
                        child: Column(
                          children: [
                            Center(
                              child: Image(
                                image:
                                    AssetImage('assets/images/Grocery_bag.png'),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // Add the heading here
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                color:
                                    Colors.green, // Set the text color to green
                                fontSize: 24, // Set the font size
                                fontWeight:
                                    FontWeight.bold, // Set the font weight
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 100,
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
                              // username Input
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Username',
                                    labelStyle: TextStyle(
                                      color: _usernameBorderColor ==
                                              Colors.green
                                          ? Colors.grey
                                          : Colors
                                              .grey, // Set the label text color based on focus
                                    ),
                                    prefixIcon: Container(
                                      padding: const EdgeInsets.all(
                                          12.0), // Adjust the padding as needed
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors
                                            .green, // Set the color based on your logic
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .green, // Set the focused border color to green
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  keyboardType: TextInputType.text,
                                  controller: _usernameController,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      _usernameBorderColor = Colors.red;
                                      errorHandling = 'Please enter a username';
                                      return 'Please enter a username';
                                    }
                                    _usernameBorderColor = Colors.transparent;
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                              ),

                              // emailInput
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: TextStyle(
                                      color: _usernameBorderColor ==
                                              Colors.green
                                          ? Colors.grey
                                          : Colors
                                              .grey, // Set the label text color based on focus
                                    ),
                                    prefixIcon: Container(
                                      padding: const EdgeInsets.all(
                                          12.0), // Adjust the padding as needed
                                      child: const Icon(
                                        Icons.email,
                                        color: Colors
                                            .green, // Set the color based on your logic
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .green, // Set the focused border color to green
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: _emailBorderColor,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailController,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      _emailBorderColor = Colors.red;
                                      errorHandling =
                                          'Please enter a valid email';
                                      return 'Please enter an email';
                                    }
                                    // final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                    // if (!emailRegExp.hasMatch(value)) {
                                    //   _emailBorderColor = Colors.red;
                                    //   errorHandling = 'Invalid email format';
                                    //   return 'Invalid email format';
                                    // }
                                    _emailBorderColor = Colors.transparent;
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                              ),

                              // phoneNumberInput
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    labelStyle: TextStyle(
                                      color: _usernameBorderColor ==
                                              Colors.green
                                          ? Colors.grey
                                          : Colors
                                              .grey, // Set the label text color based on focus
                                    ),
                                    prefixIcon: Container(
                                      padding: const EdgeInsets.all(
                                          12.0), // Adjust the padding as needed
                                      child: const Icon(
                                        Icons.phone,
                                        color: Colors
                                            .green, // Set the color based on your logic
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: _phoneNumberBorderColor,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .green, // Set the focused border color to green
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  keyboardType: TextInputType.phone,
                                  controller: _phoneNumberController,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      _phoneNumberBorderColor = Colors.red;
                                      errorHandling =
                                          'Please enter a phone number';
                                      return 'Please enter a phone number';
                                    } else if (!value.startsWith("+27")) {
                                      _phoneNumberBorderColor = Colors.red;
                                      //errorHandling = 'Phone number must start with +27';
                                      return 'Phone number must start with +27';
                                    }
                                    _phoneNumberBorderColor =
                                        Colors.transparent;
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                              ),

                              // passwordInput
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                      color: _usernameBorderColor ==
                                              Colors.green
                                          ? Colors.grey
                                          : Colors
                                              .grey, // Set the label text color based on focus
                                    ),
                                    prefixIcon: Container(
                                      padding: const EdgeInsets.all(
                                          12.0), // Adjust the padding as needed
                                      child: const Icon(
                                        Icons.lock,
                                        color: Colors
                                            .green, // Set the color based on your logic
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.green,
                                        width:
                                            2.0, // Set the focused border color to green
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    //borderRadius: BorderRadius.circular(16),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: _passwordBorderColor,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    suffixIcon: IconButton(
                                      color: Colors.white,
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
                                  ),
                                  keyboardType: TextInputType.text,
                                  controller: _passwordController,
                                  obscureText: _obscurePassword,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      _passwordBorderColor = Colors.red;
                                      errorHandling = 'Please enter a password';
                                      return 'Please enter a password';
                                    }

                                    // Check if the password contains at least one uppercase letter, one number, and one special character
                                    final passwordRegExp = RegExp(
                                        r'^(?=.*[A-Z])(?=.*\d)(?=.*[\W_])');
                                    if (!passwordRegExp.hasMatch(value)) {
                                      _passwordBorderColor = Colors.red;
                                      errorHandling =
                                          'least one uppercase letter,one number,& 1special character';
                                      return 'least one uppercase letter, number,& special character';
                                    }

                                    _passwordBorderColor = Colors.transparent;
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              RoundedButton(
                                buttonText: 'Create Account',
                                onPressed: () => _signUpOnPressed(context),
                                buttonColor: Colors.blue,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Visibility(
                                visible: _isLoading,
                                replacement: const SizedBox(
                                  height: 35,
                                ),
                                child: const CircularProgressIndicator(
                                  color: Colors.green,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Already Have Account?',
                                    style:
                                        kBodyText.copyWith(color: Colors.black),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/sign_in_route',
                                        ModalRoute.withName('/sign_in_route'),
                                      );
                                    },
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
