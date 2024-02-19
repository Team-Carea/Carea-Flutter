import 'package:carea/app/common/const/app_colors.dart';
import 'package:carea/app/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatefulWidget {
  final String pageTitle;
  const CreatePostScreen({Key? key, this.pageTitle = ''}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    String? currentRoute = ModalRoute.of(context)!.settings.name;
    switch (currentRoute) {
      case '/posts/economic':
        _selectedCategory = '경제/금융';
        break;
      case '/posts/future':
        _selectedCategory = '진로';
        break;
      case '/posts/life':
        _selectedCategory = '생활';
        break;
      case '/posts/free':
        _selectedCategory = '자유';
        break;
    }
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.clear, color: Colors.black),
          ),
          title: const Text(
            '새 게시글 작성',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.check, color: Colors.black),
            )
          ],
          centerTitle: true,
          elevation: 0,
        ),
        body: DefaultLayout(
          child: Center(
            child: Form(
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      DropdownButton<String>(
                        underline: Container(
                          height: 0.5,
                          color: AppColors.lightGray,
                        ),
                        value: _selectedCategory,
                        items: const [
                          DropdownMenuItem<String>(
                            value: '경제/금융',
                            child: Text('경제/금융'),
                          ),
                          DropdownMenuItem<String>(
                            value: '진로',
                            child: Text('진로'),
                          ),
                          DropdownMenuItem<String>(
                            value: '생활',
                            child: Text('생활'),
                          ),
                          DropdownMenuItem<String>(
                            value: '자유 게시판',
                            child: Text('자유 게시판'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        hint: const Text('카테고리'),
                      ),
                    ],
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 350,
                          child: TextField(
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: '제목',
                              hintStyle: const TextStyle(
                                fontSize: 18,
                                color: AppColors.extraLightGray,
                                fontWeight: FontWeight.bold,
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.greenPrimaryColor,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[400]!,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: 350,
                          height: 550,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.grey[400]!, width: 1.0),
                            ),
                            child: const TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintText: '내용을 작성해주세요.',
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.extraLightGray,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(16.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            IconButton(
                              onPressed: () async {
                                var picker = ImagePicker();
                                var image = await picker.pickImage(
                                    source: ImageSource.gallery);
                              },
                              icon: const Icon(
                                Icons.add_a_photo_outlined,
                                color: AppColors.lightGray,
                              ),
                            ),
                          ],
                        ),
                      ]),
                ],
              ),
            ),
          ),
        ));
  }
}