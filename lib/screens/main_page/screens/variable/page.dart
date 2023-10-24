import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:totalis_admin/api/variable/dto.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/custom_buttom.dart';
import 'package:totalis_admin/widgets/custom_progress_indicator.dart';

import 'bloc.dart';
import 'widgets/custom_sheets_widget.dart';

@RoutePage()
class VariablePage extends StatefulWidget {
  const VariablePage({super.key});

  @override
  State<VariablePage> createState() => _VariablePageState();
}

class _VariablePageState extends State<VariablePage> {
  final VariableBloc _bloc = VariableBloc();

  @override
  void initState() {
    _bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, ScreenState state) {
          if (state.loading && state.variables.isEmpty) {
            return const CustomProgressIndicator();
          } else {
            return Scaffold(
                body: Container(
              padding: const EdgeInsets.only(top: 80, left: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text('Variables', style: BS.sb32),
                    Space.w52,
                    CustomButton(title: 'New variable',  onTap: () =>
                        _bloc.openChange(context, VariableModel())),
                  ]),
                  Space.h24,
                  CustomSheetsWidget(items: state.variables, openChange: (item) => _bloc.openChange(context, item))
                ],
              ),
            ));
          }
        });
  }
}
