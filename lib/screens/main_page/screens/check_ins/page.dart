import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:totalis_admin/api/check_ins/dto.dart';
import 'package:totalis_admin/api/check_ins/request.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/custom_buttom.dart';
import 'package:totalis_admin/widgets/custom_progress_indicator.dart';

import 'bloc.dart';
import 'widgets/custom_sheets_widget.dart';

@RoutePage()
class CheckInsPage extends StatefulWidget {
  const CheckInsPage({super.key});

  @override
  State<CheckInsPage> createState() => _CheckInsPageState();
}

class _CheckInsPageState extends State<CheckInsPage> {
  final CheckInsBloc _bloc = CheckInsBloc();

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
          if (state.loading && state.checkins.isEmpty) {
            return const CustomProgressIndicator();
          } else {
            return Scaffold(
                body: Container(
              padding: const EdgeInsets.only(top: 80, left: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text('Check-ins', style: BS.sb32),
                    Space.w52,
                    CustomButton(
                        title: 'New check-in',
                        onTap: () => _bloc.openChange(context, CheckInModel())),
                  ]),
                  Space.h24,
                  CustomSheetsWidget(
                      items: state.checkins,
                      openChange: (item) => _bloc.openChange(context, item))
                ],
              ),
            ));
          }
        });
  }
}
