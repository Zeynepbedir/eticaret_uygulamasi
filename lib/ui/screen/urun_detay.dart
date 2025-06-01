import 'package:eticaret_uygulamasi/data/entity/urunler.dart';
import 'package:eticaret_uygulamasi/ui/cubit/favori_cubit.dart';
import 'package:eticaret_uygulamasi/ui/cubit/urun_detay_cubit.dart';
import 'package:eticaret_uygulamasi/ui/tools/renkler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class UrunDetay extends StatefulWidget {
  Urunler urunler;
  UrunDetay({required this.urunler});

  @override
  State<UrunDetay> createState() => _UrunDetayState();
}

class _UrunDetayState extends State<UrunDetay> {
  bool animasyonGoster = false;
  int siparisAdeti = 1;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Ürün Detayı",
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 24,
              fontStyle: FontStyle.italic,
              color: Color(0xFFFFFFFF),
            ),
          ),
          backgroundColor: appBarRengi,
          centerTitle: true,
        ),
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      "http://kasimadalan.pe.hu/urunler/resimler/${widget.urunler.resim}",
                      height: 250,
                      width: double.infinity,
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.7),
                        child: IconButton(
                          icon: Icon(Icons.favorite_border, color: Colors.red),
                          onPressed: () {
                            context
                                .read<FavoriCubit>()
                                .favoriEkle(widget.urunler);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Favorilere eklendi"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  widget.urunler.ad,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(widget.urunler.kategori),
                SizedBox(height: 8),
                Text(widget.urunler.marka),
                SizedBox(height: 8),
                Text(
                  "₺${widget.urunler.fiyat.toString()}",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: fiyatRengi),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (siparisAdeti > 1) {
                          setState(() => siparisAdeti--);
                        }
                      },
                      icon: const Icon(Icons.remove_circle),
                      iconSize: 32,
                    ),
                    Text(
                      siparisAdeti.toString(),
                      style: const TextStyle(fontSize: 25),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() => siparisAdeti++);
                      },
                      icon: const Icon(Icons.add_circle),
                      iconSize: 32,
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "₺${(widget.urunler.fiyat * siparisAdeti)}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: fiyatRengi,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<UrunDetayCubit>().sepetEkle(
                            widget.urunler.ad,
                            widget.urunler.resim,
                            widget.urunler.kategori,
                            widget.urunler.fiyat,
                            widget.urunler.marka,
                            siparisAdeti,
                            "zeynep_bedir");
                        setState(() {
                          animasyonGoster = true;
                        });

                        // 2 saniye sonra animasyonu kapat
                        Future.delayed(const Duration(seconds: 2), () {
                          setState(() {
                            animasyonGoster = false;
                          });
                        });
                      },
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text(
                        "Sepete Ekle",
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: butonRengi,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        minimumSize: Size(190, 50),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (animasyonGoster)
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: Lottie.asset(
                    'animasyon/sepet_eklendi.json',
                    width: 200,
                    height: 200,
                    repeat: false,
                  ),
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
