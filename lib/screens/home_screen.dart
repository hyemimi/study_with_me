import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:study_with_me/components/home_appbar.dart';
import 'package:study_with_me/components/home_banner.dart';
import 'package:study_with_me/provider/user_provider.dart';
import 'package:study_with_me/screens/add_screen.dart';
import 'package:study_with_me/screens/detail_screen.dart';

// 홈 화면. 로그인 후 넘어온 email을 기반으로, 유저의 스터디 리스트를 fetch해옴.
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 프로바이더 인스턴스 생성
  late UserProvider _userProvider =
      Provider.of<UserProvider>(context); // 프로바이더 사용

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Study With Me'),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          SizedBox(
            width: 40,
            height: 40,
            child: CircleAvatar(
                backgroundImage: NetworkImage(_userProvider.route)),
          ),
          SizedBox(width: 10),
          Text(_userProvider.name),
          SizedBox(width: 10),
        ]), // 프로필
        SizedBox(height: 10),
        HomeBanner(),
        SizedBox(height: 10),
        Expanded(
            child: (GridView.builder(
          shrinkWrap: true,
          itemCount: 30,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
            childAspectRatio: 1 / 1,
            mainAxisSpacing: 10, //수평 Padding
            crossAxisSpacing: 10, //수직 Padding
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Container(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Column(
                    children: [Text('알고리즘 스터디')],
                  ),
                ));
          },
        )))
      ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddScreen(),
                    fullscreenDialog: true,
                  ),
                )
              }
          // 홈 화면 갈 때 email, image route 보내야함
          ,
          foregroundColor: Colors.black,
          backgroundColor: Theme.of(context).colorScheme.onTertiary,
          child: Icon(Icons.add),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
    );
  }
}
