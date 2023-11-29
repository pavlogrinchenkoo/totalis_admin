import 'package:flutter/material.dart';
import 'package:totalis_admin/api/check_ins/dto.dart';
import 'package:totalis_admin/screens/main_page/screens/check_ins/bloc.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/custom_open_icon.dart';
import 'package:totalis_admin/widgets/sheets_text.dart';

class CheckInDataCellWidget extends StatefulWidget {
  const CheckInDataCellWidget({this.checkInId, super.key});

  final int? checkInId;

  @override
  State<CheckInDataCellWidget> createState() => _CheckInDataCellWidgetState();
}

class _CheckInDataCellWidgetState extends State<CheckInDataCellWidget> {
  final CheckInsBloc _blocCheckIn = CheckInsBloc();

  CheckInModel? checkIn;

  @override
  void initState() {
    _initId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (checkIn == null) {
      return const SizedBox();
    } else {
      return InkWell(
          borderRadius: BRadius.r6,
          onTap: () async => _blocCheckIn.openChange(context, checkIn),
          child: SheetText(text: checkIn?.id));
    }
  }

  Future<void> _initId() async {
    final checkIn = await _blocCheckIn.getCheckIn(widget.checkInId);
    setState(() {
      this.checkIn = checkIn;
    });
  }
}
