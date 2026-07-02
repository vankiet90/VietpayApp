import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LastUpdatedWidget extends StatelessWidget {
  final DateTime updatedAt;

  const LastUpdatedWidget({super.key, required this.updatedAt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Last Updated: ${DateFormat('dd/MM/yyyy HH:mm').format(updatedAt)}",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
