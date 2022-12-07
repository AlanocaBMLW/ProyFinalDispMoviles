import 'package:flutter/material.dart';

Future<dynamic> deleteDialog(BuildContext context) {
  Future<dynamic> dialog = showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.redAccent, width: 2.0),
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.warning_rounded, color: Colors.redAccent, size: 40),
            SizedBox(width: 10),
            Text("Warning", textAlign: TextAlign.center),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("SEguro que quieres eliminar estudiante?"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text("No"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text("Si"),
                )
              ],
            )
          ],
        ),
      );
    },
  );

  return dialog.then((res) => res ?? false);
}
