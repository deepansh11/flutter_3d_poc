import 'package:flutter_scene_importer/build_hooks.dart';
import 'package:native_assets_cli/native_assets_cli.dart';

void main(List<String> args) {
  build(args, (buildConfig, buildOutpu) async {
    buildModels(
      buildConfig: buildConfig,
      inputFilePaths: [
        'assets/models/flutter_logo_baked.glb',
      ],
    );
  });
}
