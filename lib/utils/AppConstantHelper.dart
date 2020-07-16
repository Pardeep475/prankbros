import 'dart:io';
import 'package:app_nigeria/models/home/LatLngModel.dart';
import 'package:app_nigeria/utils/Strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as vsc;
import 'package:permission_handler/permission_handler.dart';

class AppConstantHelper {
  BuildContext context;

  AppConstantHelper._internal();

  static final AppConstantHelper _singleton = AppConstantHelper._internal();

  factory AppConstantHelper() {
    return _singleton;
  }

  setContext(BuildContext context) {
    this.context = context;
  }

  void fetchUserCurrentLocation(
      {Function(LatLngModel,bool isLocationOn) getCurrentLocation}) async {
    vsc.Location location = new vsc.Location();
    bool _serviceEnabled = await location.serviceEnabled();
    print("Location---------1$_serviceEnabled");
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      print("Location---------2$_serviceEnabled");
      if (_serviceEnabled) {
        print("Location---------3$_serviceEnabled");
        final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
        geolocator
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
            .then((Position position) {
          getCurrentLocation.call(LatLngModel(lat: position.latitude, lng: position.longitude),true);
        });
      } else {
        print("Location---------4$_serviceEnabled");
        fetchUserCurrentLocation(getCurrentLocation: getCurrentLocation);
      }
    } else {
      print("Location---------5$_serviceEnabled");
      getPermissionStatus(getCurrentLocation);
    }
  }

  void getPermissionStatus(
    Function(LatLngModel,bool isLocationOn) getCurrentLocation,
  ) async {

    try{

      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.locationAlways,
        Permission.locationWhenInUse,
      ].request();
      PermissionStatus permission = statuses[Permission.location];
      if (permission == PermissionStatus.undetermined) {
        debugPrint('Permission status   :  undetermined');
        getCurrentLocation.call(LatLngModel(
            lat: double.parse(Strings.LAGOS_LATITUDE),
            lng: double.parse(Strings.LAGOS_LONGITUDE)),false);
      } else if (permission == PermissionStatus.granted) {
        debugPrint('Permission status   :  granted');
        final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
        geolocator
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
            .then((Position position) {
          getCurrentLocation
              .call(LatLngModel(lat: position.latitude, lng: position.longitude),true);
        });
      } else if (permission == PermissionStatus.denied) {
        debugPrint('Permission status   :  denied');
        getCurrentLocation.call(LatLngModel(
            lat: double.parse(Strings.LAGOS_LATITUDE),
            lng: double.parse(Strings.LAGOS_LONGITUDE)),false);
      } else if (permission == PermissionStatus.permanentlyDenied) {
        debugPrint('Permission status   :  permanentlyDenied');
        getCurrentLocation.call(LatLngModel(
            lat: double.parse(Strings.LAGOS_LATITUDE),
            lng: double.parse(Strings.LAGOS_LONGITUDE)),false);
      } else if (permission == PermissionStatus.restricted) {
        debugPrint('Permission status   :  restricted');
        getCurrentLocation.call(LatLngModel(
            lat: double.parse(Strings.LAGOS_LATITUDE),
            lng: double.parse(Strings.LAGOS_LONGITUDE)),false);
      }

    }catch(e){
      getCurrentLocation.call(LatLngModel(
          lat: double.parse(Strings.LAGOS_LATITUDE),
          lng: double.parse(Strings.LAGOS_LONGITUDE)),false);
    }
  }

  Future<bool> requestPermissionForStorageandCamera(bool isCamera) async {
    if (!isCamera) {
      print("Pickerrd1");
      Map<Permission, PermissionStatus> storageStatuses = await [
        Permission.storage,
      ].request().then((value) {
        if (value == PermissionStatus.granted) {
          print("Pickerrd");
        }
      });

      if (storageStatuses == PermissionStatus.denied ||
          storageStatuses == PermissionStatus.denied ||
          storageStatuses == PermissionStatus.restricted) {
        showAlert(true, "Nedd permissions");
      }
    } else {
      Map<Permission, PermissionStatus> cameraStatus = await [
        Permission.camera,
      ].request();

      if (cameraStatus == vsc.PermissionStatus.granted) {
        return true;
      }
      if (cameraStatus == PermissionStatus.denied ||
          cameraStatus == PermissionStatus.denied ||
          cameraStatus == PermissionStatus.restricted) {
        showAlert(true, "Nedd permissions");
      }
    }
  }

  File imageFile;

  Future<Null> pickImage({bool isCamera, Function(File) imagePicked}) async {
    imageFile = isCamera
        ? await ImagePicker.pickImage(
            source: ImageSource.camera,
          )
        : await ImagePicker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      print("imageFile>>${imageFile.path}");
      cropRectangleImage(false, imageFile).then((imgFile) async {
        if (imgFile != null) {
          if (imageFile == imgFile) {
          } else {
            //set & upload the image to server
            imagePicked(imageFile);
          }
        }
      });
    } else {
      showAlert(true, "Need Camera & Gellery Permission");
    }
  }

  Future<File> cropRectangleImage(
    bool isCircular,
    File imageFile,
  ) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      cropStyle: CropStyle.circle,
      aspectRatio: CropAspectRatio(
        ratioX: 1,
        ratioY: 1,
      ),
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          hideBottomControls: true,
          showCropGrid: false,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    );
    iosUiSettings:
    IOSUiSettings(
      rotateButtonsHidden: true,
      minimumAspectRatio: 1.0,
    );

    if (croppedFile != null) {
      imageFile = croppedFile;
    }
    return imageFile;
  }

  void showAlert(bool val, String text) {
    print(context);
    var alert = AlertDialog(
      title: Text("Error"),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      )),
      content: Stack(
        children: <Widget>[
          Container(
            child: Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
          ),
//          Positioned(
//              top: 0,
//              child: Image.asset(
//                Images.ICON_APP_NIGERIA,
//                height: 50,
//                width: 50,
//              ))
        ],
      ),
      actions: [
        new FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "OK",
              style: TextStyle(color: Colors.blue),
            ))
      ],
    );

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }
}
