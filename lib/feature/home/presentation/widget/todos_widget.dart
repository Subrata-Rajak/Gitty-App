import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gitty/core/common/widgets.dart';
import 'package:gitty/src/values/colors.dart';

class TodosWidget extends StatelessWidget with CommonWidgets {
  final Size size;
  final int userId;
  final String title;
  final bool completed;
  final int todoId;

  const TodosWidget({
    super.key,
    required this.size,
    required this.completed,
    required this.title,
    required this.userId,
    required this.todoId,
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
          Row(
            children: [
              const Text(
                "Completed",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              horizontalSpace(w: 20),
              Icon(
                completed
                    ? FontAwesomeIcons.check
                    : FontAwesomeIcons.circleXmark,
                color: completed ? Colors.green : Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
