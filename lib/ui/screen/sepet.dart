import 'package:eticaret_uygulamasi/data/entity/urun_sepet.dart';
import 'package:eticaret_uygulamasi/ui/cubit/sepet_cubit.dart';
import 'package:eticaret_uygulamasi/ui/tools/renkler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Sepet extends StatefulWidget {
  const Sepet({super.key});

  @override
  State<Sepet> createState() => _SepetState();
}

class _SepetState extends State<Sepet> {
  @override
  void initState() {
    super.initState();
    context.read<SepetCubit>().sepetGetir("zeynep_bedir");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sepetim",
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
      body: BlocBuilder<SepetCubit, List<UrunSepet>>(
        builder: (context, urunListesi) {
          if (urunListesi.isNotEmpty) {
            //fold değişiklikleri hemen yansıtmak için kullanılır.
            double toplamTutar = urunListesi.fold(
              0,
              (toplam, urun) => toplam + (urun.fiyat * urun.siparisAdeti),
            );
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: urunListesi.length,
                    itemBuilder: (context, index) {
                      var urun = urunListesi[index];
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                "http://kasimadalan.pe.hu/urunler/resimler/${urun.resim}",
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Ürün Adı: ${urun.ad}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    Text("Fiyat: ${urun.fiyat} ₺"),
                                    Text("Marka: ${urun.marka}"),
                                    Text("Adet: ${urun.siparisAdeti}"),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.redAccent,
                                    onPressed: () async {
                                      bool? onay = await showDialog<bool>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                              "Ürünü silmek istediğinize emin misiniz?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, false),
                                              child: Text("İptal"),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, true),
                                              child: Text("Sil"),
                                            ),
                                          ],
                                        ),
                                      );
                                      if (onay == true) {
                                        context
                                            .read<SepetCubit>()
                                            .sil(urun.sepetId, "zeynep_bedir");
                                      }
                                    },
                                  ),
                                  Text(
                                    "₺ ${urun.fiyat * urun.siparisAdeti} ",
                                    style: TextStyle(
                                        color: fiyatRengi, fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.grey.shade200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Toplam Tutar:",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("₺ $toplamTutar",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: fiyatRengi)),
                        ],
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Sepeti Onayla"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: butonRengi),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(
                child: Column(
              children: [
                Image.asset(
                  "images/bos_sepet.png",
                  height: 250,
                  width: 200,
                ),
                SizedBox(height: 10),
                Text(
                  "Sepette ürün bulunamadı.",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ));
          }
        },
      ),
    );
  }
}
