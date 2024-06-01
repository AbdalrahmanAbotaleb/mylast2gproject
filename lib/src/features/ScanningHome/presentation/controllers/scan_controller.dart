import 'dart:convert';
import 'dart:io';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanController extends GetxController {
  var _loading = true.obs;
  var _image = Rx<File?>(null);
  var _diagnosisList = <Map<String, dynamic>>[].obs;
  final picker = ImagePicker();
  bool _isImagePickerActive = false; // Add this variable to track if the image picker is active

  bool get loading => _loading.value;
  File? get image => _image.value;
  List<Map<String, dynamic>> get diagnosisList => _diagnosisList;


  @override
  void onInit() {
    super.onInit();
    loadModel();
    loadPageData();
  }

  Future<void> loadPageData() async {
    await loadModel();
    await loadDiagnosisList();
    await loadDisplayedImage();
  }

  Future<void> loadModel() async {
    Tflite.close();
    await Tflite.loadModel(
      model: 'assets/models/model_unquant.tflite',
      labels: 'assets/models/labels.txt',
    );
  }

  Future<void> detectImage(XFile image) async {
    var prediction = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    _loading.value = false;
    if (image != null) {
      _image.value = File(image.path);
      _diagnosisList.add({
        'image': _image.value,
        'disease': prediction![0]['label'].toString().substring(0),
      });
      await saveDiagnosisList();
      await saveDisplayedImage();
    } else {
      print('No image selected.');
    }
  }

  Future<void> loadImageGallery() async {
    if (_isImagePickerActive) return; // Check if the image picker is already active
    _isImagePickerActive = true; // Set image picker as active
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    _isImagePickerActive = false; // Reset image picker status after picking
    if (image != null) {
      await detectImage(image);
    }
  }

  Future<void> loadImageCamera() async {
    if (_isImagePickerActive) return; // Check if the image picker is already active
    _isImagePickerActive = true; // Set image picker as active
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    _isImagePickerActive = false; // Reset image picker status after picking
    if (image != null) {
      await detectImage(image);
    }
  }

  Future<void> saveDiagnosisList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> encodedList = _diagnosisList.map((e) {
      return jsonEncode({
        'imagePath': e['image'].path,
        'disease': e['disease'],
      });
    }).toList();
    await prefs.setStringList('diagnosisList', encodedList);
  }

  Future<void> loadDiagnosisList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? encodedList = prefs.getStringList('diagnosisList');
    if (encodedList != null) {
      _diagnosisList.value = encodedList.map((e) {
        Map<String, dynamic> decoded = jsonDecode(e);
        return {
          'image': File(decoded['imagePath']),
          'disease': decoded['disease'],
        };
      }).toList();
    }
  }

  Future<void> saveDisplayedImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_image.value != null)
    {
      await prefs.setString('displayedImagePath', _image.value!.path);
    }
  }

  Future<void> loadDisplayedImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? displayedImagePath = prefs.getString('displayedImagePath');
    if (displayedImagePath != null) {
      _image.value = File(displayedImagePath);
    }
  }

  void removeDiagnosis(int index) {
    _diagnosisList.removeAt(index);
    saveDiagnosisList();
  }
}
