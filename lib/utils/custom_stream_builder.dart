import 'package:flutter/material.dart';

class CustomStreamBuilder<T> extends StatefulWidget {
  const CustomStreamBuilder({required this.bloc, required this.builder, super.key});

  final dynamic bloc;
  final dynamic builder;

  @override
  State<CustomStreamBuilder> createState() => _CustomStreamBuilderState();
}

class _CustomStreamBuilderState extends State<CustomStreamBuilder> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: widget.bloc.currentState,
        stream: widget.bloc.state,
        builder: (context, snapshot) => widget.builder(context, snapshot.data));
  }
}
