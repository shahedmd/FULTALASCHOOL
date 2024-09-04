import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import '../asset.dart';
import 'asset/asset.dart';
import 'asset/mobilenavbar.dart';
import 'teacherexpanded.dart';








class MobileTeacherPanel extends StatefulWidget {
  const MobileTeacherPanel({super.key});

  @override
  State<MobileTeacherPanel> createState() => _TeacherPanelState();
}

class _TeacherPanelState extends State<MobileTeacherPanel> {
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
              SizedBox(height: 20.h,),
              CustomText(
                  text: "Our Governing Body ",
                  fontsize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
                  SizedBox(height: 15.h,),

                                StreamBuilder(
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return const Text("Error 404");
                                    }
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Text("Waiting");
                                    }

                                    return SizedBox(
                                      // ignore: unrelated_type_equality_checks
                                      height: snapshot.data!.docs.length * 300.h,
                                      child: Padding(
                                        padding:  EdgeInsets.only(left: 40.w, right: 40.w),
                                        child: ListView.builder(
                                         
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () => Get.to(MobileTeacherExpanded(
                                                  dateofb: snapshot.data!.docs[index]
                                                      ["brithdate"],
                                                  desg: snapshot.data!.docs[index]["desg"],
                                                  educ: snapshot.data!.docs[index]["educ"],
                                                  imageurl: snapshot.data!.docs[index]["image"],
                                                  joiningdate: snapshot.data!.docs[index]
                                                      ["joiningdate"],
                                                  mpodate: snapshot.data!.docs[index]["mpodate"],
                                                  mpostatus: snapshot.data!.docs[index]["mpo"],
                                                  name: snapshot.data!.docs[index]["name"],
                                                  nid: snapshot.data!.docs[index]["nid"])),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Container(
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
                                                
                                                  
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 20.h,
                                                      ),
                                                      Container(
                                                        height: 150.h,
                                                        width: 150.w,
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            image: DecorationImage(
                                                                image: NetworkImage(snapshot
                                                                    .data!.docs[index]["image"]),
                                                                fit: BoxFit.contain)),
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      CustomText(
                                                          text: snapshot.data!.docs[index]
                                                              ["name"],
                                                          fontsize: 17,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      CustomText(
                                                          text: snapshot.data!.docs[index]
                                                              ["desg"],
                                                          fontsize: 14,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black),
                                                      SizedBox(
                                                        height: 15.h,
                                                      )
                                                    ],
                                                  ),
                                                ).moveUpOnHover,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  stream: FirebaseFirestore.instance
                                      .collection('teacherinfo')
                                      .orderBy("serial", descending: false)
                                      .snapshots(),
                                ),

                                SizedBox(height: 15.h,),
                              const  Navbarformobile()
            ],
          )),
        ));
  }
}
