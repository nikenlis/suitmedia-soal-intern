import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suitmedia/common/app_route.dart';
import 'package:suitmedia/injection.dart';
import 'package:suitmedia/third_page/presentation/bloc/all_user_bloc.dart';

import 'core/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<AllUserBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(),
          scaffoldBackgroundColor: whiteColor,
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: greenColor,
            onPrimary: whiteColor,
            secondary: Colors.lightBlueAccent,
            onSecondary: whiteColor,
            error: redColor,
            onError: whiteColor,
            surface: whiteColor,
            onSurface: blackColor
          ),
          appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: greenColor,
          ),
          titleTextStyle: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
        ),
        initialRoute: AppRoute.first,
        onGenerateRoute: AppRoute.onGenerateRoute,
      ),
    );
  }
}