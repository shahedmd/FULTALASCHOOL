// ignore_for_file: avoid_web_libraries_in_flutter
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticker_text/ticker_text.dart';
import '../asset.dart';
// ignore: unused_import, 
import 'dart:html' as html;
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class NoticeWeb extends StatefulWidget {
  const NoticeWeb({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NoticeWebState createState() => _NoticeWebState();
}

class _NoticeWebState extends State<NoticeWeb> {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('schoolnoticefinal');
  
  final Map<String, RxBool> _downloadStatus = {};

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
                padding: EdgeInsets.only(left: 120.w, top: 42.h),
                child: const Navbar(),
              ),
              SizedBox(height: 35.h),
              CustomText(
                text: "School Notice",
                fontsize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              SizedBox(height: 10.h),
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
                      height: 90.h,
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
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }

                  return const Text("loading");
                },
              ),
              SizedBox(height: 20.h),
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
              SizedBox(height: 40.h),
              const NavbarWeb(),
            ],
          ),
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
