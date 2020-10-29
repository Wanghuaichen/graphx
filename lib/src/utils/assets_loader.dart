import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart';

import '../../graphx/textures/base_texture.dart';
import '../../graphx/utils/texture_utils.dart';

abstract class AssetLoader {
  static Future<GxTexture> loadImageTexture(
    String path, [
    double resolution,
  ]) async {
    final img = await loadImage(path);
    return GxTexture(img, null, false, resolution ?? TextureUtils.resolution);
  }

  /// load local assets.
  static Future<Image> loadImage(String path) async {
    final data = await rootBundle.load(path);
    final bytes = Uint8List.view(data.buffer);
    final codec = await instantiateImageCodec(bytes, allowUpscaling: false);
    return (await codec.getNextFrame()).image;
  }

  static Future<String> loadString(String path) async {
    return await rootBundle.loadString(path);
  }

  static Future<dynamic> loadJson(String path) async {
    final str = await loadString(path);
    return jsonDecode(str);
  }
}