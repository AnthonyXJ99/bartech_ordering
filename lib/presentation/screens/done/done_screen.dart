import 'package:bartech_ordering/presentation/screens/bloc/pedidos_bloc/pedidos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bartech_ordering/models/pedido.dart';
import 'package:bartech_ordering/presentation/widgets/pedido_card.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedidos Listos"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: BlocBuilder<PedidosBloc, PedidosState>(
        builder: (context, state) {
          final pedidos = state.pedidosListos;

          return DragTarget<PedidoItem>(
            onWillAcceptWithDetails: (pedido) {
              // Acepta pedidos con colorEstado AMBER (en preparación) para avanzar,
              // o GREEN (listos) para retroceder (si se permite).
              return pedido.data.colorEstado == Colors.amber;
            },
            onAcceptWithDetails: (pedido) {
              // Avanza: EN PREPARACIÓN -> LISTO
              if (pedido.data.colorEstado == Colors.amber) {
                context.read<PedidosBloc>().add(MoverAListo(pedido.data));
              }
              // Si permites retroceder de aquí a “En preparación”, añade otro bloque aquí.
            },
            builder: (context, candidateData, rejectedData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 12, top: 12, bottom: 8),
                    child: Text(
                      "Listos para entregar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    child: pedidos.isEmpty
                        ? Center(
                            child: Text(
                              "No hay pedidos listos.",
                              style: TextStyle(color: Colors.grey.shade400),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 6,
                            ),
                            itemCount: pedidos.length,
                            itemBuilder: (context, index) {
                              final pedido = pedidos[index];
                              // Hacer la card draggable para retroceder a “En preparación”
                              return LongPressDraggable<PedidoItem>(
                                data: pedido,
                                feedback: Material(
                                  color: Colors.transparent,
                                  child: SizedBox(
                                    width: 320,
                                    child: PedidoCard(
                                      pedido: pedido,
                                      actionLabel: "Entregar",
                                      actionIcon: Icons.delivery_dining,
                                      actionColor: Colors.blue,
                                      onMarcarListo:
                                          null, // o tu callback para entregar si lo necesitas
                                    ),
                                  ),
                                ),
                                childWhenDragging: Opacity(
                                  opacity: 0.3,
                                  child: PedidoCard(
                                    pedido: pedido,
                                    actionLabel: "Entregar",
                                    actionIcon: Icons.delivery_dining,
                                    actionColor: Colors.blue,
                                    onMarcarListo: null,
                                  ),
                                ),
                                child: PedidoCard(
                                  pedido: pedido,
                                  actionLabel: "Entregar",
                                  actionIcon: Icons.delivery_dining,
                                  actionColor: Colors.blue,
                                  onMarcarListo: null,
                                ),
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
