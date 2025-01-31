import 'package:delivery_app/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../model/rating_model.dart';

class RatingCard extends StatelessWidget {
  final ImageProvider profileImage; // 리뷰 작성자 프로필 이미지
  final List<Image> images; // 리뷰 이미지
  final int rating; // 별점
  final String email; // 리뷰 작성자 이메일
  final String content; // 리뷰 내용

  const RatingCard({
    super.key,
    required this.profileImage,
    required this.images,
    required this.rating,
    required this.email,
    required this.content,
  });

  factory RatingCard.fromModel({
    required RatingModel model,
  }) {
    return RatingCard(
      profileImage: NetworkImage(model.user.imageUrl),
      images: model.imgUrls.map((e) => Image.network(e)).toList(),
      rating: model.rating,
      email: model.user.username,
      content: model.content,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(
          profileImage: profileImage,
          rating: rating,
          email: email,
        ),
        const SizedBox(height: 8),
        _Body(
          content: content,
        ),
        if (images.isNotEmpty)
          _Images(
            images: images,
          ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final ImageProvider profileImage; // 리뷰 작성자 프로필 이미지
  final int rating; // 별점
  final String email; // 리뷰 작성자 이메일

  const _Header({
    super.key,
    required this.profileImage,
    required this.rating,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 12,
          backgroundImage: profileImage,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            email,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < rating ? Icons.star : Icons.star_border,
              color: Colors.amber,
              size: 16,
            );
          }),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final String content; // 리뷰 내용

  const _Body({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          // 화면 크기에 따라 텍스트가 오버플로되면 줄바꿈
          child: Text(
            content,
            style: TextStyle(
              color: BODY_TEXT_COLOR,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class _Images extends StatelessWidget {
  final List<Image> images; // 리뷰 이미지

  const _Images({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        height: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: images
              .mapIndexed(
                (index, e) => Padding(
                  padding: EdgeInsets.only(
                      right: index == images.length - 1 ? 0 : 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: e,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
