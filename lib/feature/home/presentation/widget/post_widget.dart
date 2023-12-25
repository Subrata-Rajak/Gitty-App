import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gitty/core/common/widgets.dart';
import 'package:gitty/src/values/colors.dart';

class PostWidget extends StatelessWidget with CommonWidgets {
  final Size size;
  final int userId;
  final String title;
  final String body;
  final int postId;

  const PostWidget({
    super.key,
    required this.size,
    required this.body,
    required this.title,
    required this.userId,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.instance.black,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(18),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                child: Icon(
                  FontAwesomeIcons.user,
                ),
              ),
              horizontalSpace(w: 13),
              Text(
                "User $userId",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          verticalSpace(h: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          verticalSpace(h: 10),
          Text(
            body,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.instance.grey,
            ),
          ),
        ],
      ),
    );
  }
}
