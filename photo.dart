import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../asset.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';



class PhotoWeb extends StatefulWidget {
  const PhotoWeb({super.key});

  @override
  State<PhotoWeb> createState() => _PhotoWebState();
}

class _PhotoWebState extends State<PhotoWeb> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crosscount = 3;
    double heighfinal = 550.h;

    if (screenWidth > 1600) {
      heighfinal = 550.h;
    }

    if (screenWidth > 1600) {
      crosscount = 4;
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
              SizedBox(
                height: 800.h,
                width: double.infinity,
                child: ImageSlideshow(
                  /// Width of the [ImageSlideshow].
                  width: double.infinity,

                  /// Height of the [ImageSlideshow].
                  height: 800.h,

                  /// The page to show when first creating the [ImageSlideshow].
                  initialPage: 0,

                  /// The color to paint the indicator.
                  indicatorColor: Colors.blue,

                  /// The color to paint behind th indicator.
                  indicatorBackgroundColor: Colors.grey,

                  /// Called whenever the page in the center of the viewport changes.
                  onPageChanged: (value) {
                    // ignore: avoid_print
                    print('Page changed: $value');
                  },

                  /// Auto scroll interval.
                  /// Do not auto scroll with null or 0.
                  autoPlayInterval: 3000,

                  /// Loops back to first slide.
                  isLoop: true,

                  /// The widgets to display in the [ImageSlideshow].
                  /// Add the sample image file into the images folder
                  children: [
                    Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/fultala-5841e.appspot.com/o/school%20photo%2Fschoolpic1.jpg?alt=media&token=42b02d11-10ab-428b-8be0-455c018ed797",
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/fultala-5841e.appspot.com/o/school%20photo%2Fschoolpic2.jpg?alt=media&token=704cccff-bf97-4939-b2ee-da569fcf17cb",
                      fit: BoxFit.cover,
                    ),
                      Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/fultala-5841e.appspot.com/o/school%20photo%2Fschoolpic3.jpg?alt=media&token=1aeb85c2-2d65-479a-b77a-c25de8a946a4",
                      fit: BoxFit.cover,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomText(
                  text: "Photo Gallery",
                  fontsize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
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
                    padding: EdgeInsets.only(left: 30.w, right: 30.w),
                    child: SizedBox(
                      height: snapshot.data!.docs.length/ crosscount * heighfinal,
                      child: GridView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(
                                  left: 10.w,
                                  right: 10.w,
                                  top: 10.h,
                                  bottom: 10.h),
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
                              child: FittedBox(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Container(
                                      height: 240.h,
                                      width: 355.w,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(snapshot
                                                  .data!.docs[index]["url"]),
                                              fit: BoxFit.cover)),
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    CustomText(
                                        text: snapshot.data!.docs[index]
                                            ["title"],
                                        fontsize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)
                                  ],
                                ),
                              ),
                            );
                          },
                          primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 400.w / 307.h,
                                  crossAxisSpacing: 70.w,
                                  mainAxisSpacing: 20.h,
                                  crossAxisCount:
                                      crosscount)),
                    ),
                  );
                },
                stream: FirebaseFirestore.instance
                    .collection('photogallery')
                    .snapshots(),
              ),
              const NavbarWeb()
            ],
          ),
        ),
      ),
    );
  }
}
