import 'package:bartech_ordering/models/pedido.dart';
import 'package:bartech_ordering/presentation/screens/bloc/pedidos_bloc/pedidos_bloc.dart';
import 'package:bartech_ordering/presentation/screens/components/pedido_tipo.dart';
import 'package:bartech_ordering/presentation/widgets/pedido_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PedidosList extends StatelessWidget {
  final PedidosTipo
  tipo; // Enum para distinguir: nuevos, en preparación, listos
  final String titulo;
  final String actionLabel;
  final IconData actionIcon;
  final Color actionColor;

  const PedidosList({
    super.key,
    required this.tipo,
    required this.titulo,
    required this.actionLabel,
    required this.actionIcon,
    required this.actionColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PedidosBloc, PedidosState>(
      builder: (context, state) {
        // Elegimos la lista según tipo
        List<PedidoItem> pedidos;
        switch (tipo) {
          case PedidosTipo.nuevos:
            pedidos = state.pedidosNuevos;
            break;
          case PedidosTipo.preparacion:
            pedidos = state.pedidosEnPreparacion;
            break;
          case PedidosTipo.listos:
            pedidos = state.pedidosListos;
            break;
        }

        if (pedidos.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Text(
                "No hay pedidos.",
                style: TextStyle(color: Colors.grey.shade400, fontSize: 18),
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Text(
                titulo,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                itemCount: pedidos.length,
                itemBuilder: (context, index) {
                  final pedido = pedidos[index];
                  return PedidoCard(
                    pedido: pedido,
                    actionLabel: actionLabel,
                    actionIcon: actionIcon,
                    actionColor: actionColor,
                    onMarcarListo: () {
                      final bloc = context.read<PedidosBloc>();
                      if (tipo == PedidosTipo.nuevos) {
                        bloc.add(MoverAPreparacion(pedido));
                      } else if (tipo == PedidosTipo.preparacion) {
                        bloc.add(MoverAListo(pedido));
                      } else if (tipo == PedidosTipo.listos) {
                        // Puedes poner acción de "Entregado" aquí si la necesitas
                      }
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
