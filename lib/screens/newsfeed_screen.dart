import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/post_card.dart';
import '../session/session.dart';

class NewsFeedScreen extends StatelessWidget {
  final List<Map<String, dynamic>> posts;
  const NewsFeedScreen({super.key, this.posts = const []});

  static const int adBlocksToShow = 4;
  static const int postsPerAd = 2;
  
  @override
  Widget build(BuildContext context) {
    final int maxPossibleBlocks =
        posts.length ~/ postsPerAd; // after every 2 posts
    final int blocks = adBlocksToShow.clamp(0, maxPossibleBlocks);

    final int totalItems = posts.length + blocks;

    return ListView.builder(
      itemCount: totalItems,
      itemBuilder: (context, index) {
        final int cycleLen = postsPerAd + 1; 
        final bool isAdSlot =
            (index + 1) % cycleLen == 0 && (index ~/ cycleLen) < blocks;

        if (isAdSlot) {
          return _adCarouselBlock();
        }

        // Feed index
        final int adsBefore = (index ~/ 2).clamp(0, blocks);
        final int postIndex = index - adsBefore;
        final post = posts[postIndex];

        return PostCard(
          postId: post['postId'],
          userName: post['userName'],
          postContent: post['postContent'],
          numOfLikes: post['numOfLikes'],
          isLiked: false,
          date: post['date'],
          userAvatar: post['userAvatar'],
          postImage: post['postImage'],
        );
      },
    );
  }

  Widget _adCarouselBlock() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "Advertisement / Promotion",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(height: 8),

