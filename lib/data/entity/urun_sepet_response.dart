import 'package:eticaret_uygulamasi/data/entity/urun_sepet.dart';

class UrunSepetResponse {
  int success;
  List<UrunSepet> urunSepet;

  UrunSepetResponse({required this.success, required this.urunSepet});

  factory UrunSepetResponse.fromJson(Map<String, dynamic> json) {
    var success = json["success"] as int;
    var jsonArray = json["urunler_sepeti"] as List;

    var urunSepet =
        jsonArray.map((jsonObject) => UrunSepet.fromJson(jsonObject)).toList();
    return UrunSepetResponse(success: success, urunSepet: urunSepet);
  }
}
