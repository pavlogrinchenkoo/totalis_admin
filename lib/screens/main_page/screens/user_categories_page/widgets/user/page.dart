import 'package:flutter/material.dart';
import 'package:totalis_admin/api/user/dto.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/widgets/sheets_text.dart';

import 'bloc.dart';

class UserWidget extends StatefulWidget {
  const UserWidget({required this.userId, this.onTap, super.key});

  final int? userId;
  final void Function(UserModel? user)? onTap;

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  final UserBloc _bloc = UserBloc();

  @override
  void initState() {
    _bloc.init(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, ScreenState state) {
          if (!state.loading &&
              state.user != null &&
              (state.user?.first_name != '' || state.user?.last_name != '')) {
            return InkWell(
                borderRadius: BRadius.r6,
                onTap: () => widget.onTap!(state.user),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SheetText(
                        text:
                            '${widget.userId}: ${state.user?.first_name ?? ''} ${state.user?.last_name ?? ''}'),
                  ],
                ));
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.userId.toString()),
              ],
            );
          }
        });
  }
}
