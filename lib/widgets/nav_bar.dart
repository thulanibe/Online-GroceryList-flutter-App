import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartlist/widgets/palatte.dart';
import 'theme.dart';
import 'themenotifier.dart';
import '../user_provider.dart';
import 'budgets.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  void initState() {
    super.initState();
    loadDarkModePreference();
  }

  Future<void> loadDarkModePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('darkMode') ?? false;
    Provider.of<ThemeNotifier>(context, listen: false)
        .setTheme(isDarkMode ? darkTheme : lightTheme);
  }

  Future<void> saveDarkModePreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
  }

  Future<void> signOutCurrentUser(context) async {
    try {
      final result = await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      debugPrint(e.toString());
    }
    Navigator.pushReplacementNamed(context, '/sign_in_route');
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final accountEmail = userProvider.accountEmail;
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final theme = Theme.of(context);

    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(
              accountEmail,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: primaryLightColor,
              child: Image.asset('assets/images/user.png'),
            ),
            accountName: null,
            decoration: BoxDecoration(color: Color.fromARGB(255, 114, 147, 67)),
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              color: primaryColor,
            ),
            title: const Text('About Us'),
            onTap: () {
              Navigator.pushNamed(context, '/about_us_route');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: primaryColor,
            ),
            title: const Text('Sign Out'),
            onTap: () {
              signOutCurrentUser(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.dark_mode,
              color: primaryColor,
            ),
            title: Text('Dark Mode'),
            trailing: Theme(
              data: Theme.of(context).copyWith(
                switchTheme: SwitchThemeData(
                  thumbColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors
                            .green; // Set the color to green when selected
                      }
                      return Colors
                          .grey; // Set the color to grey when unselected
                    },
                  ),
                  trackColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.green.withOpacity(
                            0.5); // Set the track color when selected
                      }
                      return Colors.grey.withOpacity(
                          0.5); // Set the track color when unselected
                    },
                  ),
                ),
              ),
              child: Switch(
                value: themeNotifier.getTheme() == darkTheme,
                onChanged: (value) {
                  print("Dark mode toggle value: $value");
                  themeNotifier.setTheme(value ? darkTheme : lightTheme);
                  saveDarkModePreference(value);
                },
              ),
            ),
          ),
          // Add the "Budgets" page ListTile below
          ListTile(
            leading: const Icon(
              Icons.money,
              color: primaryColor,
            ),
            title: const Text('Budgets'),
            onTap: () {
              // Navigate to the "Budgets" page
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const BudgetPage()));
            },
          ),
        ],
      ),
    );
  }
}
