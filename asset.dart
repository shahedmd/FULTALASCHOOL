import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../asset.dart';
import '../mobilehistory.dart';
import '../mobilehome.dart';
import '../mobilenotice.dart';
import '../mobilephoto.dart';
import '../mobilestudent.dart';
import '../teacher.dart';


class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 35.h,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.home,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  InkWell(
                      onTap: () => Get.to(const MobileHomePage()),
                      child: CustomText(
                          text: "Home ",
                          fontsize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue)),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  InkWell(
                      onTap: () => Get.to(const MobileTeacherPanel()),
                      child: CustomText(
                          text: "Teacher Panel",
                          fontsize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue)),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.photo_album,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  InkWell(
                      onTap: () => Get.to(const MobilePhoto()),
                      child: CustomText(
                          text: "Photo Galary",
                          fontsize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue)),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.cast_for_education,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  InkWell(
                      onTap: () => Get.to(const MobileStudent()),
                      child: CustomText(
                          text: "Student panel",
                          fontsize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue)),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.history,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  InkWell(
                      onTap: () => Get.to(const MobileSchoolhistory()),
                      child: CustomText(
                          text: "School History",
                          fontsize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue)),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.notifications,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  InkWell(
                      onTap: () => Get.to(const MobileNoticePage()),
                      child: CustomText(
                          text: "School Notice",
                          fontsize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
