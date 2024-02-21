import 'package:carea/app/common/component/progress_bar.dart';
import 'package:carea/app/modules/nearhelp/controller/google_map_controller.dart';
import 'package:carea/app/common/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class NearHelpCheck extends StatefulWidget {
  final int markerId;

  const NearHelpCheck({Key? key, required this.markerId}) : super(key: key);

  @override
  State<NearHelpCheck> createState() => _NearHelpCheckState();
}

class _NearHelpCheckState extends State<NearHelpCheck> {
  late Future<Map<String, dynamic>> _fetchHelpData;

  @override
  void initState() {
    super.initState();
    _fetchHelpData = getHelpDataDetail(widget.markerId);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      backgroundColor: AppColors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                        color: AppColors.darkGray,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: AppColors.lightGray,
                      radius: 48,
                      backgroundImage: NetworkImage(data['profileImageUrl']),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${data['nickname']}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const ExpBar(exp: 0.5),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        '${data['title']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      '${data['content']}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${data['location']}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.black,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${data['createdAt']}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.greenPrimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                      ),
                      child: const Text(
                        '채팅하기',
                        style: TextStyle(fontSize: 16, color: AppColors.black),
                      ),
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
