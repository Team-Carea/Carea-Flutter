import 'package:carea/app/common/const/app_colors.dart';
import 'package:carea/app/modules/chat/view/chat_list_screen.dart';
import 'package:carea/app/modules/community/view/community_screen.dart';
import 'package:carea/app/modules/nearhelp/view/nearhelp_screen.dart';
import 'package:flutter/material.dart';

enum TabItem { community, chat, nearHelp }

class RootTab extends StatefulWidget {
  final TabItem initialTab;

  static String get routeName => '/community';

  const RootTab({
    Key? key,
    this.initialTab = TabItem.community,
  }) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      initialIndex: widget.initialTab.index,
      vsync: this,
    );
    _tabController.addListener(_handleTabSelection); // 탭 변경을 감지하기 위해 리스너 추가
  }

  void _handleTabSelection() {
    if (!_tabController.indexIsChanging) {
      setState(() {}); // 탭이 변경될 때마다 UI 갱신
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          CommunityScreen(),
          ChatlistScreen(),
          NearhelpScreen(),
        ],
      ),
      bottomNavigationBar: SizedBox(
        child: BottomNavigationBar(
          selectedItemColor: AppColors.greenPrimaryColor,
          unselectedItemColor: AppColors.middleGray,
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex: _tabController.index,
          onTap: _onTabTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.pending_outlined),
              label: '커뮤니티',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              label: '대화 목록',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              label: '도움 찾기',
            ),
          ],
        ),
      ),
    );
  }

  void _onTabTapped(int index) {
    _tabController.animateTo(index); // 탭이 클릭되면 해당 인덱스로 애니메이션 처리
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
