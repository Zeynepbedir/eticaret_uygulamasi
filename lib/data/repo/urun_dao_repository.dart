import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:eticaret_uygulamasi/data/entity/urun_sepet.dart';
import 'package:eticaret_uygulamasi/data/entity/urun_sepet_response.dart';
import 'package:eticaret_uygulamasi/data/entity/urunler.dart';
import 'package:eticaret_uygulamasi/data/entity/urunler_response.dart';
import 'package:eticaret_uygulamasi/data/sqlite/database_helper.dart';

class UrunDaoRepository {
  //gelen bilgiyi json formatına çevirme
  List<Urunler> parseUrunler(String response) {
    return UrunlerResponse.fromJson(json.decode(response)).urunler;
  }

  //url den gelen ham veriyi string e çevirip yukarıdaki parse metoduna gönderir.
  Future<List<Urunler>> urunYukle() async {
    var url = "http://kasimadalan.pe.hu/urunler/tumUrunleriGetir.php";
    var response = await Dio().get(url);

    return parseUrunler(response.data.toString());
  }

  Future<void> sepetEkle(String ad, String resim, String kategori, int fiyat,
      String marka, int siparisAdeti, String kullaniciAdi) async {
    var url = "http://kasimadalan.pe.hu/urunler/sepeteUrunEkle.php";
    var data = {
      "ad": ad,
      "resim": resim,
      "kategori": kategori,
      "fiyat": fiyat,
      "marka": marka,
      "siparisAdeti": siparisAdeti,
      "kullaniciAdi": kullaniciAdi
    };
    var response = await Dio().post(url, data: FormData.fromMap(data));
    print("Sepete eklendi: ${response.data}");
  }

  List<UrunSepet> parseUrunSepet(String response) {
    //return UrunSepetResponse.fromJson(json.decode(response)).urunSepet;

    if (response.trim().isEmpty) {
      //trim başta ve sonda bulunan boşlukları silen method
      print("Boş yanıt geldi.");
      return [];
    }
    try {
      final parsedJson = json.decode(response);
      return UrunSepetResponse.fromJson(parsedJson).urunSepet;
    } catch (e) {
      print("JSON parse hatası: $e");
      return [];
    }
  }

  Future<List<UrunSepet>> sepetGetir(String kullaniciAdi) async {
    var url = "http://kasimadalan.pe.hu/urunler/sepettekiUrunleriGetir.php";
    var data = {"kullaniciAdi": kullaniciAdi};
    var response = await Dio().post(url, data: FormData.fromMap(data));
    print("API Response Data: ${response.data}");
    return parseUrunSepet(response.data.toString());
  }

  Future<void> sil(int sepetId, String kullaniciAdi) async {
    var url = "http://kasimadalan.pe.hu/urunler/sepettenUrunSil.php";
    var data = {"sepetId": sepetId, "kullaniciAdi": kullaniciAdi};
    var response = await Dio().post(url, data: FormData.fromMap(data));
    print("Sil : ${response.data.toString()}");
  }

  Future<List<Urunler>> favoriGetir() async {
    var db = await DatabaseHelper.veritabaniErisim();

    List<Map<String, dynamic>> list =
        await db.rawQuery("SELECT * FROM favoriler");

    return List.generate(list.length, (index) {
      var row = list[index];
      var id = row["id"];
      var ad = row["ad"];
      var resim = row["resim"];
      var kategori = row["kategori"];
      var fiyat = row["fiyat"];
      var marka = row["marka"];

      return Urunler(
        id: id,
        ad: ad,
        resim: resim,
        kategori: kategori,
        fiyat: fiyat,
        marka: marka,
      );
    });
  }

  Future<void> favoriEkle(Urunler urun) async {
    var db = await DatabaseHelper.veritabaniErisim();

    var yeniFavori = <String, dynamic>{
      "ad": urun.ad,
      "resim": urun.resim,
      "kategori": urun.kategori,
      "fiyat": urun.fiyat,
      "marka": urun.marka,
    };

    await db.insert("favoriler", yeniFavori);
  }

  Future<void> favoriSil(int id) async {
    var db = await DatabaseHelper.veritabaniErisim();
    await db.delete("favoriler", where: "id=?", whereArgs: [id]);
  }
}
