import 'dart:io';
import 'package:camera/camera.dart';

extension OptionalXFileToFile on XFile? {
  File? get file => File(this!.path);
}
