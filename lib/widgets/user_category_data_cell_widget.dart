import 'package:flutter/material.dart';
import 'package:totalis_admin/api/check_ins/dto.dart';
import 'package:totalis_admin/api/user_categories/dto.dart';
import 'package:totalis_admin/screens/main_page/screens/user_categories_page/bloc.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/custom_open_icon.dart';
import 'package:totalis_admin/widgets/sheets_text.dart';

class UserCategoryDataCellWidget extends StatefulWidget {
  const UserCategoryDataCellWidget(
      {this.checkIn, this.userCategoryId, super.key});

  final Future<CheckInModel?>? checkIn;
  final int? userCategoryId;

  @override
  State<UserCategoryDataCellWidget> createState() =>
      _UserCategoryDataCellWidgetState();
}

class _UserCategoryDataCellWidgetState
    extends State<UserCategoryDataCellWidget> {
  final UserCategoriesBloc _blocUserCategory = UserCategoriesBloc();

  UserCategoryModel? userCategory;

  @override
  void initState() {
    _initId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (userCategory == null) {
      return const SizedBox();
    } else {
      return InkWell(
          borderRadius: BRadius.r6,
          onTap: () async =>
              _blocUserCategory.openChange(context, userCategory),
          child: SheetText(text: userCategory?.id));
    }
  }

  Future<void> _initId() async {
    if (widget.userCategoryId != null) {
      final userCategory =
          await _blocUserCategory.getUserCategory(widget.userCategoryId);
      setState(() {
        this.userCategory = userCategory;
      });
      return;
    }
    final checkIn = await widget.checkIn;
    final userCategory =
        await _blocUserCategory.getUserCategory(checkIn?.user_category_id);
    setState(() {
      this.userCategory = userCategory;
    });
  }
}
