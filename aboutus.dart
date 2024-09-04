import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter, unused_import
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:cross_file/cross_file.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../asset.dart';


class SchoolHistory extends StatefulWidget {
  const SchoolHistory({super.key});

  @override
  State<SchoolHistory> createState() => _SchoolHistoryState();
}

class _SchoolHistoryState extends State<SchoolHistory> {

  
  final    Map<String, RxBool> _downloadStatus = {};


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 100.w, top: 42.h),
                child: const Navbar(),
              ),
              SizedBox(
                height: 35.h,
              ),
              CustomText(
                  text: "School History",
                  fontsize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
              SizedBox(
                height: 33.h,
              ),
              SizedBox(
                width: 1300.w,
                child: CustomText(
                    text:
                        "Fultala Mohammadia High School is an educational establishment that is located at Torkey islampur (fultala) Bhiti Hogla Munshiganj Sadar Munshiganj. Its Educational Institute Identification Number or EIIN, is 111131. On 01 January, 1980, it was first put into operation. The alternative name for Fultala Mohammadia High School is ফুলতলা মোহাম্মদীয়া উচ্চ বিদ্যালয়. It is a Combined sort of co-educational program. The institution provides education in the following fields: Science, Business Studies, Humanities.Its MPO number is 2903091301. It operates on Day shift(s). Its management is Managing. Its recognition is Recognized by the government and the recognition level is Secondary. The school/college has MPO level with MPO number 2903091301 and the MPO type is Yes. Fultala Mohammadia High School is under Dhaka Education Board.While many other high schools teach numerous disciplines, you can find the major disciplines that they teach in this high school as Science, Business Studies, Humanities. The management type of this institute is Managing. The region in which it is located is Grameen with geographic location as Plain Land. The institute is in the constituency no 169. Average age of the teachers at Fultala Mohammadia High School is 52 years.",
                    fontsize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              SizedBox(height: 46.h),
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
                    height: snapshot.data!.docs.length * 130.h,
                    width: 1300.w,
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final String url = snapshot.data!.docs[index]["url"];
                        final String title = snapshot.data!.docs[index]["title"];
                        final RxBool isDownloading = _downloadStatus[url] ??= false.obs;

                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListTile(
                            tileColor: const Color.fromARGB(255, 91, 174, 243),
                            trailing:  Obx(
                              ()=> isDownloading.value
                                ? const CircularProgressIndicator()
                                : MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: InkWell(
                                        onTap: () => downloadFileWeb(url,"pdfdemo"),
                                        child: const Icon(
                                          Icons.download,
                                          color: Colors.white,
                                        ).moveUpOnHover,
                                      ),
                                    ),
                            ),
                            title: CustomText(
                              text: title,
                              fontsize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 55.h,),
              const NavbarWeb()
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
