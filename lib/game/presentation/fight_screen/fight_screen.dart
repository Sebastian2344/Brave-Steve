import 'package:brave_steve/game/presentation/eq_screen/eq.dart';
import 'package:brave_steve/game/presentation/fight_screen/exit_to_menu_dialog.dart';
import 'package:brave_steve/game/presentation/fight_screen/save_game_dialog.dart';
import 'package:brave_steve/game/presentation/fight_screen/battle_view_widget.dart';
import 'package:brave_steve/game/presentation/fight_screen/stats_view_widget.dart';
import 'package:brave_steve/game/presentation/merge_item_screen/merge_item_screen.dart';
import 'package:brave_steve/game/presentation/money_widget.dart';
import 'package:brave_steve/game/state_menegment/game_state.dart';
import 'package:brave_steve/game/state_menegment/sound_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcaseview/showcaseview.dart';

import 'action_buttons_view_widget.dart';

class FightScreen extends ConsumerStatefulWidget {
  const FightScreen(this.isNewGame, {super.key});
  final bool isNewGame;

  @override
  ConsumerState<FightScreen> createState() => _FightScreenState();
}

class _FightScreenState extends ConsumerState<FightScreen> {
  // Klucze dla elementów paska
  final GlobalKey _keySave = GlobalKey();
  final GlobalKey _keyEq = GlobalKey();
  final GlobalKey _keyMerge = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final Size mediaQuerySize = MediaQuery.of(context).size;
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double fontSize = mediaQueryData.textScaler.scale(14.0);

    // POPRAWKA: 'builder' przyjmuje funkcję (context), a nie widget Builder.
    return ShowCaseWidget(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            foregroundColor: Colors.white,
            leadingWidth: MediaQuery.of(context).size.width / 4,
            leading: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    ref.read(soundManagerProvider.notifier).playButtonClick();
                    showDialog(
                        context: context,
                        builder: (context) => const ExitToMenu());
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                // === DYSKIETKA ZAPISU ===
                Showcase(
                  key: _keySave,
                  title: 'fight_screen.appbar.save_game'.tr(context: context),
                  description: 'fight_screen.appbar.save_progress'.tr(context: context),
                  overlayColor: Colors.black.withValues(alpha: 0.7),
                  targetBorderRadius: BorderRadius.circular(50),
                  tooltipBackgroundColor: Colors.white,
                  textColor: Colors.black,
                  titleTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  child: IconButton(
                    onPressed: () async {
                      ref.read(soundManagerProvider.notifier).playButtonClick();
                      showDialog(
                          context: context, builder: (context) => SaveGame());
                    },
                    icon: const Icon(Icons.save),
                  ),
                ),
              ],
            ),
            title: Text('main_menu.game_title'.tr()),
            centerTitle: true,
            backgroundColor: const Color(0xFF301b0a),
            actions: [
              // === EKWIPUNEK / LUDZIK ===
              Showcase(
                  key: _keyEq,
                  title: 'fight_screen.appbar.eq'.tr(context: context),
                  description: 'fight_screen.appbar.eq_description'.tr(context: context),
                  overlayColor: Colors.black.withValues(alpha: 0.7),
                  targetBorderRadius: BorderRadius.circular(50),
                  tooltipBackgroundColor: Colors.white,
                  textColor: Colors.black,
                  titleTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  child: Consumer(
                    builder: (context, ref, child) {
                      ref.watch(myStateProvider);
                      return IconButton(
                          onPressed: () {
                            if (ref.read(myStateProvider.notifier).isEq()) {
                              ref.read(soundManagerProvider.notifier).playButtonClick();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Equpment()));
                            }
                          },
                          icon: Icon(
                            Icons.person,
                            color: ref.read(myStateProvider.notifier).isEq()
                                ? Colors.amber
                                : Colors.grey,
                          ));
                    },
                  )),
              Showcase(
                key: _keyMerge,
                title: 'fight_screen.appbar.merge'.tr(context: context),
                description: 'fight_screen.appbar.merge_description'.tr(context: context),
                overlayColor: Colors.black.withValues(alpha: 0.7),
                targetBorderRadius: BorderRadius.circular(50),
                tooltipBackgroundColor: Colors.white,
                textColor: Colors.black,
                titleTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
                child: IconButton(
                    onPressed: () {
                      ref.read(soundManagerProvider.notifier).playButtonClick();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MergeItemScreen()));
                    },
                    icon: Icon(Icons.merge_type)),
              )
            ],
          ),
          body: Column(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  BattleView(
                    fontSize: fontSize,
                    mediaQuerySize: mediaQuerySize,
                  ),
                  const MoneyWidget(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StatsView(
                      side: 'left',
                      fontSize: fontSize,
                      mediaQuerySize: mediaQuerySize),
                  StatsView(
                      side: 'right',
                      fontSize: fontSize,
                      mediaQuerySize: mediaQuerySize)
                ],
              ),
              // Przekazujemy klucze do dolnego widgetu
              ActionInGame(
                isNewGame: widget.isNewGame,
                keySave: _keySave,
                keyEq: _keyEq,
                keyMerge: _keyMerge,
              )
            ],
          ),
        );
      },
    );
  }
}
