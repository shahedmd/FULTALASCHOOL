import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../asset.dart';




class StudentWeb extends StatefulWidget {
  const StudentWeb({super.key});

  @override
  State<StudentWeb> createState() => _StudentWebState();
}

class _StudentWebState extends State<StudentWeb> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crosscount = 3;
    if (screenWidth > 1600) {
      crosscount = 4;
    } else if (screenWidth > 1750) {
      crosscount = 5;
    }
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 120.w, top: 42.h),
                child: const Navbar(),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 144.h,
                width: double.infinity,
                color: const Color(0xff1395F2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CountObject(text1: "100+", text2: "Total Passed Student"),
                    SizedBox(
                      width: 200.w,
                    ),
                    CountObject(text1: "100+", text2: "Male Student"),
                    SizedBox(
                      width: 200.w,
                    ),
                    CountObject(text1: "100+", text2: "Female Student"),
                    SizedBox(
                      width: 200.w,
                    ),
                    CountObject(text1: "100+", text2: "Currently Studying")
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
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
                      child: GridView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Container(
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
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 30.w,
                                      right: 30.w,
                                      top: 30.h,
                                      bottom: 30.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                          text: snapshot.data!.docs[index]
                                              ["classname"],
                                          fontsize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue),
                                      SizedBox(
                                        height: 28.h,
                                      ),
                                      CustomText(
                                          text:
                                              "Total Student: ${snapshot.data!.docs[index]["totalstudent"]}",
                                          fontsize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                      SizedBox(
                                        height: 28.h,
                                      ),
                                      CustomText(
                                          text:
                                              "Male Student: ${snapshot.data!.docs[index]["malestudent"]}",
                                          fontsize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                      SizedBox(
                                        height: 28.h,
                                      ),
                                      CustomText(
                                          text:
                                              "Female Student: ${snapshot.data!.docs[index]["femalestudent"]}",
                                          fontsize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                      SizedBox(
                                        height: 28.h,
                                      ),
                                      CustomText(
                                          text: snapshot.data!.docs[index]
                                              ["classtname"],
                                          fontsize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 350.w / 250.h,
                                  crossAxisSpacing: 60.w,
                                  mainAxisSpacing: 20.h,
                                  crossAxisCount: crosscount)),
                    ),
                  );
                },
                stream: FirebaseFirestore.instance
                    .collection('studentpanel')
                    .snapshots(),
              ),
              SizedBox(
                height: 10.h,
              ),
              const NavbarWeb()
            ],
          ),
        ),
      ),
    );
  }
}
