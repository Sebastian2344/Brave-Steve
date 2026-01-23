import 'package:brave_steve/game/state_menegment/money_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoneyWidget extends ConsumerWidget {
  const MoneyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE0C097),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: const Color(0xFFB8860B), width: 2.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.monetization_on,
            color: Color(0xFFB8860B),
          ),
          const SizedBox(width: 8.0),
          Text(
            '${ref.watch(moneyProvider).money.toStringAsFixed(2)} \$',
            style: const TextStyle(
              color: Color(0xFF654321),
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}