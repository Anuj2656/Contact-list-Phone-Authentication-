import 'package:contacts2/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:contacts2/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:contacts2/screens/contact2.dart';
import 'package:contacts2/screens/register_screen.dart';
import 'package:contacts2/widgets/custom_button.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const WelcomeScreen(),
        title: "Contacts",
      ),
    );
  }
}
