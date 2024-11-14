import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx_project/controller/provider/auth_provider.dart';
import 'package:totalx_project/controller/provider/auth_state_provider.dart';
import 'package:totalx_project/controller/provider/user_provider.dart';
import 'package:totalx_project/controller/provider/user_search_provider.dart';
import 'package:totalx_project/controller/provider/user_sort_provider.dart';
import 'package:totalx_project/firebase_options.dart';
import 'package:totalx_project/view/pages/add_user_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AuthStateProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => UserSortProvider()),
        ChangeNotifierProvider(create: (_) => UserSearchProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const AddUserPage()),
    );
  }
}
