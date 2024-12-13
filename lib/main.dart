import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'auth/auth_local_datasource.dart';
import 'ui/bloc/bloc_news/news_bloc.dart';
import 'ui/home_page.dart';
import 'ui/login_page.dart';
import 'ui/provider/news_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewsProvider()), 
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NewsBloc(), 
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: FutureBuilder<String?>(
            future: AuthLocalDatasource().getToken(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator()); 
              }
              if (snapshot.hasData && snapshot.data != null) {
                return const HomePage(); 
              } else {
                return const LoginPage(); 
              }
            },
          ),
        ),
      ),
    );
  }
}