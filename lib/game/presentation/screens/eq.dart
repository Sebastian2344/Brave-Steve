import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state_menegment/eq_state.dart';
import '../widgets/alertsDialog/eq_dialogs.dart';

class Equpment extends StatelessWidget {
  const Equpment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Equpment'),
        centerTitle: true,
        backgroundColor: Colors.brown[900],
        foregroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            WindowEQ(id: 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WindowEQ(
                  id: 1,
                ),
                WindowEQ(
                  id: 2,
                )
              ],
            ),
            WindowEQ(
              id: 3,
            ),
            WindowEQ(
              id: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WindowEQ(
                  id: 5,
                ),
                WindowEQ(
                  id: 6,
                ),
                WindowEQ(
                  id: 7,
                ),
                WindowEQ(
                  id: 8,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WindowEQ(
                  id: 9,
                ),
                WindowEQ(
                  id: 10,
                ),
                WindowEQ(
                  id: 11,
                ),
                WindowEQ(
                  id: 12,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WindowEQ(
                  id: 13,
                ),
                WindowEQ(
                  id: 14,
                ),
                WindowEQ(
                  id: 15,
                ),
                WindowEQ(
                  id: 16,
                )
              ],
            ),
          ],
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
    ref.watch(providerEQ);
    return GestureDetector(
      onTap: () {
        !ref.read(providerEQ.notifier).isEmpty(id)
            ? showDialog(
                context: context,
                builder: (context) {
                  return AlertDialogW(id: id);
                })
            : null;
      },
      onLongPress: () {
        !ref.read(providerEQ.notifier).isEmpty(id)
            ? showDialog(
                context: context,
                builder: (context) {
                  return DeleteItemDialog(
                    id: id,
                  );
                })
            : null;
      },
      child: ref.read(providerEQ.notifier).isEmpty(id)
          ? Container(
              margin: const EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width / 4.85,
              height: MediaQuery.of(context).size.width / 4.85,
              decoration: BoxDecoration(
                  color: Colors.brown[800],
                  border: Border.all(
                      color: const Color.fromARGB(255, 62, 39, 35), width: 2)),
            )
          : Container(
              width: MediaQuery.of(context).size.width / 4.85,
              height: MediaQuery.of(context).size.width / 4.85,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 62, 39, 35), width: 2)),
              child: Image.asset(
                ref.read(providerEQ.notifier).itemUrl(id),
              ),
            ),
    );
  }
}