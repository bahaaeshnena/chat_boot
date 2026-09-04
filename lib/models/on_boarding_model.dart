import 'package:chat_boot/utils/constants/assets.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String description;
  final String buttonText;
  final bool highlightAI;

  const OnBoardingModel({
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
    this.highlightAI = false,
  });
}

List<OnBoardingModel> get pages => [
  OnBoardingModel(
    image: Assets.assetsImagesRobotIcon,
    title: 'Welcome to Boot AI',
    description:
        'Your intelligent assistant for learning, coding and creating.',
    buttonText: 'Get Started',
    highlightAI: true,
  ),
  OnBoardingModel(
    image: Assets.assetsImagesChatIcon,
    title: 'Smart Conversations',
    description: 'Ask anything and get helpful answers powered by Gemini.',
    buttonText: 'Next',
  ),
  OnBoardingModel(
    image: Assets.assetsImagesFastIcon,
    title: 'Built for Developers',
    description: 'Write, debug, explore and build faster with AI by your side',
    buttonText: 'Let’s Go',
  ),
];