          CarouselSlider(
            options: CarouselOptions(
              height: 420,
              viewportFraction: 0.93,
              enlargeCenterPage: false,
              enableInfiniteScroll: true,
              pageSnapping: true,
              scrollPhysics: const ClampingScrollPhysics(),
            ),
            items: adPosts.map((ad) {
              return PostCard(
                postId: ad['postId'],
                userName: ad['userName'],
                postContent: ad['postContent'],
                numOfLikes: 0,
                isLiked: false,
                date: ad['date'],
                userAvatar: ad['userAvatar'],
                postImage: ad['postImage'],

                isAds: true,
                adsMarket: ad['adsMarket'],

                cardMargin: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 6,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

final user = Session.currentUser ?? Session.demoUser;
final fullName = '${user.firstName} ${user.lastName}'.trim();
final List<Map<String, dynamic>> posts = [
  {
    'postId': '1',
    'userName': fullName,
    'postContent': '#FlutterIsAwesome lol',
    'numOfLikes': 167,
    'date': 'November 30',
    'userAvatar': 'assets/images/leomar.jpg',
    'postImage': 'assets/images/post1.png',
  },
  {
    'postId': '2',
    'userName': fullName,
    'postContent': 'namamasko po, kahit kwatro lang sa grade <3',
    'numOfLikes': 50,
    'date': 'December 12',
    'userAvatar': 'assets/images/leomar.jpg',
    'postImage': null,
  },
  {
    'postId': '3',
    'userName': 'Higanbana',
    'postContent': 'GGEZ!',
    'numOfLikes': 43,
    'date': 'November 29 at 9:15 PM',
    'userAvatar': 'assets/images/higanbana.jpg',
    'postImage': 'assets/images/post2.png',
  },
  {
    'postId': '4',
    'userName': 'Yen Chan',
    'postContent': '#HappyAnniversary <33 kala mo talaga totoo,,',
    'numOfLikes': 23,
    'date': 'December 3',
    'userAvatar': 'assets/images/yen_chan.jpg',
    'postImage': null,
  },
  {
    'postId': '5',
    'userName': 'Lizu Besu',
    'postContent': 'nauna na ko magdagat, puro kayo drawing! 🌊☀️',
    'numOfLikes': 45,
    'date': 'December 3',
    'userAvatar': 'assets/images/lizu_besu.jpg',
    'postImage': 'assets/images/post4.jpg',
  },
  {
    'postId': '6',
    'userName': 'DoubleA Ron',
    'postContent': 'Prepare muna bago pumasok. #FoodPrep',
    'numOfLikes': 32,
    'date': 'December 2',
    'userAvatar': 'assets/images/doublea_ron.jpg',
    'postImage': 'assets/images/post5.jpg',
  },
  {
    'postId': '7',
    'userName': 'Reo Kun',
    'postContent':
        'kakaurat na talaga tong mga bwct na tao sa epbi na ginagawang source of information mga reels nilang kakahuyan yung background.',
    'numOfLikes': 67,
    'date': 'December 1',
    'userAvatar': 'assets/images/reo_kun.jpg',
    'postImage': null,
  },
  {
    'postId': '8',
    'userName': 'iam seori',
    'postContent': 'thanks for listening to my music 🎵, iloveyou all!! #백소현',
    'numOfLikes': 89,
    'date': 'November 30',
    'userAvatar': 'assets/images/iam_seori.jpg',
    'postImage': 'assets/images/post6.jpg',
  },
  {
    'postId': '9',
    'userName': 'Je Sunie',
    'postContent': 'eksena mga bading hahaha',
    'numOfLikes': 54,
    'date': 'December 5',
    'userAvatar': 'assets/images/je_sunie.jpg',
    'postImage': 'assets/images/post7.jpg',
  },
];

final List<Map<String, dynamic>> adPosts = [
  {
    'postId': 'ad_1',
    'userName': 'pongkan',
    'postContent': 'Get foodborned diseases updates near you.',
    'numOfLikes': 0,
    'date': 'Sponsored',
    'userAvatar': 'assets/images/pongkan.jpg',
    'postImage': 'assets/images/foodsafe_manila.png',
    'isAds': true,
    'adsMarket': 'Free alerts • Local updates',
  },
  {
    'postId': 'ad_2',
    'userName': fullName,
    'postContent': '#FlutterIsAwesome lol',
    'numOfLikes': 167,
    'date': 'November 30',
    'userAvatar': 'assets/images/leomar.jpg',
    'postImage': 'assets/images/post1.png',
    'isAds': true,
    'adsMarket': 'Free alerts • Local updates',
  },
  {
    'postId': 'ad_3',
    'userName': 'Higanbana',
    'postContent': 'GGEZ!',
    'numOfLikes': 43,
    'date': 'November 29 at 9:15 PM',
    'userAvatar': 'assets/images/higanbana.jpg',
    'postImage': 'assets/images/post2.png',
    'isAds': true,
    'adsMarket': 'It\'s play time!',
  },
  {
    'postId': 'ad_4',
    'userName': 'Lizu Besu',
    'postContent': 'nauna na ko magdagat, puro kayo drawing! 🌊☀️',
    'numOfLikes': 45,
    'date': 'December 3',
    'userAvatar': 'assets/images/lizu_besu.jpg',
    'postImage': 'assets/images/post4.jpg',
    'isAds': true,
    'adsMarket': 'Kulayan ang drawing',
  },
  {
    'postId': 'ad_6',
    'userName': 'DoubleA Ron',
    'postContent': 'Prepare muna bago pumasok. #FoodPrep',
    'numOfLikes': 32,
    'date': 'December 2',
    'userAvatar': 'assets/images/doublea_ron.jpg',
    'postImage': 'assets/images/post5.jpg',
    'isAds': true,
    'adsMarket': 'Time to go to gym!',
  },
  {
    'postId': 'ad_7',
    'userName': 'iam seori',
    'postContent': 'thanks for listening to my music 🎵, iloveyou all!! #백소현',
    'numOfLikes': 89,
    'date': 'November 30',
    'userAvatar': 'assets/images/iam_seori.jpg',
    'postImage': 'assets/images/post6.jpg',
    'isAds': true,
    'adsMarket': 'I love Seori <3',
  },
];
