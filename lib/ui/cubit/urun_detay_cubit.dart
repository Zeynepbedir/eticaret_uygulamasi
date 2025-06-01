import 'package:eticaret_uygulamasi/data/repo/urun_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UrunDetayCubit extends Cubit<void> {
  UrunDetayCubit() : super(0);
  var urunDaoRepository = UrunDaoRepository();

  Future<void> sepetEkle(String ad, String resim, String kategori, int fiyat,
      String marka, int siparisAdeti, String kullaniciAdi) async {
    await urunDaoRepository.sepetEkle(
        ad, resim, kategori, fiyat, marka, siparisAdeti, kullaniciAdi);
  }
}
