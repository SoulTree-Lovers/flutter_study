import 'package:delivery_app/common/const/colors.dart';
import 'package:delivery_app/domain/restaurant/model/restaurant_detail_model.dart';
import 'package:delivery_app/domain/restaurant/model/restaurant_model.dart';
import 'package:flutter/material.dart';

import '../../../common/const/data.dart';

class RestaurantCard extends StatelessWidget {
  final Widget image; // 이미지
  final String name; // 식당 이름
  final List<String> tags; // 식당 태그
  final int ratingsCount; // 평점 개수
  final double ratings; // 평점
  final int deliveryTime; // 배달 시간
  final int deliveryFee; // 배달 비용
  final bool isDetail; // 상세 페이지 여부
  final String? detail; // 상세 내용

  const RestaurantCard({
    super.key,
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingsCount,
    required this.ratings,
    required this.deliveryTime,
    required this.deliveryFee,
    this.isDetail = false,
    this.detail,
  });

  factory RestaurantCard.fromModel({
    required RestaurantModel model,
    bool isDetail = false,
  }) {
    return RestaurantCard(
      image: Image.network(
        model.thumbUrl,
        fit: BoxFit.cover,
      ),
      name: model.name,
      tags: model.tags,
      ratingsCount: model.ratingsCount,
      ratings: model.ratings,
      deliveryTime: model.deliveryTime,
      deliveryFee: model.deliveryFee,
      isDetail: isDetail,
      detail: model is RestaurantDetailModel ? model.detail : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isDetail) image,
        if (!isDetail)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: image,
          ),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDetail ? 16 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                tags.join(' • '),
                style: TextStyle(
                  fontSize: 14,
                  color: BODY_TEXT_COLOR,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  IconText(
                    icon: Icons.star,
                    text: ratings.toString(),
                  ),
                  renderDot(),
                  IconText(
                    icon: Icons.receipt,
                    text: ratingsCount.toString(),
                  ),
                  renderDot(),
                  IconText(
                    icon: Icons.timelapse_outlined,
                    text: '$deliveryTime분',
                  ),
                  renderDot(),
                  IconText(
                    icon: Icons.monetization_on,
                    text: deliveryFee == 0 ? '무료배달' : '$deliveryFee원',
                  ),
                ],
              ),
              if (detail != null && isDetail)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    detail!,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  renderDot() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        ' • ',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class IconText extends StatelessWidget {
  final IconData icon; // 아이콘
  final String text; // 텍스트

  const IconText({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: PRIMARY_COLOR,
        ),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
