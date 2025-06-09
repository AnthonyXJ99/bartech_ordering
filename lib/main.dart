import 'package:bartech_ordering/config/router.dart';
import 'package:bartech_ordering/config/theme.dart';
import 'package:bartech_ordering/presentation/screens/bloc/pedidos_bloc/pedidos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PedidosBloc()..add(CargarPedidos()),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: kanbanTheme,
        routerConfig: appRouter,
      ),
    );
  }
}
