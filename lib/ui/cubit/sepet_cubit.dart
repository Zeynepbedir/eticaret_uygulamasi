import 'package:eticaret_uygulamasi/data/entity/urun_sepet.dart';
import 'package:eticaret_uygulamasi/data/repo/urun_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetCubit extends Cubit<List<UrunSepet>> {
  SepetCubit() : super(<UrunSepet>[]);
  var urunDaoRepository = UrunDaoRepository();

  Future<void> sepetGetir(String kullaniciAdi) async {
    var list = await urunDaoRepository.sepetGetir(kullaniciAdi);
    emit(list);
  }

  Future<void> sil(int sepetId, String kullaniciAdi) async {
    await urunDaoRepository.sil(sepetId, kullaniciAdi);
    await sepetGetir(kullaniciAdi);
  }
}
