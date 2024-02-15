import 'package:grade_project_1765532/src/style/color/palette.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<String?> getImage() async {
  try {
    final ImagePicker imgPicker = ImagePicker();

    final XFile? img = await imgPicker.pickImage(source: ImageSource.gallery);

    if (img != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: img.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 50,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Recortar',
              toolbarColor: ColorPalette.lightBg,
              toolbarWidgetColor: ColorPalette.textColor,
              backgroundColor: ColorPalette.background,
              cropFrameColor: ColorPalette.primary,
              initAspectRatio: CropAspectRatioPreset.ratio3x2,
              lockAspectRatio: true,
              hideBottomControls: true,
              showCropGrid: false),
        ],
      );
      if (croppedFile != null) {
        return croppedFile.path;
      }
    }
    return '';
  } catch (e) {
    return '';
  }
}
