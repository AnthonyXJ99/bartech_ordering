import 'package:bartech_ordering/models/pedido.dart';
import 'package:bartech_ordering/presentation/widgets/tiempo_transcurrido.dart';
import 'package:flutter/material.dart';
// Asegúrate de importar TiempoTranscurridoWidget

class PedidoCard extends StatelessWidget {
  final PedidoItem pedido;
  final VoidCallback? onMarcarListo;
  final String actionLabel;
  final IconData actionIcon;
  final Color actionColor;

  const PedidoCard({
    super.key,
    required this.pedido,
    required this.actionLabel,
    required this.actionIcon,
    required this.actionColor,
    this.onMarcarListo,
  });

  @override
  Widget build(BuildContext context) {
    final bool urgente =
        pedido.tiempoTranscurrido.inMinutes >= 15; // Puedes ajustar

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: urgente ? 10 : 6,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: pedido.colorEstado, width: 7),
            top: BorderSide(color: pedido.colorEstado, width: 1),
            right: BorderSide(color: pedido.colorEstado, width: 1),
            bottom: BorderSide(color: pedido.colorEstado, width: 1),
          ),
          color: urgente ? Colors.red.shade50 : null,
          borderRadius: const BorderRadius.all(Radius.circular(18)),
        ),
        padding: const EdgeInsets.fromLTRB(18, 14, 12, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: N° orden, cliente, para llevar/local, botón
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: pedido.colorEstado.withAlpha(38),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: pedido.colorEstado, width: 1.5),
                  ),
                  child: Text(
                    'N° ${pedido.nroOrden}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: pedido.colorEstado,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),

                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person, size: 17, color: Colors.black54),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              pedido.cliente,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            pedido.paraLlevar
                                ? Icons.shopping_bag
                                : Icons.restaurant,
                            size: 15,
                            color: pedido.paraLlevar
                                ? Colors.orange
                                : Colors.green,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            pedido.paraLlevar ? "Para llevar" : "En local",
                            style: TextStyle(
                              color: pedido.paraLlevar
                                  ? Colors.orange.shade800
                                  : Colors.green.shade700,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.5,
                            ),
                          ),
                          if (urgente) ...[
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "URGENTE",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                if (onMarcarListo != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: ElevatedButton.icon(
                      onPressed: onMarcarListo,
                      icon: Icon(actionIcon, color: Colors.white, size: 20),
                      label: Text(
                        actionLabel,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: actionColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                        textStyle: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            // Producto y cantidad
            Row(
              children: [
                Icon(Icons.fastfood, color: pedido.colorEstado, size: 20),
                const SizedBox(width: 6),
                Text(
                  "${pedido.producto}  x${pedido.cantidad}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            // Fechas y tiempo transcurrido
            Row(
              children: [
                Icon(Icons.access_time, size: 17, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(
                  "Ingresó: ${pedido.fechaHoraIngresoString}",
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 10),
                TiempoTranscurridoWidget(
                  fechaIngreso: pedido.fechaHoraIngreso,
                  urgente: urgente,
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Ingredientes
            if (pedido.ingredientes.isNotEmpty) ...[
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: pedido.ingredientes.map((ing) {
                  Color chipColor = Colors.grey.shade200;
                  Color textColor = Colors.black87;
                  if (ing.toLowerCase().contains("sin")) {
                    chipColor = Colors.red.shade200;
                    textColor = Colors.red.shade900;
                  } else if (ing.toLowerCase().contains("extra")) {
                    chipColor = Colors.green.shade200;
                    textColor = Colors.green.shade900;
                  }
                  return Chip(
                    label: Text(
                      ing,
                      style: TextStyle(fontSize: 13, color: textColor),
                    ),
                    backgroundColor: chipColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
            ],
            // Acompañamientos
            if (pedido.acompanamientos.isNotEmpty) ...[
              Row(
                children: [
                  const Icon(
                    Icons.local_dining,
                    size: 17,
                    color: Colors.black45,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      "Acompañamientos: ${pedido.acompanamientos.join(", ")}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
            // Observación
            if (pedido.observacion.isNotEmpty)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.comment, size: 17, color: Colors.black38),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      pedido.observacion,
                      style: const TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
