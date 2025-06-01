import 'package:eticaret_uygulamasi/data/entity/urunler.dart';
import 'package:eticaret_uygulamasi/data/repo/urun_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriCubit extends Cubit<List<Urunler>> {
  FavoriCubit() : super([]);
  var urunDaoRepository = UrunDaoRepository();

  Future<void> favoriEkle(Urunler urun) async {
    await urunDaoRepository.favoriEkle(urun);
    await favoriGetir();
  }

  Future<void> favoriSil(int id) async {
    await urunDaoRepository.favoriSil(id);
    await favoriGetir();
  }

  Future<void> favoriGetir() async {
    var list = await urunDaoRepository.favoriGetir();
    emit(list);
  }
}
