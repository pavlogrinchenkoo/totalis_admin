import 'package:flutter/material.dart';
import 'package:totalis_admin/api/check_ins/dto.dart';
import 'package:totalis_admin/screens/main_page/screens/categories_page/bloc.dart';
import 'package:totalis_admin/screens/main_page/screens/user_categories_page/bloc.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/custom_open_icon.dart';
import 'package:totalis_admin/widgets/sheets_text.dart';

class CategoryDataCellWidget extends StatefulWidget {
  const CategoryDataCellWidget({this.userCategoryId, this.checkIn, super.key});

  final int? userCategoryId;
  final Future<CheckInModel?>? checkIn;

  @override
  State<CategoryDataCellWidget> createState() => _CategoryDataCellWidgetState();
}

class _CategoryDataCellWidgetState extends State<CategoryDataCellWidget> {
  final CategoriesBloc _blocCategories = CategoriesBloc();
  final UserCategoriesBloc _blocUserCategory = UserCategoriesBloc();

  int? id;

  @override
  void initState() {
    _initId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (id == null) {
      return const SizedBox();
    } else {
      return InkWell(
          borderRadius: BRadius.r6,
          onTap: () async => _blocCategories.openChange(
              context, await _blocCategories.getCategory(id)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SheetText(text: id),
            ],
          ));
    }
  }

  Future<void> _initId() async {
    if (widget.checkIn != null) {
      final checkIn = await widget.checkIn;
      final userCategory =
          await _blocUserCategory.getUserCategory(checkIn?.user_category_id);
      final id = await _blocUserCategory.getUserCategoryId(userCategory?.id);
      setState(() {
        this.id = id;
      });
    } else {
      final id =
          await _blocUserCategory.getUserCategoryId(widget.userCategoryId);
      setState(() {
        this.id = id;
      });
    }
  }
}
