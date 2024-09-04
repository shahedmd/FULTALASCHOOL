import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../asset.dart';
import 'asset/asset.dart';
import 'asset/mobilenavbar.dart';





class MobileStudent extends StatefulWidget {
  const MobileStudent({super.key});

  @override
  State<MobileStudent> createState() => _MobileStudentState();
}

class _MobileStudentState extends State<MobileStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MobileDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: CustomText(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontsize: 20,
          text: "CHAMPATALA SHCOOL",
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
            child: Column(
          children: [
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(seconds: 5),
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                color: const Color(0xff1395F2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CountObject(text1: "100+", text2: "Total Passed Student"),
                    SizedBox(
                      height: 25.h,
                    ),
                    CountObject(text1: "100+", text2: "Total Male Student"),
                    SizedBox(
                      height: 25.h,
                    ),
                    CountObject(
                        text1: "100+", text2: "Current Female  Student"),
                    SizedBox(
                      height: 25.h,
                    ),
                    CountObject(
                        text1: "100+", text2: "Current Studing Student"),
                  ],
                ),
              ).animate().fade(duration: const Duration(seconds: 3)),
            ),
            SizedBox(
              height: 15.h,
            ),
            StreamBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text("Error 404");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Waiting");
                }

                return Padding(
                  padding: EdgeInsets.only(left: 60.w, right: 60.w),
                  child: SizedBox(
                    height: snapshot.data!.docs.length * 260.h,
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 252, 252, 252),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 110, 188, 243),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: Offset(3, 8),
                                ),
                              ],
                            ),
                            child: FittedBox(
                              child: SizedBox(
                                height: 300.h,
                                width: 400.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomText(
                                        text: snapshot.data!.docs[index]
                                            ["classname"],
                                        fontsize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    CustomText(
                                        text:
                                            "Total Student: ${snapshot.data!.docs[index]["totalstudent"]}",
                                        fontsize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    CustomText(
                                        text:
                                            "Male Student: ${snapshot.data!.docs[index]["malestudent"]}",
                                        fontsize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    CustomText(
                                        text:
                                            "Female Student: ${snapshot.data!.docs[index]["femalestudent"]}",
                                        fontsize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    CustomText(
                                        text: snapshot.data!.docs[index]
                                            ["classtname"],
                                        fontsize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  ),
                );
              },
              stream: FirebaseFirestore.instance
                  .collection('studentpanel')
                  .snapshots(),
            ),

            SizedBox(height: 15.h,),
            const Navbarformobile()

          ],
        )),
      ),
    );
  }
}