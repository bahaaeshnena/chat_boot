import 'package:chat_boot/models/on_boarding_model.dart';
import 'package:chat_boot/utils/theme/app_colors.dart';
import 'package:chat_boot/utils/widgets/custom_elevated_button.dart';
import 'package:chat_boot/views/chat/chat_view.dart';
import 'package:chat_boot/views/on_boarding/widgets/dots_section.dart';
import 'package:chat_boot/views/on_boarding/widgets/page_view_widget.dart';
import 'package:flutter/material.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleButtonPressed() {
    if (currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ChatView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 40.0,
          ),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return PageViewWidget(
                      page: pages[index],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                text: pages[currentPage].buttonText,
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.backgroundColor,
                onPressed: () {
                  _handleButtonPressed();
                },
              ),
              const SizedBox(height: 20),
              DotsSection(
                currentPage: currentPage,
                totalPages: pages.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
