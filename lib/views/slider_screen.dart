import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/slider_provider.dart';
import './register/register_screen.dart';

class SliderScreen extends StatelessWidget {
  final List<Map<String, String>> slides = [
    {
      "image": "assets/images/slide1.png",
      "topImage": "assets/images/splash.png",
      "title": "Start Exploring",
      "desc": "Quickly get started with mobile or social media login"
    },
    {
      "image": "assets/images/slide2.jpg",
      "topImage": "assets/images/splash.png",
      "title": "Find Best Lawyers",
      "desc": "Easily find lawyers for your cases"
    },
    {
      "image": "assets/images/slide2.jpg",
      "topImage": "assets/images/splash.png",
      "title": "Chat with Our Bot",
      "desc": "Get quick answers to your questions with our intelligent chatbot"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SliderProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  itemCount: slides.length,
                  onPageChanged: (index) => provider.setPage(index),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(slides[index]["topImage"]!, width: 150, height: 80, fit: BoxFit.contain),

                        SizedBox(height: 20),

                        Image.asset(slides[index]["image"]!, width: 400, height: 200),

                        SizedBox(height: 20),

                        Text(
                          slides[index]["title"]!,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),

                        SizedBox(height: 10),

                        Text(
                          slides[index]["desc"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            slides.length,
                                (dotIndex) => Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              width: dotIndex == provider.currentPage ? 12 : 8,
                              height: dotIndex == provider.currentPage ? 12 : 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: dotIndex == provider.currentPage ? Colors.brown : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6D4905),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    child: Text(
                      "Get Started",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
