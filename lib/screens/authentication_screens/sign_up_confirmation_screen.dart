import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:smartlist/widgets/rounded_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SignUpConfirmationScreen extends StatefulWidget {
  const SignUpConfirmationScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String email;

  @override
  _SignUpConfirmationScreenState createState() =>
      _SignUpConfirmationScreenState();
}

class _SignUpConfirmationScreenState extends State<SignUpConfirmationScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _confirmationCodeController =
      TextEditingController();
  bool _isLoading = false;

  Future<void> _confirmOnPressed(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      final confirmationCode = _confirmationCodeController.text;
      print("Confirmation code: $confirmationCode");
      try {
        final signUpResult = await Amplify.Auth.confirmSignUp(
          username: widget.email,
          confirmationCode: confirmationCode,
        );
        print("SignUpResult: $signUpResult");
        if (signUpResult.isSignUpComplete) {
          debugPrint("successful log in");
          goToMainScreen(context);
        }
      } on AuthException catch (e) {
        debugPrint(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message),
          duration: const Duration(seconds: 5),
        ));
      } finally {
        setState(() {
          _isLoading = false; // Hide loading icon
        });
      }
    }
  }

  Future<void> _resendCodeOnPressed() async {
    try {
      await Amplify.Auth.resendSignUpCode(username: widget.email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Confirmation code resent to ${widget.email}'),
        duration: const Duration(seconds: 5),
      ));
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
        duration: const Duration(seconds: 5),
      ));
    }
  }

  void goToMainScreen(BuildContext context) {
    Navigator.pushNamed(context, '/sign_in_route');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Image(
                      image: AssetImage('assets/images/Grocery_bag.png'),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    right: 30.0,
                  ),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'An email confirmation code is sent to ${widget.email} enter the code ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: PinCodeTextField(
                              appContext: context,
                              length: 6,
                              onChanged: (value) {
                                _confirmationCodeController.text = value;
                              },
                              textStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.number,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 50,
                                fieldWidth: 40,
                                activeFillColor: Colors.green,
                                inactiveFillColor: Colors.white,
                                borderWidth: 10,
                                activeColor: Colors.green,
                                selectedColor: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              TextButton(
                                onPressed: () => _resendCodeOnPressed(),
                                child: const Text(
                                  'Resend Code',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          RoundedButton(
                            buttonText: 'Confirm',
                            onPressed: () => _confirmOnPressed(context),
                            buttonColor: Colors.green,
                          ),
                          const SizedBox(height: 40),
                          Visibility(
                            visible: _isLoading,
                            replacement: const SizedBox(
                              height: 35,
                            ),
                            child: const CircularProgressIndicator(
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
