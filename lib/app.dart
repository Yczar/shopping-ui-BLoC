import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping_ui/presentation/blocs/cart_bloc/cart_bloc.dart';
import 'package:shopping_ui/presentation/blocs/shoe_bloc/shoe_bloc.dart';
import 'package:shopping_ui/presentation/providers/cart_provider.dart';
import 'package:shopping_ui/presentation/screens/home_screen.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ShoeBloc(),
          ),
          BlocProvider(
            create: (_) => CartBloc(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shoe UI',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.workSansTextTheme(),
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
