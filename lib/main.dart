import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:smartlist/routes/routes.dart';
import 'package:smartlist/user_provider.dart';
import 'widgets/themenotifier.dart';
import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isSignedIn = false;
  String initialRoute = '/WelcomeScreen';

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      // Initialize Cognito
      final auth = AmplifyAuthCognito();
      // Add Cognito plugin to amplify
      await Amplify.addPlugin(auth);

      // Initialize GraphQL API model provider
      final api = AmplifyAPI(modelProvider: ModelProvider.instance);
      // Add GraphQL API model provider plugin to amplify
      await Amplify.addPlugin(api);

      // Call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);

      safePrint('Amplify Configured');
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    } finally {
      checkAuthSession();
    }
  }

  Future<void> checkAuthSession() async {
    try {
      final result = await Amplify.Auth.fetchAuthSession();

      setState(() {
        isSignedIn = result.isSignedIn;
        initialRoute = isSignedIn ? '/main_route' : '/WelcomeScreen';
        debugPrint('Is signed in: $isSignedIn');
      });
    } catch (e) {
      debugPrint('Error checking auth session: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      theme: Provider.of<ThemeNotifier>(context).currentTheme, // Set the theme
      routes: routes,
      home: Container(
        color: Colors.white, // Set the background color here
        child: Scaffold(
          backgroundColor: Colors.white, // Make the Scaffold transparent
          body: Navigator(
            initialRoute: initialRoute,
            onGenerateRoute: (settings) {
              if (routes.containsKey(settings.name)) {
                return MaterialPageRoute(
                  builder: (context) => routes[settings.name]!(context),
                );
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
