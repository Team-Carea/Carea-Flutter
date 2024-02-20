import 'package:carea/app/common/component/toast_popup.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:location/location.dart';

Dio dio = Dio();
const accessToken =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA4NjE5OTU1LCJpYXQiOjE3MDg0NDcxNTUsImp0aSI6ImM5ZGQ0NjJiODcyOTQwMWRhODE3MjY3YzIxOWZkNjA4IiwidXNlcl9pZCI6Mn0.R2fMfKYULnTC1thLTTsJiI3ubvpu4IlOPfZA1maSxQs';

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
          'Authorization': 'Bearer $accessToken',
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
    careaToast(toastMsg: '오류가 발생했습니다');
  }
}

// 도움 요청 표시하기

Future<List<Map<String, dynamic>>> getHelpData() async {
  List<Map<String, dynamic>> places = [];
  const url = 'http://10.0.2.2:8000/helps/';
  try {
    var response = await dio.get(
      url,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    print(places);
    if (response.statusCode == 200) {
      var extracted = response.data['result'];
      for (var item in extracted) {
        places.add({
          'id': item['id'].toString(),
          'latitude': double.parse(item['latitude']),
          'longitude': double.parse(item['longitude'])
        });
      }
      print('Google 지도에 근처 도움 설정');
      print(places);
      return places;
    } else {
      print('서버 에러: 상태 코드 ${response.statusCode}');
      return places;
    }
  } catch (e) {
    print('데이터 전송 실패: $e');
    careaToast(toastMsg: '오류가 발생했습니다');

    return places;
  }
}

// 상세 도움 표시하기

Future<void> getHelpDataDetail(
  int id,
  Object user,
  String title,
  String content,
) async {
  var url = 'http://10.0.2.2:8000/helps/$id';
  try {
    var response = await dio.get(
      url,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      print("주위 도움 상세 정보 출력");
    }
  } catch (e) {
    print('Failed to send data: $e');
    careaToast(toastMsg: '오류가 발생했습니다');
  }
}
