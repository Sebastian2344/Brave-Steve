import 'package:brave_steve/game/presentation/eq_screen/put_on_dialog.dart';
import 'package:brave_steve/game/presentation/eq_screen/sell_item_dialog.dart';
import 'package:brave_steve/game/presentation/eq_screen/take_off_dialog.dart';
import 'package:brave_steve/game/presentation/eq_screen/exchange_item_dialog.dart';
import 'package:brave_steve/game/presentation/money_widget.dart';
import 'package:brave_steve/game/state_menegment/sound_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state_menegment/eq_state.dart';

class Equpment extends ConsumerWidget {
  const Equpment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title:Text('equipment_screen.equipment'.tr()),
        centerTitle: true,
        backgroundColor: Colors.brown[900],
        foregroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              ref.read(soundManagerProvider.notifier).playButtonClick();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          )
      ),
      // SafeArea zapobiega ucinaniu ekranu przez notch (wycięcie na aparat)
      body: SafeArea(
        // SingleChildScrollView zapobiega błędom overflow na mniejszych ekranach
        child: SingleChildScrollView(
          child: Stack(alignment: Alignment.topRight, children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  const WindowEQ(id: 0),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WindowEQ(id: 1),
                      WindowEQ(id: 2),
                    ],
                  ),
                  const WindowEQ(id: 3),
                  const WindowEQ(id: 4),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WindowEQ(id: 5),
                      WindowEQ(id: 6),
                      WindowEQ(id: 7),
                      WindowEQ(id: 8),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WindowEQ(id: 9),
                      WindowEQ(id: 10),
                      WindowEQ(id: 11),
                      WindowEQ(id: 12),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WindowEQ(id: 13),
                      WindowEQ(id: 14),
                      WindowEQ(id: 15),
                      WindowEQ(id: 16),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WindowEQ(id: 17),
                      WindowEQ(id: 18),
                      WindowEQ(id: 19),
                      WindowEQ(id: 20),
                    ],
                  ),
                ],
              ),
            ),
            MoneyWidget()
          ]),
        ),
      ),
    );
  }
}

class WindowEQ extends ConsumerWidget {
  const WindowEQ({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Obserwowanie stanu
    ref.watch(providerEQ);

    // Zapisanie stanu do zmiennej, aby kod był czystszy i wydajniejszy
    final isEmpty = ref.read(providerEQ)[id].isEmpty;

    // DYNAMICZNE DOPASOWANIE DO EKRANU:
    final screenWidth = MediaQuery.of(context).size.width;
    // Okienko zajmuje 18% szerokości ekranu, a margines z każdej strony to 2%.
    // Dla 4 elementów daje to idealne dopasowanie bez wychodzenia poza ekran.
    final double boxSize = screenWidth * 0.18;
    final double marginSize = screenWidth * 0.02;
    final bool czyPuste = ref.read(providerEQ.notifier).czyPustePole(id);

    return InkWell(
      onTap: () {
        if (!isEmpty) {
          ref.read(soundManagerProvider.notifier).playButtonClick();
          showDialog(
            context: context,
            builder: (context) {
              if (czyPuste && id > 4) {
                return PutOnDialog(id: id);
              } else if (id <= 4) {
                return TakeOffDialog(id: id);
              } else {
                return ExchangeItemInEqDialog(id: id);
              }
            },
          );
        }
      },
      onLongPress: () {
        if (!isEmpty) {
          showDialog(
            context: context,
            builder: (context) {
              return SellItemDialog(id: id);
            },
          );
        }
      },
      child: Container(
        width: boxSize,
        height: boxSize,
        margin: EdgeInsets.all(marginSize),
        decoration: BoxDecoration(
          color: isEmpty ? Colors.brown[800] : null,
          border: Border.all(
            color: const Color.fromARGB(255, 62, 39, 35),
            width: 2,
          ),
        ),
        // Jeśli jest puste, nie ma child. Jeśli pełne, pokazujemy obrazek.
        child: isEmpty
            ? null
            : Image.asset(
                ref.read(providerEQ)[id].item.image,
                fit: BoxFit.fill,
              ),
      ),
    );
  }
}
