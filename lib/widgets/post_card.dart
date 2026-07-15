import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import '../screens/detail_screen.dart';
import 'comment_widget.dart';
import 'custom_font.dart';
import 'like_widget.dart';
import 'share_widget.dart';

class PostCard extends StatefulWidget {
  final String postId;
  final String userName;
  final String postContent;
  final String date;
  final int numOfLikes;
  final bool isLiked;
  final String? postImage;
  final String? userAvatar;
  final bool isAds;
  final String? adsMarket;
  final EdgeInsetsGeometry? cardMargin;

  const PostCard({
    super.key,
    required this.postId,
    required this.userName,
    required this.postContent,
    required this.numOfLikes,
    required this.isLiked,
    required this.date,
    this.postImage,
    this.userAvatar,
    this.isAds = false,
    this.adsMarket,
    this.cardMargin,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late int likes;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    likes = widget.numOfLikes;
    isLiked = widget.isLiked;
  }

  void _toggleLike() {
    setState(() {
      if (isLiked) {
        likes--;
        isLiked = false;
      } else {
        likes++;
        isLiked = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry cardMargin =
        widget.cardMargin ?? EdgeInsets.all(ScreenUtil().setSp(10));

    return Card(
      margin: cardMargin,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailScreen(
                userName: widget.userName,
                postContent: widget.postContent,
                date: widget.date,
                numOfLikes: likes,
                isLiked: isLiked,
                onLikePressed: _toggleLike,
                postImage: widget.postImage,
                userAvatar: widget.userAvatar,
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(ScreenUtil().setSp(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widget.userAvatar != null
                      ? CircleAvatar(
                          radius: ScreenUtil().setSp(20),
                          backgroundImage: AssetImage(widget.userAvatar!),
                        )
                      : const CircleAvatar(
                          radius: 20,
                          child: Icon(Icons.person),
                        ),
                  SizedBox(width: ScreenUtil().setWidth(10)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFont(
                        text: widget.userName,
                        fontSize: ScreenUtil().setSp(15),
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomFont(
                            text: '${widget.date} ·',
                            fontSize: ScreenUtil().setSp(12),
                            color: Colors.grey,
                          ),
                          SizedBox(width: ScreenUtil().setWidth(3)),
                          Icon(
                            Icons.public,
                            color: Colors.grey,
                            size: ScreenUtil().setSp(15),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.more_horiz),
                ],
              ),
              // ADS Header
              if (widget.isAds) ...[
                SizedBox(height: ScreenUtil().setHeight(6)),
                CustomFont(
                  text: "Advertisement / Promotion",
                  fontSize: ScreenUtil().setSp(12),
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]!,
                ),
              ],

              SizedBox(height: ScreenUtil().setHeight(5)),

              // Post Content
              CustomFont(
                text: widget.postContent,
                fontSize: ScreenUtil().setSp(12),
                color: Colors.black,
                maxLines: widget.isAds ? 2 : null,
                overflow: widget.isAds ? TextOverflow.ellipsis : null,
              ),

              SizedBox(height: ScreenUtil().setHeight(5)),

              // Post Image
              widget.postImage != null
                  ? Image.asset(
                      widget.postImage!,
                      width: double.infinity,
                      height: widget.isAds
                          ? ScreenUtil().setHeight(155)
                          : ScreenUtil().setHeight(200),
                      fit: BoxFit.cover,
                    )
                  : const SizedBox.shrink(),

              SizedBox(height: ScreenUtil().setHeight(8)),

              if (!widget.isAds) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LikeWidget(
                      numOfLikes: likes,
                      onPressed: _toggleLike,
                      isLiked: isLiked,
                    ),
                    const CommentWidget(),
                    const ShareWidget(),
                  ],
                ),

                Row(
                  children: [
                    CircleAvatar(
                      radius: ScreenUtil().setSp(15),
                      backgroundImage: AssetImage(COMMENT_AVATAR),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                        ScreenUtil().setSp(10),
                        0,
                        0,
                        0,
                      ),
                      alignment: Alignment.centerLeft,
                      height: ScreenUtil().setHeight(25),
                      width: ScreenUtil().setWidth(330),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(
                          Radius.circular(ScreenUtil().setSp(10)),
                        ),
                      ),
                      child: CustomFont(
                        text: 'Write a comment...',
                        fontSize: ScreenUtil().setSp(11),
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: ScreenUtil().setHeight(10)),

                Padding(
                  padding: EdgeInsets.only(left: ScreenUtil().setSp(5)),
                  child: CustomFont(
                    text: 'View comments',
                    fontSize: ScreenUtil().setSp(12),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ] else ...[
                Divider(color: Colors.grey[300]),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(10),
                    vertical: ScreenUtil().setHeight(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "MORE DETAILS",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(20),
                                fontWeight: FontWeight.bold,
                                color: FB_DARK_PRIMARY,
                              ),
                            ),
                          ),

                          // Arrow button
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailScreen(
                                    userName: widget.userName,
                                    postContent: widget.postContent,
                                    date: widget.date,
                                    numOfLikes: likes,
                                    isLiked: isLiked,
                                    onLikePressed: _toggleLike,
                                    postImage: widget.postImage,
                                    userAvatar: widget.userAvatar,
                                  ),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(999),
                            child: Container(
                              padding: EdgeInsets.all(ScreenUtil().setSp(6)),
                              decoration: BoxDecoration(
                                color: FB_PRIMARY.withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.chevron_right_rounded,
                                size: ScreenUtil().setSp(18),
                                color: FB_DARK_PRIMARY,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // adsMarket caption
                      if (widget.adsMarket != null)
                        Text(
                          widget.adsMarket!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(12),
                            color: Colors.grey[700],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
