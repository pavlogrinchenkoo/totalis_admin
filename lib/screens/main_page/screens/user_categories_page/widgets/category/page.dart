import 'package:flutter/material.dart';
import 'package:totalis_admin/api/categories/dto.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/widgets/sheets_text.dart';

import 'bloc.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({required this.categoryId, this.onTap, super.key});

  final int? categoryId;
  final void Function(CategoryModel? category)? onTap;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  final CategoryWidgetBloc _bloc = CategoryWidgetBloc();

  @override
  void initState() {
    _bloc.init(widget.categoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, ScreenState state) {
          if (!state.loading && state.category != null) {
            return InkWell(
                borderRadius: BRadius.r6,
                onTap: () => widget.onTap!(state.category),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SheetText(
                        text:
                        '${widget.categoryId}: ${state.category?.name ?? ''}'),
                  ],
                ));
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.categoryId.toString()),
              ],
            );
          }
        });
  }
}
