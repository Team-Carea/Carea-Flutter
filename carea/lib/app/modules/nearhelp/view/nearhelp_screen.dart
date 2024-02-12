import 'package:carea/app/common/const/app_colors.dart';
import 'package:carea/app/common/layout/default_layout.dart';
import 'package:carea/app/modules/nearhelp/view/check_near_screen.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class NearhelpScreen extends StatefulWidget {
  const NearhelpScreen({super.key});

  @override
  State<NearhelpScreen> createState() => _NearhelpScreenState();
}

class _NearhelpScreenState extends State<NearhelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('도움찾기'),
      ),
      body: const DefaultLayout(
        child: GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(31.4354354, 27.4534565)),
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true, //사용자 위치 중앙으로 가져오는 버튼
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: AlertDialog(
                  title: Row(
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.clear)),
                      const SizedBox(
                        width: 25,
                      ),
                      const Text(
                        "새 도움 추가하기",
                        style: TextStyle(fontSize: 20, color: AppColors.black),
                      ),
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColors.darkGray,
                        radius: 50.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          "캐리아유저 1",
                          style:
                              TextStyle(fontSize: 20, color: AppColors.black),
                        ),
                      ),
                      SizedBox(
                        width: 350,
                        height: 400,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.white,
                            border: Border.all(color: AppColors.lightGray),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: AppColors.lightGray,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: const TextField(
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(color: AppColors.black),
                                  decoration: InputDecoration(
                                    hintText: '제목을 작성해주세요.',
                                    hintStyle: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.lightGray,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const TextField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    textInputAction: TextInputAction.done,
                                    style: TextStyle(color: AppColors.black),
                                    decoration: InputDecoration(
                                      hintText: '내용을 작성해주세요.',
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.lightGray,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // 도움 등록 API 전에 UI 확인을 위해 임시적으로 도움찾기 확인하는 UI 연결!!
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const NearHelpCheck();
                              },
                            );
                          },
                          child: const Text('등록하기',
                              selectionColor: AppColors.greenPrimaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: AppColors.white,
        child: const Icon(
          Icons.add,
          color: AppColors.greenPrimaryColor,
        ),
      ),
    );
  }
}

// 추후 지도 배율에 따라서 floating button 색상 수정
