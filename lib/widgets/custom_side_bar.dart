import 'package:build_context_provider/build_context_provider.dart';
import 'package:flutter/material.dart';
import 'package:totalis_admin/api/request.dart';
import 'package:totalis_admin/generated/assets.gen.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/spaces.dart';

class CustomSideBar extends StatelessWidget {
  final int? currentIndex;
  final void Function(int, {bool notify})? onTap;
  final Request _request = Request();

  CustomSideBar({required this.currentIndex, required this.onTap, super.key});

  final items = [
    CustomSideBarItem(title: 'Admins', icon: Assets.admins.svg()),
    CustomSideBarItem(title: 'Users', icon: Assets.users.svg()),
    CustomSideBarItem(title: 'Categories', icon: Assets.category.svg()),
    CustomSideBarItem(
        title: 'User-categories', icon: Assets.userCategory.svg()),
    CustomSideBarItem(title: 'Coaches', icon: Assets.coaches.svg()),
    CustomSideBarItem(title: 'Check-ins', icon: Assets.checkIns.svg()),
    CustomSideBarItem(title: 'Recommendations', icon: Assets.rec.svg()),
    CustomSideBarItem(title: 'Variables', icon: Assets.variables.svg()),
    CustomSideBarItem(title: 'Messages', icon: Assets.messages.svg()),
    CustomSideBarItem(title: 'System', icon: const Icon(Icons.settings)),
    CustomSideBarItem(
        title: 'Models Chat Gpt', icon: const Icon(Icons.model_training)),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325,
      color: BC.green,
      padding: const EdgeInsets.only(top: 85, left: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const ListenerThatRunsFunctionsWithBuildContext(),
        Text('TOTALIS : ADMIN', style: BS.sb24.apply(color: BC.white)),
        Space.h80,
        Container(
            padding: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
                border: Border(left: BorderSide(color: BC.white, width: 5))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              for (int i = 0, length = items.length; i < length; i++)
                InkWell(
                    onTap: onTap != null ? () => onTap!(i) : () => {},
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: currentIndex == i
                                        ? BC.white
                                        : Colors.transparent,
                                    width: 1))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            items[i].icon,
                            Space.w8,
                            Text(items[i].title,
                                style: BS.med20.apply(color: BC.white)),
                          ],
                        ))),
              InkWell(
                  onTap: () => _request.logout(),
                  child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.transparent, width: 1))),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.logout, color: BC.white),
                          Space.w8,
                          Text('Logout',
                              style: BS.med20.apply(color: BC.white)),
                        ],
                      )))
            ]))
      ]),
    );
  }
}

class CustomSideBarItem {
  final String title;
  final Widget icon;

  CustomSideBarItem({required this.title, required this.icon});
}
