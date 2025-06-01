import 'package:eticaret_uygulamasi/data/entity/urunler.dart';

class UrunlerResponse {
  int success;
  List<Urunler> urunler;

  UrunlerResponse({required this.success, required this.urunler});

  factory UrunlerResponse.fromJson(Map<String, dynamic> json) {
    var success = json["success"] as int;
    var jsonArray = json["urunler"] as List;

    var urunler =
        jsonArray.map((jsonObject) => Urunler.fromJson(jsonObject)).toList();
    return UrunlerResponse(success: success, urunler: urunler);
  }
}
