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
    CustomSideBarItem(title: 'Admins', icon: Assets.admins),
    CustomSideBarItem(title: 'Users', icon: Assets.users),
    CustomSideBarItem(title: 'Categories', icon: Assets.category),
    CustomSideBarItem(title: 'User-categories', icon: Assets.userCategory),
    CustomSideBarItem(title: 'Coaches', icon: Assets.coaches),
    CustomSideBarItem(title: 'Check-ins', icon: Assets.checkIns),
    CustomSideBarItem(title: 'Recommendations', icon: Assets.rec),
    CustomSideBarItem(title: 'Variables', icon: Assets.variables),
    CustomSideBarItem(title: 'Messages', icon: Assets.messages),
    CustomSideBarItem(title: 'System', icon: Assets.settings),
    CustomSideBarItem(title: 'Models Chat Gpt', icon: Assets.models),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: BC.white,
      padding: const EdgeInsets.only(top: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const ListenerThatRunsFunctionsWithBuildContext(),
        Padding(
          padding: const EdgeInsets.only(left: 26),
          child: Text('Totalis Admin', style: BS.sb24),
        ),
        Space.h16,
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          for (int i = 0, length = items.length; i < length; i++)
            InkWell(
                onTap: onTap != null ? () => onTap!(i) : () => {},
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                          decoration: BoxDecoration(
                              color: currentIndex == i
                                  ? BC.green.withOpacity(0.1)
                                  : BC.white,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              border: Border(
                                  bottom: BorderSide(
                                      color: currentIndex == i
                                          ? BC.white
                                          : Colors.transparent,
                                      width: 1))),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              items[i].icon.svg(
                                  colorFilter: ColorFilter.mode(
                                      currentIndex == i
                                          ? BC.green
                                          : BC.darkGray,
                                      BlendMode.srcIn)),
                              Space.w8,
                              Text(items[i].title,
                                  style: BS.sb14.apply(
                                      color: currentIndex == i
                                          ? BC.green
                                          : BC.black)),
                            ],
                          )),
                    ),
                  ],
                )),
          InkWell(
              onTap: () => _request.logout(),
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Colors.transparent, width: 1))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.logout, color: BC.white),
                      Space.w8,
                      Text('Logout', style: BS.med20.apply(color: BC.white)),
                    ],
                  )))
        ])
      ]),
    );
  }
}

class CustomSideBarItem {
  final String title;
  final SvgGenImage icon;

  CustomSideBarItem({required this.title, required this.icon});
}
