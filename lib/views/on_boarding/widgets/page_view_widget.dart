import 'package:chat_boot/models/on_boarding_model.dart';
import 'package:chat_boot/utils/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({
    super.key,
    required this.page,
  });

  final OnBoardingModel page;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          page.image,
          height: 400,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 20),
        // Text(
        //   page.title,
        //   style: AppTextStyle.heading.copyWith(color: Colors.black),
        // ),
        page.highlightAI
            ? Text.rich(
                TextSpan(
                  text: 'Welcome to Boot ',
                  style: AppTextStyle.heading.copyWith(
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(text: 'AI', style: AppTextStyle.heading),
                  ],
                ),
                textAlign: TextAlign.center,
              )
            : Text(
                page.title,
                style: AppTextStyle.heading.copyWith(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
        const SizedBox(height: 10),
        Text(
          page.description,
          style: AppTextStyle.body.copyWith(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
