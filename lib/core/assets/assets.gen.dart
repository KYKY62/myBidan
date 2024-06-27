/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/carFloating.png
  AssetGenImage get carFloating =>
      const AssetGenImage('assets/icons/carFloating.png');

  /// File path: assets/icons/cart.png
  AssetGenImage get cart => const AssetGenImage('assets/icons/cart.png');

  /// File path: assets/icons/chat.png
  AssetGenImage get chat => const AssetGenImage('assets/icons/chat.png');

  /// File path: assets/icons/date.png
  AssetGenImage get date => const AssetGenImage('assets/icons/date.png');

  /// File path: assets/icons/education.png
  AssetGenImage get education =>
      const AssetGenImage('assets/icons/education.png');

  /// File path: assets/icons/help.png
  AssetGenImage get help => const AssetGenImage('assets/icons/help.png');

  /// File path: assets/icons/home.png
  AssetGenImage get home => const AssetGenImage('assets/icons/home.png');

  /// File path: assets/icons/infoAccount.png
  AssetGenImage get infoAccount =>
      const AssetGenImage('assets/icons/infoAccount.png');

  /// File path: assets/icons/logout.png
  AssetGenImage get logout => const AssetGenImage('assets/icons/logout.png');

  /// File path: assets/icons/map.png
  AssetGenImage get map => const AssetGenImage('assets/icons/map.png');

  /// File path: assets/icons/mapInactive.png
  AssetGenImage get mapInactive =>
      const AssetGenImage('assets/icons/mapInactive.png');

  /// File path: assets/icons/private.png
  AssetGenImage get private => const AssetGenImage('assets/icons/private.png');

  /// File path: assets/icons/terms.png
  AssetGenImage get terms => const AssetGenImage('assets/icons/terms.png');

  /// File path: assets/icons/time.png
  AssetGenImage get time => const AssetGenImage('assets/icons/time.png');

  /// File path: assets/icons/user.png
  AssetGenImage get user => const AssetGenImage('assets/icons/user.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        carFloating,
        cart,
        chat,
        date,
        education,
        help,
        home,
        infoAccount,
        logout,
        map,
        mapInactive,
        private,
        terms,
        time,
        user
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Background_home.png
  AssetGenImage get backgroundHome =>
      const AssetGenImage('assets/images/Background_home.png');

  /// File path: assets/images/Map_Pattern.png
  AssetGenImage get mapPattern =>
      const AssetGenImage('assets/images/Map_Pattern.png');

  /// File path: assets/images/bidan.png
  AssetGenImage get bidan => const AssetGenImage('assets/images/bidan.png');

  /// File path: assets/images/circle_bg.png
  AssetGenImage get circleBg =>
      const AssetGenImage('assets/images/circle_bg.png');

  /// File path: assets/images/doctor.png
  AssetGenImage get doctor => const AssetGenImage('assets/images/doctor.png');

  /// File path: assets/images/ibu_hamil.png
  AssetGenImage get ibuHamil =>
      const AssetGenImage('assets/images/ibu_hamil.png');

  /// File path: assets/images/praktik.png
  AssetGenImage get praktik => const AssetGenImage('assets/images/praktik.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [backgroundHome, mapPattern, bidan, circleBg, doctor, ibuHamil, praktik];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size = null});

  final String _assetName;

  final Size? size;

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
