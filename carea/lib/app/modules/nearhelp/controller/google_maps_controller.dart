import 'package:carea/app/common/component/toast_popup.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:location/location.dart';

Dio dio = Dio();

class LocationService {
  Location location = Location();

  Future<LocationData?> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionStatus;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }
}

// 도움 등록하기

Future<void> sendData(String title, String content, String address) async {
  var url = 'http://10.0.2.2:8000/helps/';
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      data: json.encode({
        'title': title,
        'content': content,
        'address': address,
      }),
    );

    if (response.statusCode == 200) {
      careaToast(toastMsg: '도움이 성공적으로 등록되었습니다.');
    }
  } catch (e) {
    print('Failed to send data: $e');
  }
}
