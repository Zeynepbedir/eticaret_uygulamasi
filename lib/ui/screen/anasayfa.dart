import 'package:eticaret_uygulamasi/data/entity/urunler.dart';
import 'package:eticaret_uygulamasi/ui/cubit/anasayfa_cubit.dart';
import 'package:eticaret_uygulamasi/ui/cubit/sepet_cubit.dart';
import 'package:eticaret_uygulamasi/ui/screen/sepet.dart';
import 'package:eticaret_uygulamasi/ui/screen/urun_detay.dart';
import 'package:eticaret_uygulamasi/ui/tools/renkler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().urunYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Alışveriş Kutusu",
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontStyle: FontStyle.italic,
            color: Color(0xFFFFFFFF),
          ),
        ),
        centerTitle: true,
        backgroundColor:
            appBarRengi, // Varsayılan renk veya istediğin açık renk
        /*actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Sepet(),
                ),
              ).then((_) {
                context.read<SepetCubit>().sepetGetir("zeynep_bedir");
              });
            },
          ),
        ],*/
      ),
      body: Column(
        children: [
          //cubitten gelen veri burada yakalanır
          BlocBuilder<AnasayfaCubit, List<Urunler>>(
            builder: (context, urunlerList) {
              if (urunlerList.isNotEmpty) {
                return Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.7, // Kart yüksekliği
                    ),
                    itemCount: urunlerList.length,
                    itemBuilder: (context, index) {
                      var urun = urunlerList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UrunDetay(
                                        urunler: urun,
                                      ))).then((_) {
                            context.read<AnasayfaCubit>().urunYukle();
                          });
                        },
                        child: Card(
                          color: Colors.white70,
                          child: Column(
                            children: [
                              Image.network(
                                  "http://kasimadalan.pe.hu/urunler/resimler/${urun.resim}"),
                              Text(
                                urun.ad,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF5F7589),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "₺ ${urun.fiyat.toString()}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: fiyatRengi, // vurgulu fiyat
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(child: Text("Ürün bulunamadı"));
              }
            },
          )
        ],
      ),
    );
  }
}
