import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:college_updates/model/post_model.dart';
import 'package:college_updates/screens/post_view.dart';

class MediaPostView extends StatelessWidget {
  const MediaPostView({
    required this.posts,
    required this.mediaType, // Add mediaType parameter
    super.key,
  });

  final List<PostModel> posts;
  final String mediaType; // 'image', 'video', or 'pdf'

  @override
  Widget build(BuildContext context) {
    final filteredPosts = posts.where((post) {
      return post.media.isNotEmpty && post.media[0]['type'] == mediaType;
    }).toList();

    return filteredPosts.isEmpty
        ? Center(
            child: Text('No $mediaType Posts'),
          )
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: filteredPosts.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostViewPage(
                        posts: filteredPosts,
                        postIndex: index,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: mediaType == 'image'
                      ? Image.network(
                          filteredPosts[index].media[0]['url'],
                          fit: BoxFit.cover,
                        )
                      : mediaType == 'video'
                          ? VideoThumbnail(
                              videoUrl: filteredPosts[index].media[0]['url'],
                            )
                          : mediaType == 'pdf'
                              ? PdfThumbnail(
                                  pdfUrl: filteredPosts[index].media[0]['url'],
                                )
                              : Center(
                                  child: Text('Unsupported Media Type'),
                                ),
                ),
              );
            },
          );
  }
}

//video_view.dart
class VideoThumbnail extends StatefulWidget {
  final String videoUrl;

  const VideoThumbnail({required this.videoUrl, super.key});

  @override
  _VideoThumbnailState createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

//pdf view.dart
class PdfThumbnail extends StatelessWidget {
  final String pdfUrl;

  const PdfThumbnail({required this.pdfUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use a placeholder for PDFs or a small PDF thumbnail image if available
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.picture_as_pdf,
          size: 50,
          color: Colors.red,
        ),
        padding: EdgeInsets.all(8),
      ),
    );
  }
}
