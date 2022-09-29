import 'package:blood_doner/ui/onboarding/onboarding_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:stacked/stacked.dart';

class IntroductionScreenPage extends StatefulWidget {
  const IntroductionScreenPage({Key? key}) : super(key: key);

  @override
  State<IntroductionScreenPage> createState() => _IntroductionScreenPageState();
}

class _IntroductionScreenPageState extends State<IntroductionScreenPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return ViewModelBuilder<OnboardingViewModel>.reactive(
      builder: (context, model, child) => IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Colors.white,
        globalFooter: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            child: const Text(
              'Let\'s go right away!',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            onPressed: () => model.changeNavigation(),
          ),
        ),
        pages: [
          PageViewModel(
            body: "",
            title: "Give Blood, Give Life",
            image: _buildImage('splash1.jpg'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            body: "",
            title: "Be the reason for someone's heartbeat",
            image: _buildImage('splash2.jpeg'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            body: "",
            title: "Once a blood donor is always a lifesaver",
            decoration: pageDecoration,
            image: _buildImage('splash3.jpeg'),
            reverse: false,
          ),
        ],
        onDone: () => model.changeNavigation(),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: false,
        skipOrBackFlex: 0,
        nextFlex: 0,
        showBackButton: true,
        //rtl: true, // Display as right-to-left
        back: const Icon(Icons.arrow_back),
        skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: kIsWeb
            ? const EdgeInsets.all(12.0)
            : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
      viewModelBuilder: () => OnboardingViewModel(),
      // onModelReady: (model) => SchedulerBinding.instance
      //     .addPostFrameCallback((_) => model.initialise()),
    );
  }
}
