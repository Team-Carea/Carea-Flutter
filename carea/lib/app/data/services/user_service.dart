import 'package:carea/app/common/const/config.dart';
import 'package:carea/app/common/util/auth_storage.dart';
import 'package:carea/app/data/models/user_model.dart';
import 'package:dio/dio.dart';

class UserService {
  final Dio dio = Dio();

  // POST: 회원가입
  Future<SignUpResult> signUp(User user) async {
    const url = 'http://${AppConfig.localHost}/${AppConfig.signUpUrl}/';
    final data = user.toJson();

    print(data);

    try {
      final response = await dio.post(url, data: data);

      print(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('회원가입 성공: ${response.data}');
        return SignUpResult.fromJson(response.data);
      } else {
        throw Exception('Failed to signup: ${response.data}');
      }
    } catch (e) {
      throw Exception('Failed to signup: $e');
    }
  }

  // GET: 내 프로필 조회
  Future<UserProfile> getUserProfile(String accessToken) async {
    final accessToken = await AuthStorage.getAccessToken();
    const url = 'http://${AppConfig.localHost}/${AppConfig.profileUrl}/';
    dio.options.headers['Authorization'] = accessToken;

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        print('프로필 조회 성공');
        return UserProfile.fromJson(response.data);
      } else {
        throw Exception('Failed to load profile: ${response.data}');
      }
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }
}
