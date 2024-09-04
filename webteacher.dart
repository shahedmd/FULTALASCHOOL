import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../asset.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'teacherexpanded.dart';
class WebTeacher extends StatefulWidget {
  const WebTeacher({super.key});

  @override
  State<WebTeacher> createState() => _WebTeacherState();
}

class _WebTeacherState extends State<WebTeacher> {
    late Stream<QuerySnapshot> _teachersStream;

  @override
  void initState() {
    super.initState();
    _teachersStream = FirebaseFirestore.instance
        .collection('teacherinfo')
        .orderBy("serial", descending: false)
        .snapshots();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crosscount = 4;
    double heighfinal = 400.h;

    if (screenWidth > 1600) {
      heighfinal = 450.h;
    }

    if (screenWidth > 1600) {
      crosscount = 5;
    }
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(left: 100.w, top: 42.h),
              child: const Navbar(),
            ),
            SizedBox(
              height: 38.h,
            ),
            CustomText(
                text: "Our Governing Body ",
                fontsize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.black),

                SizedBox(height: 20.h,),
                              Padding(
                                padding: const EdgeInsets.all(30),
                                child: StreamBuilder(
                                              builder: (context, snapshot) {
                                                if (snapshot.hasError) {
                                                  // ignore: avoid_print
                                                  print(snapshot.error.toString());
                                                  return Text(snapshot.error.toString());
                                                  
                                                }
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Text("Waiting");
                                                }
                              
                                                return SizedBox(
                                                  height: snapshot.data!.docs.length /
                                                      crosscount *
                                                      heighfinal,
                                                  child: GridView.builder(
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 70.w,
                                mainAxisSpacing: 45.h,
                                childAspectRatio: 394.w / 377.h,
                                crossAxisCount: crosscount),
                                                    physics: const  NeverScrollableScrollPhysics(),
                                                    itemCount: snapshot.data!.docs.length,
                                                    itemBuilder: (context, index) {
                                                      return GestureDetector(
                                                        onTap: () => Get.to(TeacherExpandedWeb(
                                                            dateofb: snapshot.data!.docs[index]
                                                                ["brithdate"],
                                                            desg: snapshot.data!.docs[index]["desg"],
                                                            educ: snapshot.data!.docs[index]["educ"],
                                                            imageurl: snapshot.data!.docs[index]
                                                                ["image"],
                                                            joiningdate: snapshot.data!.docs[index]
                                                                ["joiningdate"],
                                                            mpodate: snapshot.data!.docs[index]
                                                                ["mpodate"],
                                                            mpostatus: snapshot.data!.docs[index]
                                                                ["mpo"],
                                                            name: snapshot.data!.docs[index]["name"],
                                                            nid: snapshot.data!.docs[index]["nid"],
                                                            cer: snapshot.data!.docs[index]["cer"],)),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                                          ),
                                                          child: FittedBox(
                                child: Column(
                                  children: [
                                    SizedBox(height: 20.h),
                                    Container(
                                      height: 253.h,
                                      width: 253.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(snapshot
                                                  .data!
                                                  .docs[index]["image"]),
                                              fit: BoxFit.contain)),
                                    ),
                                    SizedBox(height: 10.h),
                                    CustomText(
                                        text: snapshot.data!.docs[index]
                                            ["name"],
                                        fontsize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                    SizedBox(height: 10.h),
                                    CustomText(
                                        text: snapshot.data!.docs[index]
                                            ["desg"],
                                        fontsize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                    SizedBox(height: 15.h),
                                  ],
                                ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                              stream: _teachersStream,
                                            ),
                              ),

                              SizedBox(height: 20.h,),
                              const NavbarWeb()

          ]),
        ),
      ),
    );
  }
}
