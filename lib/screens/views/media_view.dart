import 'package:college_updates/screens/views/pdf_view.dart';
import 'package:college_updates/screens/views/video_view.dart';
import 'package:flutter/material.dart';

class MediaView extends StatelessWidget {
  final Map<String, dynamic> media;

  const MediaView({required this.media, super.key});

  @override
  Widget build(BuildContext context) {
    switch (media['type']) {
      case 'image':
        return Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Image.network(
            media['url'],
            fit: BoxFit.scaleDown,
          ),
        );
      case 'video':
        return VideoPlayerWidget(videoUrl: media['url']);
      case 'pdf':
        return PdfViewWidget(pdfUrl: media['url']);
      default:
        return const Center(
          child: Text('Unsupported media type'),
        );
    }
  }
}
