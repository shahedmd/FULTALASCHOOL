import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../asset.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WebPageHomePage extends StatefulWidget {
  const WebPageHomePage({super.key});

  @override
  State<WebPageHomePage> createState() => _WebPageHomePageState();
}

class _WebPageHomePageState extends State<WebPageHomePage> {
  final ScrollController _scrollController = ScrollController();
  bool hasScrolledToTrigger = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // loadSavedVisibility();
  }

  void _onScroll() {
    double position = _scrollController.position.pixels;
    double triggerPoint = 300.0;

    // ignore: avoid_print
    print('Scroll position: $position');

    if (position >= triggerPoint && !hasScrolledToTrigger) {
      setState(() {
        hasScrolledToTrigger = true;
        // ignore: avoid_print
        print('Scrolled to trigger!');
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);

    super.dispose();
  }

  CollectionReference users =
      FirebaseFirestore.instance.collection('homepageteacherinfo');

  CollectionReference user2 =
      FirebaseFirestore.instance.collection('sumhomecollection');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 100.w, top: 42.h),
                  child: const Navbar(),
                ),
                SizedBox(
                  height: 190.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            TyperAnimatedText(
                              "A good education",
                              textStyle: TextStyle(
                                  fontSize: 50.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff1395F2)),
                            ),
                            TyperAnimatedText(
                              "It's a foundation for",
                              textStyle: TextStyle(
                                  fontSize: 50.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            TyperAnimatedText(
                              "better future.",
                              textStyle: TextStyle(
                                  fontSize: 50.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            TyperAnimatedText(
                              "better future.",
                              textStyle: TextStyle(
                                  fontSize: 50.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 36.h,
                        ),
                        SizedBox(
                          width: 501.w,
                          child: AnimatedTextKit(
                              repeatForever: false,
                              totalRepeatCount: 1,
                              animatedTexts: [
                                TyperAnimatedText(
                                  "Education then, beyond all other devices of human origin, is the great equalizer of the conditions of men, the balance -wheel of the social machinery.",
                                  textStyle: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 58.h,
                        ),
                        CustomButton(text: "Scroll Down To Start")
                      ],
                    ),
                    SizedBox(
                      width: 50.w,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: SizedBox(
                          height: 500.h,
                          width: 623.w,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.r),
                              child: Image.asset(
                                "images/school1.jpg",
                                fit: BoxFit.fill,
                              ))).moveUpOnHover,
                    )
                  ],
                ),
                SizedBox(
                  height: 170.h,
                ),
                // hasScrolledToTrigger
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(seconds: 5),
                  child: Container(
                    height: 144.h,
                    width: double.infinity,
                    color: const Color(0xff1395F2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CountObject(text1: "100+", text2: "Total Seat"),
                        SizedBox(
                          width: 200.w,
                        ),
                        CountObject(text1: "100+", text2: "Total Student"),
                        SizedBox(
                          width: 200.w,
                        ),
                        CountObject(text1: "100+", text2: "Current Student"),
                        SizedBox(
                          width: 200.w,
                        ),
                        CountObject(text1: "100+", text2: "Faculty Member")
                      ],
                    ),
                  )
                      .animate()
                      .fade()
                      .slideX(duration: const Duration(seconds: 3)),
                ),

                SizedBox(
                  height: 60.h,
                ),

                SizedBox(
                  height: 300.h,
                  width: double.infinity,
                  child: FutureBuilder(
                    future: users.doc('xTEFFqSlzelvSVFbH7kj').get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Something went wrong");
                      }

                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return const Text("Document does not exist");
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 289.h,
                              width: 289.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(data["pic"]),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                                .animate()
                                .slideX(duration: const Duration(seconds: 2)),
                            SizedBox(
                              width: 70.w,
                            ),
                            FittedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                      text: data["name"],
                                      fontsize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  CustomText(
                                      text: data["desg"],
                                      fontsize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                  SizedBox(
                                    height: 18.h,
                                  ),
                                  SizedBox(
                                    width: 723.w,
                                    child: CustomText(
                                        text: data["speech"],
                                        fontsize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  )
                                ],
                              ).animate().slide(
                                    begin: const Offset(1.0, 0.0),
                                    curve: Curves.easeInOut,
                                    duration: const Duration(seconds: 3),
                                  ),
                            )
                          ],
                        );
                      }

                      return const Text("loading");
                    },
                  ),
                ),

                SizedBox(
                  height: 100.h,
                ),
                SizedBox(
                  height: 450.h,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FutureBuilder(
                          future: user2.doc('100002').get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text("Something went wrong");
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("Wait a moment");
                            }

                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;

                            return Container(
                              width: 450.w,
                              margin: EdgeInsets.only(left: 120.w),
                              padding: EdgeInsets.only(
                                  left: 20.w,
                                  right: 20.w,
                                  top: 20.h,
                                  bottom: 20.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: FittedBox(
                                child: Column(
                                  children: [
                                    SizedBox(height: 20.h),
                                    Container(
                                      height: 289.h,
                                      width: 289.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                data['pic'],
                                              ),
                                              fit: BoxFit.contain)),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    CustomText(
                                        text: data["name"],
                                        fontsize: 25,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    CustomText(
                                        text: data["desg"],
                                        fontsize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)
                                  ],
                                ),
                              ),
                            ).moveUpOnHover;
                          },
                        ),
                        SizedBox(
                          width: 80.w,
                        ),
                        FutureBuilder(
                          future: user2.doc('1000001').get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text("Something went wrong");
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("Wait a moment");
                            }

                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;

                            return Container(
                              width: 450.w,
                              margin: EdgeInsets.only(left: 120.w),
                              padding: EdgeInsets.only(
                                  left: 20.w,
                                  right: 20.w,
                                  top: 20.h,
                                  bottom: 20.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: FittedBox(
                                child: Column(
                                  children: [
                                    SizedBox(height: 20.h),
                                    Container(
                                      height: 289.h,
                                      width: 289.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                data['pic'],
                                              ),
                                              fit: BoxFit.contain)),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    CustomText(
                                        text: data["name"],
                                        fontsize: 25,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    CustomText(
                                        text: data["desg"],
                                        fontsize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)
                                  ],
                                ),
                              ),
                            ).moveUpOnHover;
                          },
                        ),
                      ]),
                ),
SizedBox(height: 30.h,),
               const NavbarWeb()
              ],
            )),
      ),
    );
  }
}
