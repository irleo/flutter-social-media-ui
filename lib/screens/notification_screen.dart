import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom_info.dart' as notif;
import 'newsfeed_screen.dart';
import 'detail_screen.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  Map<String, dynamic>? findPostById(
    String? postId,
    List<Map<String, dynamic>> posts,
  ) {
    if (postId == null) return null;

    try {
      return posts.firstWhere((post) => post['postId'] == postId);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.only(top: ScreenUtil().setSp(8)),
      child: ListView.builder(
        itemCount: notifications.length * 2,
        itemBuilder: (context, index) {
          if (index.isEven) {
            final notifIndex = index ~/ 2;
            final notifData = notifications[notifIndex];

            return notif.CustomInformation(
              name: notifData['name'],
              post: notifData['post'],
              description: notifData['description'],
              notificationIcon: notifData['notificationIcon'],
              postId: notifData['postId'],
              onTap: () {
                final post = findPostById(notifData['postId'], posts);
                if (post == null) return;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailScreen(
                      userName: post['userName'],
                      postContent: post['postContent'],
                      date: post['date'],
                      numOfLikes: post['numOfLikes'],
                      isLiked: post['isLiked'] ?? false,
                      postImage: post['postImage'],
                      userAvatar: post['userAvatar'],
                      onLikePressed: () {},
                    ),
                  ),
                );
              },
            );
          }
          return const Divider(height: 10);
        },
      ),
    );
  }
}

final List<Map<String, dynamic>> notifications = [
  {
    'name': 'Higanbana',
    'post': 'posted a new photo: "GGEZ!"',
    'description': '1w',
    'notificationIcon': 'assets/images/higanbana.jpg',
    'postId': '3',
  },
  {
    'name': 'Yen Chan',
    'post': 'posted "#HappyAnniversary <33 kala mo talaga totoo,,"',
    'description': '1d',
    'notificationIcon': 'assets/images/yen_chan.jpg',
    'postId': '4',
  },
  {
    'name': 'iam seori', 
    'post': 'reacted to your post.', 
    'description': '11h', 
    'notificationIcon': 'assets/images/iam_seori.jpg',
    'postId': null,
  },
  {
    'name': 'Apple Vision',
    'post': 'posted a new reel: "An apple a day, keeps the doctor away."',
    'description': '1w',
    'notificationIcon': 'assets/images/apple_vision.jpg',
    'postId': null,
  },
  {
    'name': 'pongkan',
    'post': 'changed their profile picture.',
    'description': '4d',
    'notificationIcon': 'assets/images/pongkan.jpg',
    'postId': null,
  },
  {
    'name': 'DoubleA Ron',
    'post': 'shared a memory',
    'description': '12m',
    'notificationIcon': 'assets/images/doublea_ron.jpg',
    'postId': null,
  },
  {
    'name': 'Lizu Besu',
    'post':
        'posted a new photo: "nauna na ko magdagat, puro kayo drawing! 🌊☀️".',
    'description': '1d',
    'notificationIcon': 'assets/images/lizu_besu.jpg',
    'postId': '5',
  },
  {
    'name': 'Reo Kun', 
    'post': 'posted a new status: "kakaurat na talaga tong mga bwct na tao sa epbi na ginagawang source of information mga reels nilang kakahuyan yung background."', 
    'description': '2d', 
    'notificationIcon': 'assets/images/reo_kun.jpg',
    'postId': '7',
  },
  {
    'name': 'Lizu Besu',
    'post': 'mentioned you in a comment.',
    'description': '5m',
    'notificationIcon': 'assets/images/lizu_besu.jpg',
    'postId': null,
  },
  {
    'name': 'DoubleA Ron', 
    'post': 'posted a new photo: "Prepare muna bago pumasok. #FoodPrep".', 
    'description': '1d', 
    'notificationIcon': 'assets/images/doublea_ron.jpg',
    'postId': '6',
  },
  {
    'name': 'Dei Sy',
    'post': 'commented on your post.',
    'description': '1h',
    'notificationIcon': 'assets/images/dei_sy.jpg',
    'postId': null,
  },
  {
    'name': 'Reo Kun',
    'post': 'liked your photo.',
    'description': '2h',
    'notificationIcon': 'assets/images/reo_kun.jpg',
    'postId': '7',
  },
  {
    'name': 'iam seori',
    'post':
        'uploaded a new reel: "A little behind the scenes from yesterday’s concert <33".',
    'description': '4d',
    'notificationIcon': 'assets/images/iam_seori.jpg',
    'postId': null,
  },
  {
    'name': 'Je Sunie', 
    'post': 'posted a new photo: "eksena mga bading hahaha".', 
    'description': '3d', 
    'notificationIcon': 'assets/images/je_sunie.jpg',
    'postId': '9',
  },
  {
    'name': 'Kyoko Kirigiri',
    'post': 'posted a new photo.', 
    'description': '13h', 
    'notificationIcon': 'assets/images/kyoko_kirigiri.jpg',
    'postId': null,
  },
  {
    'name': 'Maro Sun',
    'post': 'posted a new story.',
    'description': '3h',
    'notificationIcon': null,
    'postId': null,
  },
  {
    'name': 'Auzu Tin',
    'post': 'uploaded a new video.',
    'description': '8h',
    'notificationIcon': null,
    'postId': null,
  },
  {
    'name': 'Jeru Winu',
    'post': 'mentioned you in a comment.',
    'description': '5h',
    'notificationIcon': null,
    'postId': null,
  },
];
