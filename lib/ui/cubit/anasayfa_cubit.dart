import 'package:eticaret_uygulamasi/data/entity/urunler.dart';
import 'package:eticaret_uygulamasi/data/repo/urun_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnasayfaCubit extends Cubit<List<Urunler>> {
  AnasayfaCubit() : super(<Urunler>[]);
  var urunDaoRepository = UrunDaoRepository();

  Future<void> urunYukle() async {
    var list = await urunDaoRepository.urunYukle();
    emit(list);
  }
}
