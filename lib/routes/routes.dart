import 'package:smartlist/screens/model_screens/home_screen.dart';

import 'package:smartlist/screens/authentication_screens/sign_in_screen.dart';
import 'package:smartlist/screens/authentication_screens/sign_up_screen.dart';

import '../screens/main_screen.dart';

//import '../screens/model_screens/home.dart';
import '../screens/welcome_screen.dart';

var routes = {
  '/sign_in_route': (context) => const SignInScreen(),
  '/sign_up_route': (context) => const SignUpScreen(),
  '/home_route': (context) => const HomeScreen(),
  '/main_route': (context) => const MainScreen(),
  '/WelcomeScreen': (context) => const WelcomeScreen(),
};
