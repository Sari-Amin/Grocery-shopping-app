
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'features/grocery/presentation/bloc/cart/cart_bloc.dart';
import 'features/grocery/presentation/bloc/grocery_bloc/grocery_bloc.dart';
import 'features/grocery/presentation/pages/home_page.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
   
      const MyApp(),
    
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        
        BlocProvider<GroceryBloc>(
          create: (context) => di.sl<GroceryBloc>(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => di.sl<CartBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Grocery Shopping App',
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          // '/detail': (context) => const DetailPage(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 255, 255)),
          useMaterial3: true,
        ),
        // home: const SplashScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
