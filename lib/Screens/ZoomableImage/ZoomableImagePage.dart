import 'package:flutter/material.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ZoomableImagePage extends StatefulWidget {
  final List<String> images;
  ZoomableImagePage({this.images});
  @override
  _ZoomableImagePageState createState() => _ZoomableImagePageState();
}

class _ZoomableImagePageState extends State<ZoomableImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              color: AppColor.white,
              child: PhotoViewGallery.builder(
                backgroundDecoration: BoxDecoration(color: AppColor.white),
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(this.widget.images[index]),
                    initialScale: PhotoViewComputedScale.contained * 0.8,
                  );
                },
                itemCount: this.widget.images.length,
                loadingBuilder: (context, event) => Center(
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded /
                              event.expectedTotalBytes,
                    ),
                  ),
                ),
              )),
          Positioned(
              top: 25,
              left: 15,
              child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: AppColor.themeColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }))
        ],
      ),
    );
  }
}
