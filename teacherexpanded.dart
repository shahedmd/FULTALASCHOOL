import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../asset.dart';
// ignore: unused_import,
import 'dart:html' as html;
// ignore: depend_on_referenced_packages

// ignore: must_be_immutable
class TeacherExpandedWeb extends StatefulWidget {
  String imageurl;
  String name;
  String desg;
  String educ;
  String joiningdate;
  String mpostatus;
  String mpodate;
  String dateofb;
  String nid;
  String cer;
  TeacherExpandedWeb(
      {super.key,
      required this.dateofb,
      required this.desg,
      required this.educ,
      required this.imageurl,
      required this.joiningdate,
      required this.mpodate,
      required this.mpostatus,
      required this.name,
      required this.cer,
      required this.nid});

  @override
  State<TeacherExpandedWeb> createState() => _TeacherExpandedWebState();
}

class _TeacherExpandedWebState extends State<TeacherExpandedWeb> {
  final Map<String, RxBool> _downloadStatus = {};

  

  @override
  Widget build(BuildContext context) {
    
    final url = widget.cer;
    final RxBool isDownloading = _downloadStatus[url] ??= false.obs;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 120.w, top: 42.h),
              child: const Navbar(),
            ),
            SizedBox(
              height: 60.h,
            ),
            SizedBox(
              height: 380.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 360.h,
                    width: 360.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                              widget.imageurl,
                            ),
                            fit: BoxFit.contain)),
                  ),
                  SizedBox(
                    width: 150.w,
                  ),
                  SizedBox(
                    width: 310.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            text: widget.name,
                            fontsize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                        SizedBox(height: 10.h),
                        CustomText(
                            text: widget.desg,
                            fontsize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                        SizedBox(height: 10.h),
                        CustomText(
                            text: widget.educ,
                            fontsize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                        SizedBox(height: 10.h),
                        CustomText(
                            text: "${widget.mpostatus}(${widget.mpodate})",
                            fontsize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                        SizedBox(height: 10.h),
                        CustomText(
                            text: "NID: ${widget.nid}",
                            fontsize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                        SizedBox(height: 10.h),
                        CustomText(
                            text: "Date of birth: ${widget.dateofb}",
                            fontsize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                        SizedBox(height: 10.h),
                        CustomText(
                            text: "Joining date:  ${widget.joiningdate}",
                            fontsize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                        SizedBox(height: 10.h),
                        InkWell(
                            onTap: () {
                             print(widget.cer);
                              downloadFileWeb(url, "certificate.pdf");
                            },
                            child: Obx(() => isDownloading.value
                                ? const CircularProgressIndicator()
                                : CustomButton(
                                    text: "DOWNLOAD CERTIFICATE",
                                  )))
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 69.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 193.w),
              child: CustomText(
                  text: "Teacher Speech",
                  fontsize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 193.w),
              child: SizedBox(
                width: 1000.w,
                child: CustomText(
                    text:
                        "To the world, you may be just another teacher, but to us, you are our hero. We respect you for what you have been doing for us all through these years. We know we are not the best students, but you are the best teacher we could ever ask for. Thank you for accepting us for who we are and for loving us as much.",
                    fontsize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 55.h,
            ),
            const NavbarWeb()
          ],
        ),
      ),
    );
  }

  Future<void> downloadFileWeb(String link, String fileName) async {
  _downloadStatus[link]!.value = true;

  try {
    final httpsReference = FirebaseStorage.instance.refFromURL(link);
    final data = await httpsReference.getData();

    // Convert Uint8List to Blob
    final blob = html.Blob([data!]);

    // Create a download link
    final url = html.Url.createObjectUrlFromBlob(blob);
    // ignore: unused_local_variable
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', '$fileName.pdf')
      ..click();

    // Clean up
    html.Url.revokeObjectUrl(url);
  } catch (e) {
    print("Error downloading PDF: $e");
  } finally {
    _downloadStatus[link]!.value = false;
  }
}

}
