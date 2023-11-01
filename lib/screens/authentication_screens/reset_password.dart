import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smartlist/screens/authentication_screens/sign_in_screen.dart';
import 'package:smartlist/widgets/rounded_button.dart';

class PasswordResetConfirmationScreen extends StatefulWidget {
  final String email;

  const PasswordResetConfirmationScreen({super.key, required this.email});

  @override
  _PasswordResetConfirmationScreenState createState() =>
      _PasswordResetConfirmationScreenState();
}

class _PasswordResetConfirmationScreenState
    extends State<PasswordResetConfirmationScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _confirmationCodeController =
      TextEditingController();

  Future<void> _confirmResetPassword(BuildContext context) async {
    final email = widget.email;
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final confirmationCode = _confirmationCodeController.text.trim();

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
          duration: Duration(seconds: 5),
        ),
      );
      return;
    }

    try {
      await Amplify.Auth.confirmResetPassword(
        username: email,
        newPassword: newPassword,
        confirmationCode: confirmationCode,
      );
      // Password reset is successful, you can navigate the user to the login screen.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    } on AuthException catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  Future<void> _resendCodeOnPressed() async {
    try {
      await Amplify.Auth.resetPassword(username: widget.email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Reset confirmation code resent to ${widget.email}'),
          duration: const Duration(seconds: 5),
        ),
      );
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password Confirmation'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: const Center(
                    child: Image(
                      image: AssetImage('assets/images/lock.png'),
                      height: 150,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Reset confirmation code  was sent to ${widget.email}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: _newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(
                          12.0), // Adjust the padding as needed
                      child: const Icon(
                        Icons.lock,
                        color:
                            Colors.green, // Set the color based on your logic
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 2.0, // Set the focused border color to green
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a new password';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm New Password',
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(
                          12.0), // Adjust the padding as needed
                      child: const Icon(
                        Icons.lock,
                        color:
                            Colors.green, // Set the color based on your logic
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 2.0, // Set the focused border color to green
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm the new password';
                    }
                    if (value != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ),
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
              SizedBox(
                width: 300,
                child: RoundedButton(
                  buttonText: 'Confirm Password',
                  buttonColor: Colors.green,
                  onPressed: () => _confirmResetPassword(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
