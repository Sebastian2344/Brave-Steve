import 'package:brave_steve/core/modules/data_source/box.dart';
import 'package:brave_steve/modules/counter_enemy_and_bioms/repo/counter_enemy_repo.dart';
import 'package:brave_steve/modules/eq/repo/eq_repo.dart';
import 'package:brave_steve/core/modules/items/items.dart';
import 'package:brave_steve/modules/game/repo/repository.dart';
import 'package:brave_steve/modules/merge_items/repo/merge_repo.dart';
import 'package:brave_steve/modules/money/money_data/money_data.dart';
import 'package:brave_steve/modules/money/repo/money_repo.dart';
import 'package:brave_steve/modules/prestige/prestige_data.dart';
import 'package:brave_steve/modules/prestige/prestige_repo.dart';
import 'package:brave_steve/modules/save_game/repo/save_repository.dart';
import 'package:brave_steve/modules/sounds/repo/sounds_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soundpool/soundpool.dart';

final dataBoxProvider = Provider((ref) => DataBox());

final counterEnemyRepoProvider = Provider((ref)=> CounterEnemyRepo( ref.watch(dataBoxProvider)));

final itemsProvider = Provider((ref) => Items());

final eqRepoProvider = Provider(
    (ref) => EqRepo(items: ref.watch(itemsProvider), dataSource: ref.watch(dataBoxProvider)));

final repoProvider = Provider((ref) => RepositoryGame(dataSource: ref.watch(dataBoxProvider)));

final saveRepositoryProvider = Provider((ref) => SaveRepository(dataSource: ref.watch(dataBoxProvider)));

final moneyRepoProvider = Provider((ref) => MoneyRepo(moneyData: MoneyData()));

final soundServiceProvider = Provider<SoundService>((ref) {
  final service = SoundService(Soundpool.fromOptions(
      options: const SoundpoolOptions(streamType: StreamType.notification),
    ));
  ref.onDispose(() => service.dispose());
  return service;
});

final mergeRepoProvider = Provider<MergeRepo>((ref) {
  return MergeRepo(items: ref.watch(itemsProvider));
});

final prestigeRepoProvider = Provider<PrestigeRepo>((ref) {
  return PrestigeRepo(PrestigeData());
});