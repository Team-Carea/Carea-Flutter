// nearhelp_screen -> 도움 올리기
// check_near_screen -> 올려진 도움 상세 정보

import 'package:carea/app/common/component/progress_bar.dart';
import 'package:carea/app/modules/nearhelp/controller/google_map_controller.dart';
import 'package:carea/app/common/const/app_colors.dart';
import 'package:flutter/material.dart';

class NearHelpCheck extends StatefulWidget {
  final int helpId;

  const NearHelpCheck({Key? key, required this.helpId}) : super(key: key);

  @override
  State<NearHelpCheck> createState() => _NearHelpCheckState();
}

class _NearHelpCheckState extends State<NearHelpCheck> {
  late Future<Map<String, dynamic>> _fetchHelpData;

  @override
  void initState() {
    super.initState();
    _fetchHelpData = getHelpDataDetail(widget.helpId);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: _fetchHelpData,
            builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final data = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: AppColors.darkGray,
                      radius: 50,
                      backgroundImage: NetworkImage(data['profileImageUrl']),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            data['nickname'],
                            style: const TextStyle(
                                fontSize: 20, color: AppColors.black),
                          ),
                        ),
                        const ExpBar(exp: 0.5),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                width: 350,
                                height: 30,
                                child: Text(
                                  data['title'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 350,
                              height: 300,
                              child: Text(
                                data['content'],
                                style: const TextStyle(
                                    fontSize: 16, color: AppColors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              width: 350,
                              height: 20,
                              child: Text(
                                ' ${data['location']}',
                                style: const TextStyle(
                                    fontSize: 16, color: AppColors.black),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: 350,
                              height: 20,
                              child: Text(
                                '올린 시간: ${data['createdAt']}',
                                style: const TextStyle(
                                    fontSize: 16, color: AppColors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // 채팅 기능 구현
                          },
                          child: const Text(
                            '채팅하기',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
