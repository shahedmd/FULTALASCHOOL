import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fultalaschool/asset.dart';
import 'package:ticker_text/ticker_text.dart';
// ignore: avoid_web_libraries_in_flutter, unused_import
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:cross_file/cross_file.dart';
import 'package:get/get.dart';
import 'asset/asset.dart';
import 'asset/mobilenavbar.dart';

class MobileNoticePage extends StatefulWidget {
  const MobileNoticePage({super.key});

  @override
  State<MobileNoticePage> createState() => _MobileNoticePageState();
}

class _MobileNoticePageState extends State<MobileNoticePage> {


  final Map<String, RxBool> _downloadStatus = {};

  



  CollectionReference users =
      FirebaseFirestore.instance.collection('schoolnoticefinal');
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
                height: 15.h,
              ),
              CustomText(
                  text: "School Notice",
                  fontsize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
              SizedBox(
                height: 15.h,
              ),
              FutureBuilder<DocumentSnapshot>(
                future: users.doc("WhVIOKmgk2iSVHzjnH1b").get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong");
                  }

                  if (snapshot.hasData && !snapshot.data!.exists) {
                    return const Text("Document does not exist");
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return Container(
                      height: 50.h,
                      width: double.infinity,
                      color: const Color(0xff1395F2),
                      child: Center(
                        child: TickerText(
                            scrollDirection: Axis.horizontal,
                            speed: 30,
                            startPauseDuration: const Duration(seconds: 3),
                            endPauseDuration: const Duration(seconds: 3),
                            returnDuration: const Duration(milliseconds: 800),
                            primaryCurve: Curves.linear,
                            returnCurve: Curves.easeOut,
                            child: CustomText(
                                text: data["title"],
                                fontsize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                      ),
                    );
                  }

                  return const Text("loading");
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('schoolnotice')
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









