import 'package:eticaret_uygulamasi/data/entity/urunler.dart';
import 'package:eticaret_uygulamasi/ui/cubit/favori_cubit.dart';
import 'package:eticaret_uygulamasi/ui/screen/urun_detay.dart';
import 'package:eticaret_uygulamasi/ui/tools/renkler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Favori extends StatefulWidget {
  const Favori({super.key});

  @override
  State<Favori> createState() => _FavoriState();
}

class _FavoriState extends State<Favori> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriCubit>().favoriGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favorilerim",
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontStyle: FontStyle.italic,
            color: Color(0xFFFFFFFF),
          ),
        ),
        centerTitle: true,
        backgroundColor: appBarRengi,
      ),
      body: BlocBuilder<FavoriCubit, List<Urunler>>(
        builder: (context, favoriListesi) {
          if (favoriListesi.isEmpty) {
            return const Center(child: Text("Favori ürün bulunamadı"));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.7,
            ),
            itemCount: favoriListesi.length,
            itemBuilder: (context, index) {
              var urun = favoriListesi[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UrunDetay(urunler: urun),
                    ),
                  ).then((_) {
                    context.read<FavoriCubit>().favoriGetir();
                  });
                },
                child: Card(
                  color: Colors.white70,
                  child: Column(
                    children: [
                      Image.network(
                        "http://kasimadalan.pe.hu/urunler/resimler/${urun.resim}",
                        fit: BoxFit.cover,
                        height: 140,
                        width: double.infinity,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        urun.ad,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5F7589),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "₺ ${urun.fiyat.toString()}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: fiyatRengi,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<FavoriCubit>().favoriSil(urun.id);
                        },
                        child: Text("Favoriden Sil"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: butonRengi),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
