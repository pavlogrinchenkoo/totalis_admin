/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_logo.png
  AssetGenImage get appLogo =>
      const AssetGenImage('assets/images/app_logo.png');

  /// File path: assets/images/paint.png
  AssetGenImage get paint => const AssetGenImage('assets/images/paint.png');

  /// List of all assets
  List<AssetGenImage> get values => [appLogo, paint];
}

class Assets {
  Assets._();

  static const SvgGenImage admins = SvgGenImage('assets/admins.svg');
  static const SvgGenImage category = SvgGenImage('assets/category.svg');
  static const SvgGenImage checkIns = SvgGenImage('assets/check_ins.svg');
  static const SvgGenImage chevronBottom =
      SvgGenImage('assets/chevron_bottom.svg');
  static const SvgGenImage chevronRight =
      SvgGenImage('assets/chevron_right.svg');
  static const SvgGenImage chevronTop = SvgGenImage('assets/chevron_top.svg');
  static const SvgGenImage coaches = SvgGenImage('assets/coaches.svg');
  static const SvgGenImage fd = SvgGenImage('assets/fd.svg');
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const SvgGenImage messages = SvgGenImage('assets/messages.svg');
  static const SvgGenImage onCompress = SvgGenImage('assets/onCompress.svg');
  static const SvgGenImage onExpand = SvgGenImage('assets/onExpand.svg');
  static const SvgGenImage open = SvgGenImage('assets/open.svg');
  static const SvgGenImage points = SvgGenImage('assets/points.svg');
  static const SvgGenImage rec = SvgGenImage('assets/rec.svg');
  static const SvgGenImage send = SvgGenImage('assets/send.svg');
  static const SvgGenImage share = SvgGenImage('assets/share.svg');
  static const SvgGenImage userCategory =
      SvgGenImage('assets/user_category.svg');
  static const SvgGenImage users = SvgGenImage('assets/users.svg');
  static const SvgGenImage variables = SvgGenImage('assets/variables.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        admins,
        category,
        checkIns,
        chevronBottom,
        chevronRight,
        chevronTop,
        coaches,
        fd,
        messages,
        onCompress,
        onExpand,
        open,
        points,
        rec,
        send,
        share,
        userCategory,
        users,
        variables
      ];
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
