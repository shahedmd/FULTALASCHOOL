import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../asset.dart';




class Navbarformobile extends StatefulWidget {
  const Navbarformobile({super.key});

  @override
  State<Navbarformobile> createState() => _NavbarformobileState();
}




class _NavbarformobileState extends State<Navbarformobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.w),
    
      width: double.infinity,
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300.h,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                      text: "Fultala  SCHOOL",
                      fontsize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    width: 250.w,
                    child: CustomText(
                        text:
                            "Fultala Mohammadia High School is an educational establishment that is located at Torkey islampur (fultala) Bhiti Hogla Munshiganj Sadar Munshiganj. Its Educational Institute Identification Number or EIIN, is 111131",
                        fontsize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  )
                ]),
          ),
          SizedBox(
            height: 300.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                    text: "Important Links",
                    fontsize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: () => launchUrl(Uri.parse('https://www.dhakaeducationboard.gov.bd/site/')),
                  child: CustomText(
                      text: "Dhaka Education Board",
                      fontsize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 17.h,
                ),
                InkWell(
                  onTap: () => launchUrl(Uri.parse('https://dhakaeducationboard.gov.bd/index.php/etif/')),
                  child: CustomText(
                      text: "eTIF",
                      fontsize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 17.h,
                ),
                InkWell(
                  onTap: () => launchUrl(Uri.parse('https://moedu.gov.bd/')),
                  child: CustomText(
                      text: "Ministry of Education",
                      fontsize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 17.h,
                ),
                InkWell(
                  onTap: () => launchUrl(Uri.parse('https://dshe.gov.bd/')),
                  child: CustomText(
                      text: "Directorate of Secondary and Higher Education",
                      fontsize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 300.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: "Contact Info",
                    fontsize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                SizedBox(
                  height: 20.h,
                ),
                CustomText(
                    text: "Email: jamalhossain197521@gmail.com",
                    fontsize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                SizedBox(
                  height: 17.h,
                ),
                CustomText(
                    text: "Email: office.fultala@gmail.com",
                    fontsize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                SizedBox(
                  height: 17.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomText(
                    text: "Phone: 01716244717",
                    fontsize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                SizedBox(
                  height: 17.h,
                ),
                CustomText(
                    text: "Hotline: 01716244717",
                    fontsize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)
              ],
            ),
          ),
          SizedBox(
            height: 300.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: "Our Services",
                    fontsize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                SizedBox(
                  height: 20.h,
                ),
                CustomText(
                    text: "Result",
                    fontsize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                SizedBox(
                  height: 17.h,
                ),
                CustomText(
                    text: "Admission",
                    fontsize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                    SizedBox(height: 17.h,),
                CustomText(
                    text: "Education Notice",
                    fontsize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white)
              ],
            ),
          )
        ],
      ),
    );
  }
}