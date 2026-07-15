import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/comment_widget.dart';
import '../widgets/custom_font.dart';
import '../widgets/like_widget.dart';
import '../widgets/share_widget.dart';

class DetailScreen extends StatefulWidget {
  final String userName;
  final String postContent;
  final String date;
  final int numOfLikes;
  final bool isLiked;
  final VoidCallback onLikePressed;
  final String? postImage;
  final String? userAvatar;

  const DetailScreen({
    super.key,
    required this.userName,
    required this.postContent,
    required this.numOfLikes,
    required this.isLiked,
    required this.onLikePressed,
    required this.date,
    this.postImage,
    this.userAvatar,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}
  
  class _DetailScreenState extends State<DetailScreen> {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomFont(
          text: widget.userName,
          fontSize: ScreenUtil().setSp(20),
          color: Colors.black,
        ),
      ),

      body: Container(
        color: Colors.white,
        height: ScreenUtil().screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (widget.postImage != null && widget.postImage!.isNotEmpty)
                Image.asset(
                  widget.postImage!,
                  width: double.infinity,
                  height: ScreenUtil().setHeight(300),
                  fit: BoxFit.cover,
                ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    widget.userAvatar != null && widget.userAvatar!.isNotEmpty
                        ? CircleAvatar(
                            radius: ScreenUtil().setSp(25),
                            backgroundImage: AssetImage(widget.userAvatar!),
                          )
                        : const CircleAvatar(child: Icon(Icons.person)),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFont(
                          text: widget.userName,
                          fontSize: ScreenUtil().setSp(20),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomFont(
                              text: '${widget.date} ·',
                              fontSize: ScreenUtil().setSp(14),
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
              ),
              SizedBox(height: ScreenUtil().setHeight(15)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                ),
                alignment: Alignment.centerLeft,
                child: CustomFont(
                  text: widget.postContent,
                  fontSize: ScreenUtil().setSp(18),
                  color: Colors.black,
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(30)),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(16),
                ),
                child: Row(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}