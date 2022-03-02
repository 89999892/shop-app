import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Cache_Helper.dart';
import 'package:shop_app/Shared/components&widgets/functions.dart';
import 'package:shop_app/models/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'shop_login/login_screen.dart';

class Onboarding extends StatefulWidget {
  Onboarding();

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  List<OnboardingModel> boardingList = [
    OnboardingModel(
        image: 'assets/images/onboarding1.png',
        title: ' Title 1',
        body: 'this is body 1'),
    OnboardingModel(
        image: 'assets/images/onboarding1.png',
        title: ' Title 2',
        body: 'this is body 2'),
    OnboardingModel(
        image: 'assets/images/onboarding1.png',
        title: ' Title 3',
        body: 'this is body 3'),
  ];
  var boardingController=PageController() ;
  int currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(

              onPressed: submit, child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text('Skip',style: Theme.of(context).textTheme.button,),
          ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemBuilder: (context, index) {
                return _onBoardingItem(boardingList[index]);
              },
              controller: boardingController,
              onPageChanged: (value){
                currentIndex=value;
                print(' index herrrr ${currentIndex}');
                              },
              itemCount: 3,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: 3,
                  effect: WormEffect(

                    activeDotColor: Colors.lightBlue,
                    dotWidth: 16,
                    dotHeight: 16,
                    dotColor: Colors.grey,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(currentIndex==boardingList.length-1){
                      submit();
                    }

                    boardingController.nextPage(duration: Duration(milliseconds: 700), curve: Curves.linear);
                  },

                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget _onBoardingItem(OnboardingModel onboardingModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 500,
            child: Image(
              image: AssetImage('${onboardingModel.image}'),
            ),
          ),
          Text('${onboardingModel.title}',
              style: Theme.of(context).textTheme.body1),
          Text(
            '${onboardingModel.body}',
            style: Theme.of(context).textTheme.title,
          )
        ],
      ),
    );
  }

  void submit() {
    CacheHelper.SaveDate(key: 'onBoarding', value: true).then((value){
     if(value){
       navigateAndRemove(context, LoginScreen());
     }
    }  );
  }
}
