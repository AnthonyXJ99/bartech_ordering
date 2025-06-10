import 'package:flutter/material.dart';

class TiempoTranscurridoWidget extends StatelessWidget {
  final DateTime fechaIngreso;
  final bool urgente;
  const TiempoTranscurridoWidget({
    super.key,
    required this.fechaIngreso,
    this.urgente = false,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: Stream.periodic(
        const Duration(seconds: 1),
        (_) => DateTime.now(),
      ),
      builder: (context, snapshot) {
        final ahora = snapshot.data ?? DateTime.now();
        final d = ahora.difference(fechaIngreso);
        String txt;
        if (d.inHours > 0) {
          txt = "${d.inHours}h ${d.inMinutes % 60}m";
        } else {
          txt =
              "${d.inMinutes.toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}";
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(
            color: urgente ? Colors.red.shade100 : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "Hace $txt",
            style: TextStyle(
              fontSize: 12.5,
              color: urgente ? Colors.red.shade900 : Colors.grey.shade800,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}
