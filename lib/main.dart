import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartlist/models/dynamodb.dart';
import 'package:smartlist/routes/routes.dart';
import 'widgets/themenotifier.dart';
import 'User_Provider.dart';
import 'package:smartlist/models/User.dart';
import 'models/ModelProvider.dart';
import 'amplifyconfiguration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureAmplify();

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

Future<void> _configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    await Amplify.addPlugin(auth);

    final dataStorePlugin =
        AmplifyDataStore(modelProvider: ModelProvider.instance);
    await Amplify.addPlugin(dataStorePlugin);

    final api = AmplifyAPI(modelProvider: ModelProvider.instance);
    await Amplify.addPlugin(api);

    await Amplify.configure(amplifyconfig);

    safePrint('Amplify Configured');
  } on Exception catch (e) {
    safePrint('An error occurred configuring Amplify: $e');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isSignedIn = false;
  String initialRoute = '/SplashScreen';

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _configureAmplify();
    await checkAuthSession();
    // Other initialization code...
  }

  Future<void> createUserExample() async {
    final newUser = User(
      username: 'Thulani Mhlanga',
      email: 'bruce@solvyng.io',
      phoneNumber: '',
      id: '',
    );
    await DynamoDBService.createUser(newUser);
  }

  Future<void> updateUserExample() async {
    final updatedUser = User(
      id: 'existing_user_id',
      username: 'updated_thulani_Mhlanga',
      email: 'updated_bruce@solvyng.io',
      phoneNumber: '',
    );
    await DynamoDBService.updateUser(updatedUser);
  }

  Future<void> deleteUserExample() async {
    const userIdToDelete = 'user_id_to_delete';
    await DynamoDBService.deleteUser(userIdToDelete);
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
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          theme: themeNotifier.currentTheme,
          home: Builder(
            builder: (context) => Container(
              color: Colors.white,
              child: Scaffold(
                backgroundColor: Colors.white,
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
          ),
        );
      },
    );
  }
}

void safePrint(String message) {
  assert(() {
    print(message);
    return true;
  }());
}
