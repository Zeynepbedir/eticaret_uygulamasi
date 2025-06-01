import 'package:eticaret_uygulamasi/ui/cubit/anasayfa_cubit.dart';
import 'package:eticaret_uygulamasi/ui/cubit/favori_cubit.dart';
import 'package:eticaret_uygulamasi/ui/cubit/sepet_cubit.dart';
import 'package:eticaret_uygulamasi/ui/cubit/urun_detay_cubit.dart';
import 'package:eticaret_uygulamasi/ui/screen/alt_menu.dart';
import 'package:eticaret_uygulamasi/ui/screen/anasayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnasayfaCubit()),
        BlocProvider(create: (context) => UrunDetayCubit()),
        BlocProvider(create: (context) => SepetCubit()),
        BlocProvider(create: (context) => FavoriCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AltMenu(),
      ),
    );
  }
}
