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
class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final MessageBloc _bloc = MessageBloc();

  @override
  void initState() {
    // _bloc.init();
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
                    Text('Messages', style: BS.sb32),
                  ]),
                  Space.h24,
                  Text('Empty', style: BS.sb20),
                  // CustomSheetsWidget(items: state.variables)
                ],
              ),
            ));
          }
        });
  }
}
