import 'package:flutter/material.dart';
import 'package:totalis_admin/api/check_ins/dto.dart';
import 'package:totalis_admin/screens/main_page/screens/check_ins/bloc.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/custom_open_icon.dart';
import 'package:totalis_admin/widgets/custom_progress_indicator.dart';
import 'package:totalis_admin/widgets/sheets_text.dart';

class CheckInWidget extends StatefulWidget {
  const CheckInWidget({this.id, super.key});

  final int? id;

  @override
  State<CheckInWidget> createState() => _CheckInWidgetState();
}

class _CheckInWidgetState extends State<CheckInWidget> {
  final CheckInsBloc _bloc = CheckInsBloc();
  final checkins = [];

  @override
  void initState() {
    _bloc.initCheckins(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomStreamBuilder<ScreenState>(
        bloc: _bloc,
        builder: (context, ScreenState? state) {
          if (state == null) {
            return const CustomProgressIndicator();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Check-ins'),
              Space.h8,
              for (final CheckInModel item in state.checkins)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      InkWell(
                          borderRadius: BRadius.r6,
                          onTap: () => _bloc.openChange(context, item),
                          child: Row(
                            children: [
                              const CustomOpenIcon(),
                              Space.w16,
                              SheetText(text: item.id),
                            ],
                          )),
                      Space.w8,
                      Text(item.summary ?? '')
                    ],
                  ),
                )
            ],
          );
        });
  }
}
