// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerWidget extends StatefulWidget {
//   final String videoUrl;

//   const VideoPlayerWidget({required this.videoUrl, Key? key}) : super(key: key);

//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
//       ..initialize().then((_) {
//         setState(() {}); // Ensure video gets rendered after initialization
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _controller.value.isInitialized
//         ? Container(
//             color: Colors.black,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Stack(
//                   children: [
//                     AspectRatio(
//                       aspectRatio: _controller.value.aspectRatio,
//                       child: VideoPlayer(_controller),
//                     ),
//                     Positioned(
//                       bottom: 80,
//                       left: 160,
//                       child: IconButton(
//                         icon: Icon(
//                           _isPlaying ? Icons.pause : Icons.play_arrow,
//                           size: 50,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             if (_controller.value.isPlaying) {
//                               _controller.pause();
//                               _isPlaying = false;
//                             } else {
//                               _controller.play();
//                               _isPlaying = true;
//                             }
//                           });
//                         },
//                       ),
//                     )
//                   ],
//                 ),
//                 VideoProgressIndicator(_controller, allowScrubbing: true),
//               ],
//             ),
//           )
//         : Center(child: CircularProgressIndicator());
//   }
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({required this.videoUrl, Key? key}) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _showPlayPauseIcon =
      false; // Controls the visibility of the play/pause icon
  Timer? _hideIconTimer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize();
  }

  void _togglePlayPause() {
    setState(() {
      _showPlayPauseIcon = true; // Show the icon on user interaction
    });

    if (_controller.value.isPlaying) {
      _controller.pause();
      _isPlaying = false;
    } else {
      _controller.play();
      _isPlaying = true;
    }

    // Hide the icon after 2 seconds of user interaction
    _hideIconTimer?.cancel(); // Cancel any previous timer
    _hideIconTimer = Timer(Duration(seconds: 2), () {
      setState(() {
        _showPlayPauseIcon = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _hideIconTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('video-player-${widget.videoUrl}'),
      onVisibilityChanged: (visibilityInfo) {
        try {
          if (visibilityInfo.visibleFraction > 0.5) {
            if (!_controller.value.isPlaying) {
              _controller.play();
              setState(() {
                _isPlaying = true;
              });
            }
          } else {
            if (_controller.value.isPlaying) {
              _controller.pause();
              setState(() {
                _isPlaying = false;
              });
            }
          }
        } catch (e) {
          print(e);
        }
      },
      child: _controller.value.isInitialized
          ? GestureDetector(
              onTap: () => _togglePlayPause(),
              child: Container(
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                        if (_showPlayPauseIcon)
                          Positioned.fill(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_controller.value.isPlaying) {
                                    _controller.pause();
                                    _isPlaying = false;
                                  } else {
                                    _controller.play();
                                    _isPlaying = true;
                                  }
                                });
                              },
                              child: Container(
                                color: Colors.transparent,
                                alignment: Alignment.center,
                                child: Icon(
                                  _isPlaying ? Icons.pause : Icons.play_arrow,
                                  size: 50,
                                  color:
                                      const Color.fromARGB(110, 255, 255, 255),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    VideoProgressIndicator(_controller, allowScrubbing: true),
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
