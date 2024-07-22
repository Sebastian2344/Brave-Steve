import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state_menegment/game_state.dart';
import 'alertsDialog/game_over.dart';
import 'alertsDialog/win_or_lose.dart';

class ActionInGame extends ConsumerStatefulWidget {
  const ActionInGame({super.key, required this.isNewGame});
  final bool isNewGame;
  @override
  ConsumerState<ActionInGame> createState() => ActionInGameState();
}

class ActionInGameState extends ConsumerState<ActionInGame> {
  static const Map<String, String> _listaIntro = {
    'Atak': 'Zadaje obrażenia takie jakie są w statystykach',
    'SuperAtak': 'Zadaje obrażenia 2 razy większe od tych co są w statystykach',
    'Osłabienie': 'Obniża atak przeciwnika o 30 procnt',
    'Oczyszczenie': 'Zdejmuje efekt osłabienia'
  };
  @override
  void initState() {
    if (widget.isNewGame) {
      SchedulerBinding.instance
          .addPostFrameCallback((Duration duration) => _showDiscovery());
    }
    super.initState();
  }

  Future<void> _showDiscovery() async {
    await FeatureDiscovery.clearPreferences(context, <String>{
      _listaIntro.keys.elementAt(0),
      _listaIntro.keys.elementAt(1),
      _listaIntro.keys.elementAt(2),
      _listaIntro.keys.elementAt(3)
    });
    if (!mounted) return;
    FeatureDiscovery.discoverFeatures(context, <String>{
      _listaIntro.keys.elementAt(0),
      _listaIntro.keys.elementAt(1),
      _listaIntro.keys.elementAt(2),
      _listaIntro.keys.elementAt(3)
    });
  }

  void dialogWindow(Enum a, BuildContext context) {
    Stan.koniecGry == a
        ? showDialog(barrierDismissible: false,context: context, builder: (context) => const GameOver())
        : Stan.wygrana == a
            ? showDialog(
              barrierDismissible: false,
                context: context,
                builder: (context) => const WinOrLose(win: true))
            : Stan.przegrana == a
                ? showDialog(
                  barrierDismissible: false,
                    context: context,
                    builder: (context) => const WinOrLose(win: false))
                : null;
  }

  @override
  Widget build(BuildContext context) {
    final gameFields = ref.watch(myStateProvider);
    final gameMetods = ref.watch(myStateProvider.notifier);
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double fontSize = mediaQueryData.textScaler.scale(16.0);
    final widthButton = mediaQueryData.size.width * 0.4;
    final heightButton = mediaQueryData.size.height * 0.07;
    return Expanded(
      child: ColoredBox(
        color: const Color.fromARGB(255, 109, 107, 106),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonWidget(
                  fontSize: fontSize,
                  buttonIgnore: gameFields.buttonIgnore[0],
                  battle: () async {
                    final Enum a = await gameMetods.battle(
                        superAtack: false, cleary: false, weakOnEnemy: false,);
                    if (context.mounted) {
                      a == Stan.wygrana
                          ? gameMetods.winnerOrLoser(true)
                          : a == Stan.przegrana
                              ? gameMetods.winnerOrLoser(false)
                              : null;
                      dialogWindow(a, context);
                    } 
                  }, 
                  manaCost:'(+1 many)',
                  textButton: _listaIntro.keys.first,
                  color: const Color.fromARGB(255, 18, 50, 228),
                  width: widthButton,
                  height: heightButton),
              ButtonWidget(
                  fontSize: fontSize,
                  buttonIgnore: gameFields.buttonIgnore[1],
                  battle: () async {
                    final Enum a = await gameMetods.battle(
                        superAtack: true, cleary: false, weakOnEnemy: false,);
                    if (context.mounted) {
                      a == Stan.wygrana
                          ? gameMetods.winnerOrLoser(true)
                          : a == Stan.przegrana
                              ? gameMetods.winnerOrLoser(false)
                              : null;
                      dialogWindow(a, context);
                    }
                  },
                  manaCost: '(4 many)',
                  textButton: _listaIntro.keys.elementAt(1),
                  color: const Color.fromARGB(255, 12, 205, 18),
                  width: widthButton,
                  height: heightButton),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonWidget(
                  fontSize: fontSize,
                  buttonIgnore: gameFields.buttonIgnore[2],
                  battle: () async {
                    final Enum a = await gameMetods.battle(
                        superAtack: false, cleary: false, weakOnEnemy: true,);
                    if (context.mounted) {
                      a == Stan.wygrana
                          ? gameMetods.winnerOrLoser(true)
                          : a == Stan.przegrana
                              ? gameMetods.winnerOrLoser(false)
                              : null;
                      dialogWindow(a, context);
                    }
                  },
                  manaCost: '(4 many)',
                  textButton: _listaIntro.keys.elementAt(2),
                  color: const Color.fromARGB(255, 105, 18, 228),
                  width: widthButton,
                  height: heightButton),
              ButtonWidget(
                  fontSize: fontSize - 1,
                  buttonIgnore: gameFields.buttonIgnore[3],
                  battle: () async {
                    final Enum a = await gameMetods.battle(
                        superAtack: false, cleary: true, weakOnEnemy: false,);
                    if (context.mounted) {
                      a == Stan.wygrana
                          ? gameMetods.winnerOrLoser(true)
                          : a == Stan.przegrana
                              ? gameMetods.winnerOrLoser(false)
                              : null;
                      dialogWindow(a, context);
                    }
                  },
                  manaCost: '(3 many)',
                  textButton: _listaIntro.keys.elementAt(3),
                  color: const Color.fromARGB(255, 12, 92, 205),
                  width: widthButton,
                  height: heightButton),
            ],
          ),
        ]),
      ),
    );
  }
}

//=====================================ButtonWidget=============================================
class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.fontSize,
      required this.buttonIgnore,
      required this.battle,
      required this.textButton,
      required this.color,
      required this.width,
      required this.height,
      required this.manaCost});
  final double fontSize;
  final bool buttonIgnore;
  final VoidCallback battle;
  final String textButton;
  final Color color;
  final double width;
  final double height;
  final String manaCost;
  @override
  Widget build(BuildContext context) {
    return DescribedFeatureOverlay(
      contentLocation: ContentLocation.above,
      overflowMode: OverflowMode.extendBackground,
      backgroundDismissible: true,
      barrierDismissible: false,
      featureId: textButton,
      tapTarget: Text(textButton),
      title: Text(textButton),
      description: Text(ActionInGameState._listaIntro.entries
          .firstWhere((element) => element.key == textButton)
          .value),
      backgroundColor: color,
      child: IgnorePointer(
        ignoring: buttonIgnore,
        child: ElevatedButton(
          onPressed: battle,
          style: ElevatedButton.styleFrom(
              fixedSize: Size(width, height),
              textStyle: TextStyle(fontSize: fontSize),
              foregroundColor: Colors.white,
              backgroundColor: buttonIgnore ? Colors.grey : color),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(textButton),
              Text(manaCost)
            ],
          ),
        ),
      ),
    );
  }
}
