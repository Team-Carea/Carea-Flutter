import 'package:carea/app/common/const/app_colors.dart';
import 'package:carea/app/common/layout/default_layout.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:carea/app/modules/nearhelp/controller/google_maps_controller.dart';

class NearhelpScreen extends StatefulWidget {
  const NearhelpScreen({Key? key}) : super(key: key);

  @override
  State<NearhelpScreen> createState() => _NearhelpScreenState();
}

class _NearhelpScreenState extends State<NearhelpScreen> {
  late GoogleMapController mapController;
  late LocationService locationService;
  LatLng? userLocation;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _sendData() async {
    String title = _titleController.text;
    String content = _contentController.text;
    String address = _addressController.text;

    await sendData(title, content, address);
  }

  @override
  void initState() {
    super.initState();
    locationService = LocationService();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    var locationData = await locationService.getCurrentLocation();
    if (locationData != null) {
      setState(() {
        userLocation = LatLng(locationData.latitude!, locationData.longitude!);
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _addressController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('도움찾기'),
      ),
      body: DefaultLayout(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: userLocation ?? const LatLng(37.5465, 126.9648), // 기본 위치
            zoom: 17,
          ),
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true, //사용자 위치 중앙으로 가져오는 버튼
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        onPressed: () => _showAddHelpDialog(context),
        backgroundColor: AppColors.white,
        child: const Icon(
          Icons.add,
          color: AppColors.greenPrimaryColor,
        ),
      ),
    );
  }

  //도움 등록하기
  void _showAddHelpDialog(BuildContext context) {
    _titleController.clear();
    _contentController.clear();
    _addressController.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.clear),
                ),
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
                    style: TextStyle(fontSize: 20, color: AppColors.black),
                  ),
                ),
                SizedBox(
                  width: 350,
                  height: 450,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white,
                      border: Border.all(color: AppColors.lightGray),
                    ),
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: _titleController,
                          hintText: '제목을 작성해주세요.',
                        ),
                        _buildTextField(
                          controller: _addressController,
                          hintText: '주소를 선택해주세요.',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.map),
                            onPressed: () {},
                          ),
                        ),
                        Expanded(
                          child: _buildTextField(
                            controller: _contentController,
                            hintText: '내용을 작성해주세요.',
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
                      _sendData();
                    },
                    child: const Text('등록하기',
                        style: TextStyle(color: AppColors.black)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  //도움 등록 폼
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    Widget? suffixIcon,
  }) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.lightGray,
            width: 1.0,
          ),
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        style: const TextStyle(color: AppColors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 12,
            color: AppColors.lightGray,
            fontWeight: FontWeight.bold,
          ),
          border: InputBorder.none,
          suffixIcon: suffixIcon,
        ),
        maxLines: null,
      ),
    );
  }
}

// 추후 지도 배율에 따라서 floating button 색상 수정
