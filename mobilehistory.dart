// ignore_for_file: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:cross_file/cross_file.dart';
import 'package:fultalaschool/asset.dart';
import 'package:get/get.dart';
import 'asset/asset.dart';
import 'asset/mobilenavbar.dart';

class MobileSchoolhistory extends StatefulWidget {
  const MobileSchoolhistory({super.key});

  @override
  State<MobileSchoolhistory> createState() => _MobileSchoolhistoryState();
}

class _MobileSchoolhistoryState extends State<MobileSchoolhistory> {
  final Map<String, RxBool> _downloadStatus = {};

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
          text: "Fultala SHCOOL",
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              CustomText(
                  text: "School History",
                  fontsize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 13.0.h),
                child: SizedBox(
                  width: 400.w,
                  child: CustomText(
                      text:
                          "Fultala Mohammadia High School is an educational establishment that is located at Torkey islampur (fultala) Bhiti Hogla Munshiganj Sadar Munshiganj. Its Educational Institute Identification Number or EIIN, is 111131. On 01 January, 1980, it was first put into operation. The alternative name for Fultala Mohammadia High School is ফুলতলা মোহাম্মদীয়া উচ্চ বিদ্যালয়. It is a Combined sort of co-educational program. The institution provides education in the following fields: Science, Business Studies, Humanities.Its MPO number is 2903091301. It operates on Day shift(s). Its management is Managing. Its recognition is Recognized by the government and the recognition level is Secondary. The school/college has MPO level with MPO number 2903091301 and the MPO type is Yes. Fultala Mohammadia High School is under Dhaka Education Board.While many other high schools teach numerous disciplines, you can find the major disciplines that they teach in this high school as Science, Business Studies, Humanities. The management type of this institute is Managing. The region in which it is located is Grameen with geographic location as Plain Land. The institute is in the constituency no 169. Average age of the teachers at Fultala Mohammadia High School is 52 years.",
                      fontsize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('schoolhistory')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Error 404");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Waiting");
                  }

                  return SizedBox(
                    height: snapshot.data!.docs.length * 120.h,
                    width: 400.w,
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                       final String url = snapshot.data!.docs[index]["url"];
                        final String title = snapshot.data!.docs[index]["title"];
                        final RxBool isDownloading = _downloadStatus[url] ??= false.obs;
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ListTile(
                            title: CustomText(
                                text: title,
                                fontsize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                            trailing: Obx(() => isDownloading.value? const CircularProgressIndicator(): MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: InkWell(
                                onTap: () => downloadFileWeb(
                                  snapshot.data!.docs[index]["url"],
                                  "pdfdown",
                                ),
                                child: 
                                  Container(
                                    height: 35.h,
                                    width: 35.w,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue),
                                    child: const Icon(
                                      Icons.download,
                                      color: Colors.white,
                                    ),
                                  ).moveUpOnHover,
                                ),
                            
                            ),) 
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              const Navbarformobile()
            ],
          ),
        ),
      ),
    );
  }

  Future<void> downloadFileWeb(String url, String fileName) async {
    _downloadStatus[url]!.value = true;

    final httpsReference = FirebaseStorage.instance.refFromURL(url);

    try {
      const oneMegabyte = 1024 * 1024;
      final Uint8List? data = await httpsReference.getData(oneMegabyte);

      XFile.fromData(data!,
              mimeType: "application/octet-stream", name: "$fileName.pdf")
          .saveTo("C:/");

      // Save the file or do anything with the data
    } on FirebaseException catch (e) {
      // ignore: avoid_print
      print("Firebase Exception: $e");
    } finally {
      _downloadStatus[url]!.value = false;
    }
  }
}
