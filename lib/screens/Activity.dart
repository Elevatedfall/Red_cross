/*import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  List<Activity> activities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.jpg'),
                ),
                SizedBox(width: 8),
                Text(
                  'Redcross',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Text(
              'Activities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var activity in activities) _buildActivitySection(activity),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addActivity(),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildActivitySection(Activity activity) {
    final List<Content> imageContents =
        activity.contents.whereType<ImageContent>().toList();
    final List<Content> nonImageContents =
        activity.contents.where((content) => content is! ImageContent).toList();

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                activity.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                onPressed: () => _addContent(activity),
                icon: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 8),
          Stack(
            children: [
              if (imageContents.isNotEmpty) _buildImageContentItem(activity),
            ],
          ),
          if (imageContents.length > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _toggleContent(activity, -1),
                  icon: Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () => _toggleContent(activity, 1),
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < nonImageContents.length; i++)
                _buildContentItem(nonImageContents[i], i),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageContentItem(Activity activity) {
    final currentIndex = activity.currentContentIndex ?? 0;
    final currentContent = activity.contents[currentIndex] as ImageContent;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image(
          image: FileImage(currentContent.imageFile),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildContentItem(Content content, int index) {
    if (content is TextContent) {
      return ListTile(
        title: Text(content.text),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _editTextContent(content),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteContent(index),
            ),
          ],
        ),
      );
    } else if (content is ImageContent) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image(
                image: FileImage(content.imageFile),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteContent(index),
              ),
            ),
          ],
        ),
      );
    } else if (content is VideoContent) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: AspectRatio(
          aspectRatio: content.videoController.value.aspectRatio,
          child: VideoPlayer(content.videoController),
        ),
      );
    } else {
      return Container();
    }
  }

  void _toggleContent(Activity activity, int direction) {
    final currentContentIndex = activity.currentContentIndex ?? 0;
    int nextIndex = currentContentIndex + direction;

    if (nextIndex < 0) {
      nextIndex = activity.contents.length - 1;
    } else if (nextIndex >= activity.contents.length) {
      nextIndex = 0;
    }

    setState(() {
      activity.currentContentIndex = nextIndex;
    });
  }

  void _addActivity() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';

        return AlertDialog(
          title: Text('Add Activity'),
          content: TextField(
            onChanged: (value) {
              title = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  activities.add(
                    Activity(
                      title: title,
                      contents: [], // Initialize contents as an empty list
                    ),
                  );
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addContent(Activity activity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Content'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(FluentIcons.note_20_filled),
                  title: Text('Text Content'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _addTextContent(activity);
                  },
                ),
                ListTile(
                  leading: Icon(FluentIcons.image_24_regular),
                  title: Text('Image Content'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _addImageContent(activity);
                  },
                ),
                ListTile(
                  leading: Icon(FluentIcons.video_clip_24_regular),
                  title: Text('Video Content'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _addVideoContent(activity);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addTextContent(Activity activity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String text = '';

        return AlertDialog(
          title: Text('Add Text Content'),
          content: TextField(
            onChanged: (value) {
              text = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  activity.contents.add(
                    TextContent(text: text),
                  );
                  if (activity.contents.length == 1) {
                    activity.currentContentIndex = 0;
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editTextContent(TextContent content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String updatedText = content.text;

        return AlertDialog(
          title: Text('Edit Text Content'),
          content: TextField(
            onChanged: (value) {
              updatedText = value;
            },
            controller: TextEditingController(text: content.text),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  content.text = updatedText;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _addImageContent(Activity activity) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        activity.contents.add(
          ImageContent(imageFile: File(pickedFile.path)),
        );
        if (activity.contents.length == 1) {
          activity.currentContentIndex = 0;
        }
      });
    }
  }

  void _addVideoContent(Activity activity) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      final videoController = VideoPlayerController.file(File(pickedFile.path));
      await videoController.initialize();

      setState(() {
        activity.contents.add(
          VideoContent(
            videoFile: File(pickedFile.path),
            videoController: videoController,
          ),
        );
        if (activity.contents.length == 1) {
          activity.currentContentIndex = 0;
        }
      });
    }
  }

  void _deleteContent(int index) {
    setState(() {
      for (var activity in activities) {
        if (activity.currentContentIndex != null &&
            activity.currentContentIndex! >= index) {
          activity.currentContentIndex = activity.currentContentIndex! - 1;
        }
      }
      activities.forEach((activity) {
        activity.contents.removeAt(index);
      });
    });
  }
}

class Activity {
  String title;
  List<Content> contents;
  int? currentContentIndex;

  Activity({
    required this.title,
    required this.contents,
    this.currentContentIndex,
  });
}

abstract class Content {}

class TextContent extends Content {
  String text;

  TextContent({required this.text});
}

class ImageContent extends Content {
  File imageFile;

  ImageContent({required this.imageFile});
}

class VideoContent extends Content {
  File videoFile;
  VideoPlayerController videoController;

  VideoContent({required this.videoFile, required this.videoController});
}

void main() {
  runApp(MaterialApp(
    title: 'Activity App',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: ActivityPage(),
  ));
}
*/

/*import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityPage extends StatefulWidget {
  final String subBranchId;

  ActivityPage({required this.subBranchId});

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  List<Activity> activities = [];

  @override
  void initState() {
    super.initState();
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    final collectionRef = FirebaseFirestore.instance.collection('Activities');
    final querySnapshot = await collectionRef
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final List<Activity> fetchedActivities = [];

      for (final docSnapshot in querySnapshot.docs) {
        final activity = Activity.fromSnapshot(docSnapshot);
        fetchedActivities.add(activity);
      }

      setState(() {
        activities = fetchedActivities;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Page'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  String title = '';

                  return AlertDialog(
                    title: Text('Add Activity'),
                    content: TextField(
                      onChanged: (value) {
                        title = value;
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          final activity = Activity(title: title);
                          await addActivity(activity);
                          Navigator.of(context).pop();
                        },
                        child: Text('Add'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Add Activity'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                final List<Content> contents = activity.contents;

                return Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            activity.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          IconButton(
                            onPressed: () => _addContent(activity),
                            icon: Icon(Icons.add),
                          ),
                          IconButton(
                            onPressed: () => deleteActivity(activity),
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      if (contents.isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: contents.length,
                          itemBuilder: (context, index) {
                            final content = contents[index];

                            if (content is TextContent) {
                              return ListTile(
                                title: Text(content.text),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () =>
                                          _editTextContent(activity, content),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () =>
                                          _deleteContent(activity, content),
                                    ),
                                  ],
                                ),
                              );
                            } else if (content is ImageContent) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: Image.network(content.imageUrl),
                              );
                            } else if (content is VideoContent) {
                              final videoController =
                                  VideoPlayerController.network(
                                content.videoUrl,
                              );

                              return FutureBuilder(
                                future: videoController.initialize(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 8),
                                      child: AspectRatio(
                                        aspectRatio: videoController
                                            .value.aspectRatio,
                                        child: VideoPlayer(videoController),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addActivity(Activity activity) async {
    final collectionRef =
        FirebaseFirestore.instance.collection('Activities');
    final docRef = await collectionRef.add(activity.toMap());
    activity.id = docRef.id;

    setState(() {
      activities.add(activity);
    });
  }

  Future<void> deleteActivity(Activity activity) async {
    final collectionRef =
        FirebaseFirestore.instance.collection('Activities');
    await collectionRef.doc(activity.id).delete();

    setState(() {
      activities.remove(activity);
    });
  }

  void _addContent(Activity activity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Content'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(FluentIcons.note_20_filled),
                  title: Text('Text Content'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _addTextContent(activity);
                  },
                ),
                ListTile(
                  leading: Icon(FluentIcons.image_24_regular),
                  title: Text('Image Content'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _addImageContent(activity);
                  },
                ),
                ListTile(
                  leading: Icon(FluentIcons.video_clip_24_regular),
                  title: Text('Video Content'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _addVideoContent(activity);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addTextContent(Activity activity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String text = '';

        return AlertDialog(
          title: Text('Add Text Content'),
          content: TextField(
            onChanged: (value) {
              text = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  final content = TextContent(text: text);
                  activity.contents.add(content);
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editTextContent(Activity activity, TextContent content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String updatedText = content.text;

        return AlertDialog(
          title: Text('Edit Text Content'),
          content: TextField(
            onChanged: (value) {
              updatedText = value;
            },
            controller: TextEditingController(text: content.text),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  content.text = updatedText;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _addImageContent(Activity activity) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Image Content'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.file(file),
                  SizedBox(height: 8),
                  Text('Upload Image?'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  final imageUrl = await uploadFile(file);
                  if (imageUrl != null) {
                    setState(() {
                      final content = ImageContent(imageUrl: imageUrl);
                      activity.contents.add(content);
                    });
                  }
                },
                child: Text('Upload'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    final content = ImageContent(fileUrl: file.path);
                    activity.contents.add(content);
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Add without Uploading'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<String?> uploadFile(File file) async {
    final storageRef = FirebaseStorage.instance.ref().child('activity_images/${DateTime.now().microsecondsSinceEpoch}');
    final uploadTask = storageRef.putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});
    if (snapshot.state == TaskState.success) {
      final downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    }
    return null;
  }

  void _addVideoContent(Activity activity) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Video Content'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: VideoPlayerWidget(file: file),
                  ),
                  SizedBox(height: 8),
                  Text('Upload Video?'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  final videoUrl = await uploadFile(file);
                  if (videoUrl != null) {
                    setState(() {
                      final content = VideoContent(videoUrl: videoUrl);
                      activity.contents.add(content);
                    });
                  }
                },
                child: Text('Upload'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    final content = VideoContent(fileUrl: file.path);
                    activity.contents.add(content);
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Add without Uploading'),
              ),
            ],
          );
        },
      );
    }
  }

  void _deleteContent(Activity activity, Content content) {
    setState(() {
      activity.contents.remove(content);
    });
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final File file;

  VideoPlayerWidget({required this.file});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitialized) {
      return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class Activity {
  String id;
  String title;
  List<Content> contents;

  Activity({
    required this.id,
    required this.title,
    required this.contents,
  });

  factory Activity.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final id = snapshot.id;
    final title = data['title'] as String;
    final contentsData = data['contents'] as List<dynamic>;

    final contents = contentsData.map((contentData) {
      final type = contentData['type'] as String;

      if (type == 'text') {
        return TextContent(text: contentData['text'] as String);
      } else if (type == 'image') {
        return ImageContent(imageUrl: contentData['imageUrl'] as String);
      } else if (type == 'video') {
        return VideoContent(videoUrl: contentData['videoUrl'] as String);
      } else {
        return null;
      }
    }).toList();

    contents.removeWhere((content) => content == null);

    return Activity(
      id: id,
      title: title,
      contents: contents,
    );
  }

  Map<String, dynamic> toMap() {
    final contentsData = contents.map((content) {
      if (content is TextContent) {
        return {
          'type': 'text',
          'text': content.text,
        };
      } else if (content is ImageContent) {
        return {
          'type': 'image',
          'imageUrl': content.imageUrl,
        };
      } else if (content is VideoContent) {
        return {
          'type': 'video',
          'videoUrl': content.videoUrl,
        };
      } else {
        return null;
      }
    }).toList();

    return {
      'title': title,
      'contents': contentsData,
    };
  }
}

abstract class Content {}

class TextContent extends Content {
  String text;

  TextContent({required this.text});
}

class ImageContent extends Content {
  String imageUrl;

  ImageContent({required this.imageUrl});
}

class VideoContent extends Content {
  String videoUrl;

  VideoContent({required this.videoUrl});
}

void main() {
  runApp(MaterialApp(
    title: 'Activity App',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: ActivityPage(subBranchId: 'your_subbranch_id_here'),
  ));
}
*/

/*import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ActivityPage extends StatefulWidget {
  final String subBranchId;

  ActivityPage({required this.subBranchId});

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  List<Activity> activities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.jpg'),
                ),
                SizedBox(width: 8),
                Text(
                  'Redcross',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Text(
              'Activities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var activity in activities) _buildActivitySection(activity),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addActivity(),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildActivitySection(Activity activity) {
    final List<Content> imageContents =
        activity.contents.whereType<ImageContent>().toList();
    final List<Content> nonImageContents =
        activity.contents.where((content) => content is! ImageContent).toList();

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                activity.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                onPressed: () => _addContent(activity),
                icon: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 8),
          Stack(
            children: [
              if (imageContents.isNotEmpty) _buildImageContentItem(activity),
            ],
          ),
          if (imageContents.length > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _toggleContent(activity, -1),
                  icon: Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () => _toggleContent(activity, 1),
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < nonImageContents.length; i++)
                _buildContentItem(nonImageContents[i], i),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageContentItem(Activity activity) {
    final currentIndex = activity.currentContentIndex ?? 0;
    final currentContent = activity.contents[currentIndex] as ImageContent;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image(
          image: FileImage(currentContent.imageFile),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildContentItem(Content content, int index) {
    if (content is TextContent) {
      return ListTile(
        title: Text(content.text),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _editTextContent(content),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteContent(index),
            ),
          ],
        ),
      );
    } else if (content is ImageContent) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image(
                image: FileImage(content.imageFile),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteContent(index),
              ),
            ),
          ],
        ),
      );
    } else if (content is VideoContent) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: AspectRatio(
          aspectRatio: content.videoController.value.aspectRatio,
          child: VideoPlayer(content.videoController),
        ),
      );
    } else {
      return Container();
    }
  }

  void _toggleContent(Activity activity, int direction) {
    final currentContentIndex = activity.currentContentIndex ?? 0;
    int nextIndex = currentContentIndex + direction;

    if (nextIndex < 0) {
      nextIndex = activity.contents.length - 1;
    } else if (nextIndex >= activity.contents.length) {
      nextIndex = 0;
    }

    setState(() {
      activity.currentContentIndex = nextIndex;
    });
  }

  void _addActivity() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';

        return AlertDialog(
          title: Text('Add Activity'),
          content: TextField(
            onChanged: (value) {
              title = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  activities.add(
                    Activity(
                      title: title,
                      contents: [], // Initialize contents as an empty list
                    ),
                  );
                });

                // Add the activity to the Firestore collection
                FirebaseFirestore.instance
                    .collection(
                        'Activities') // Replace 'Activities' with your desired collection name
                    .add({
                  'title': title,
                  'contents':
                      [], // Initialize contents as an empty list in Firestore as well
                });

                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addContent(Activity activity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Content'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(FluentIcons.note_20_filled),
                  title: Text('Text Content'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _addTextContent(activity);
                  },
                ),
                ListTile(
                  leading: Icon(FluentIcons.image_24_regular),
                  title: Text('Image Content'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _addImageContent(activity);
                  },
                ),
                ListTile(
                  leading: Icon(FluentIcons.video_24_regular),
                  title: Text('Video Content'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _addVideoContent(activity);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addTextContent(Activity activity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String text = '';

        return AlertDialog(
          title: Text('Add Text Content'),
          content: TextField(
            onChanged: (value) {
              text = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  activity.contents.add(TextContent(text: text));
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editTextContent(TextContent content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newText = content.text;

        return AlertDialog(
          title: Text('Edit Text Content'),
          content: TextField(
            onChanged: (value) {
              newText = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  content.text = newText;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _addImageContent(Activity activity) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);

      setState(() {
        activity.contents.add(ImageContent(imageFile: imageFile));
      });
    }
  }

  void _addVideoContent(Activity activity) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      final videoFile = File(pickedFile.path);
      final videoController = VideoPlayerController.file(videoFile);

      await videoController.initialize();

      setState(() {
        activity.contents.add(
          VideoContent(videoFile: videoFile, videoController: videoController),
        );
      });

      videoController.play();
    }
  }

  void _deleteContent(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Content'),
          content: Text('Are you sure you want to delete this content?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  activities.forEach((activity) {
                    if (activity.currentContentIndex != null &&
                        activity.currentContentIndex! > index) {
                      activity.currentContentIndex =
                          activity.currentContentIndex! - 1;
                    }
                  });
                  activities.forEach((activity) {
                    activity.contents.removeAt(index);
                  });
                });
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }
}

class Activity {
  final String title;
  final List<Content> contents;
  int? currentContentIndex;

  Activity({required this.title, required this.contents});
}

abstract class Content {}

class TextContent extends Content {
  String text;

  TextContent({required this.text});
}

class ImageContent extends Content {
  File imageFile;

  ImageContent({required this.imageFile});
}

class VideoContent extends Content {
  File videoFile;
  VideoPlayerController videoController;

  VideoContent({required this.videoFile, required this.videoController});
}

*/

/*import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityPage extends StatefulWidget {
  final String subBranchId;

  ActivityPage({required this.subBranchId}) : super();

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  List<Activity> activities = [];

  @override
  void initState() {
    super.initState();
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('Activities')
          .where('subBranchId', isEqualTo: widget.subBranchId)
          .get();

      List<Activity> fetchedActivities = [];
      querySnapshot.docs.forEach((doc) {
        Activity activity =
            Activity.fromSnapshot(doc, subBranchId: widget.subBranchId);
        fetchedActivities.add(activity);
      });

      setState(() {
        activities = fetchedActivities;
      });
    } catch (e) {
      print('Error fetching activities: $e');
    }
  }

  Future<void> addActivity(Activity activity) async {
    try {
      await firestore.collection('Activities').add(activity.toMap());
    } catch (e) {
      print('Error adding activity: $e');
    }
  }

  Future<void> addImageContent(Activity activity) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String? imageUrl = await uploadImage(File(pickedFile.path)) ?? '';
      if (imageUrl != null) {
        setState(() {
          activity.contents.add(ImageContent(imageUrl: imageUrl));
        });
      }
    }
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = reference.putFile(imageFile);
      TaskSnapshot storageTaskSnapshot = await uploadTask;
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Widget _buildActivitySection(Activity activity) {
    final List<ImageContent> imageContents =
        activity.contents.whereType<ImageContent>().toList();
    final List<Content> nonImageContents =
        activity.contents.where((content) => content is! ImageContent).toList();

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                activity.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                onPressed: () => _addContent(activity),
                icon: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 8),
          Stack(
            children: [
              if (imageContents.isNotEmpty)
                _buildImageContentItem(imageContents.first),
            ],
          ),
          if (imageContents.length > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _toggleContent(activity, -1),
                  icon: Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () => _toggleContent(activity, 1),
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < nonImageContents.length; i++)
                _buildContentItem(nonImageContents[i], i),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageContentItem(ImageContent content) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(
          content.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildContentItem(Content content, int index) {
    if (content is TextContent) {
      return ListTile(
        title: Text(content.text),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _editTextContent(content),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteContent(index),
            ),
          ],
        ),
      );
    } else if (content is ImageContent) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                content.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteContent(index),
              ),
            ),
          ],
        ),
      );
    } else if (content is VideoContent) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: VideoPlayer(content.videoController),
        ),
      );
    }
    return SizedBox.shrink();
  }

  Future<void> _addContent(Activity activity) async {
    final result = await showDialog(
      context: context,
      builder: (context) => AddContentDialog(),
    );

    if (result != null && result is Content) {
      setState(() {
        activity.contents.add(result);
      });
    }
  }

  void _editTextContent(TextContent content) {
    showDialog(
      context: context,
      builder: (context) => EditTextContentDialog(
        initialText: content.text,
        onTextSaved: (newText) {
          setState(() {
            content.text = newText;
          });
        },
      ),
    );
  }

  void _deleteContent(int index) {
    setState(() {
      activities[index].contents.removeAt(index);
    });
  }

  void _toggleContent(Activity activity, int direction) {
    final List<ImageContent> imageContents =
        activity.contents.whereType<ImageContent>().toList();

    int currentImageIndex = imageContents.indexOf(activity.currentImageContent);
    int nextImageIndex = (currentImageIndex + direction) % imageContents.length;

    setState(() {
      activity.currentImageContent = imageContents[nextImageIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var activity in activities) _buildActivitySection(activity),
          ],
        ),
      ),
    );
  }
}

class Activity {
  String title;
  List<Content> contents;
  ImageContent currentImageContent;
  String subBranchId;

  Activity({
    required this.title,
    required this.contents,
    required this.currentImageContent,
    required this.subBranchId,
  });

  Activity.fromSnapshot(DocumentSnapshot snapshot, {required this.subBranchId})
      : title = snapshot['title'],
        contents = _parseContents(snapshot['contents']),
        currentImageContent = _parseCurrentImageContent(
            snapshot['currentImageContent'],
            _parseContents(snapshot['contents']));

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'contents': _serializeContents(contents),
      'currentImageContent': _serializeCurrentImageContent(currentImageContent),
      'subBranchId': subBranchId,
    };
  }

  static List<Content> _parseContents(List<dynamic>? contentData) {
    if (contentData == null) return [];

    return contentData.map<Content>((data) {
      if (data['type'] == 'text') {
        return TextContent(text: data['text'] ?? '');
      } else if (data['type'] == 'image') {
        return ImageContent(imageUrl: data['imageUrl'] ?? '');
      } else if (data['type'] == 'video') {
        return VideoContent(videoUrl: data['videoUrl'] ?? '');
      }
      return TextContent(text: ''); // Add a default return statement
    }).toList();
  }

  static ImageContent _parseCurrentImageContent(
      String imageUrl, List<Content> contents) {
    if (imageUrl.isEmpty || contents.isEmpty) {
      return ImageContent(imageUrl: '');
    }

    return contents.firstWhere(
      (content) => content is ImageContent && content.imageUrl == imageUrl,
      orElse: () => ImageContent(imageUrl: ''),
    ) as ImageContent;
  }

  static List<Map<String, String>?> _serializeContents(
      List<Content?> contents) {
    return contents.where((content) => content != null).map((content) {
      if (content is TextContent) {
        return {
          'type': 'text',
          'text': content.text,
        };
      } else if (content is ImageContent) {
        return {
          'type': 'image',
          'imageUrl': content.imageUrl,
        };
      } else if (content is VideoContent) {
        return {
          'type': 'video',
          'videoUrl': content.videoUrl,
        };
      }
      return null;
    }).toList();
  }

  static String _serializeCurrentImageContent(
      ImageContent currentImageContent) {
    if (currentImageContent == null || currentImageContent.imageUrl.isEmpty) {
      return ''; // Return an empty string if no current image content
    }

    return currentImageContent.imageUrl;
  }
}

abstract class Content {}

class TextContent extends Content {
  String text;

  TextContent({required this.text});
}

class ImageContent extends Content {
  String imageUrl;

  ImageContent({required this.imageUrl});
}

class VideoContent extends Content {
  String videoUrl;
  VideoPlayerController videoController;

  VideoContent({required this.videoUrl})
      : videoController = VideoPlayerController.network(videoUrl);
}

class AddContentDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Add Content'),
      children: [
        ListTile(
          leading: Icon(Icons.text_fields),
          title: Text('Text'),
          onTap: () => Navigator.pop(context, TextContent(text: '')),
        ),
        ListTile(
          leading: Icon(Icons.photo),
          title: Text('Image'),
          onTap: () => Navigator.pop(context, ImageContent(imageUrl: '')),
        ),
        ListTile(
          leading: Icon(Icons.videocam),
          title: Text('Video'),
          onTap: () => Navigator.pop(context, VideoContent(videoUrl: '')),
        ),
      ],
    );
  }
}

class EditTextContentDialog extends StatefulWidget {
  final String initialText;
  final ValueChanged<String> onTextSaved;

  EditTextContentDialog({required this.initialText, required this.onTextSaved});

  @override
  _EditTextContentDialogState createState() => _EditTextContentDialogState();
}

class _EditTextContentDialogState extends State<EditTextContentDialog> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Text'),
      content: TextField(
        controller: _textEditingController,
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onTextSaved(_textEditingController.text);
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
*/

/*import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityPage extends StatefulWidget {
  final String subBranchId;

  ActivityPage({required this.subBranchId}) : super();

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  List<Activity> activities = [];

  @override
  void initState() {
    super.initState();
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('Activities')
          .where('subBranchId', isEqualTo: widget.subBranchId)
          .get();

      List<Activity> fetchedActivities = [];
      querySnapshot.docs.forEach((doc) {
        Activity activity =
            Activity.fromSnapshot(doc, subBranchId: widget.subBranchId);
        fetchedActivities.add(activity);
      });

      setState(() {
        activities = fetchedActivities;
      });
    } catch (e) {
      print('Error fetching activities: $e');
    }
  }

  Future<void> addActivity(Activity activity) async {
    try {
      await firestore.collection('Activities').add(activity.toMap());
    } catch (e) {
      print('Error adding activity: $e');
    }
  }

  Future<void> addImageContent(Activity activity) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String? imageUrl = await uploadImage(File(pickedFile.path)) ?? '';
      if (imageUrl != null) {
        setState(() {
          activity.contents.add(ImageContent(imageUrl: imageUrl));
        });
      }
    }
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = reference.putFile(imageFile);
      TaskSnapshot storageTaskSnapshot = await uploadTask;
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Widget _buildActivitySection(Activity activity) {
    final List<ImageContent> imageContents =
        activity.contents.whereType<ImageContent>().toList();
    final List<Content> nonImageContents =
        activity.contents.where((content) => content is! ImageContent).toList();

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                activity.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                onPressed: () => _addContent(activity),
                icon: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 8),
          Stack(
            children: [
              if (imageContents.isNotEmpty)
                _buildImageContentItem(imageContents.first),
            ],
          ),
          if (imageContents.length > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _toggleContent(activity, -1),
                  icon: Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () => _toggleContent(activity, 1),
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < nonImageContents.length; i++)
                _buildContentItem(nonImageContents[i], i),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageContentItem(ImageContent content) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(
          content.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildContentItem(Content content, int index) {
    if (content is TextContent) {
      return ListTile(
        title: Text(content.text),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _editTextContent(content),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteContent(index),
            ),
          ],
        ),
      );
    } else if (content is ImageContent) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                content.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteContent(index),
              ),
            ),
          ],
        ),
      );
    } else if (content is VideoContent) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: VideoPlayer(content.videoController),
        ),
      );
    }
    return SizedBox.shrink();
  }

  Future<void> _addContent(Activity activity) async {
    final result = await showDialog(
      context: context,
      builder: (context) => AddContentDialog(),
    );

    if (result != null && result is Content) {
      setState(() {
        activity.contents.add(result);
      });
    }
  }

  void _editTextContent(TextContent content) {
    showDialog(
      context: context,
      builder: (context) => EditTextContentDialog(
        initialText: content.text,
        onTextSaved: (newText) {
          setState(() {
            content.text = newText;
          });
        },
      ),
    );
  }

  void _deleteContent(int index) {
    setState(() {
      activities[index].contents.removeAt(index);
    });
  }

  void _toggleContent(Activity activity, int direction) {
    final List<ImageContent> imageContents =
        activity.contents.whereType<ImageContent>().toList();

    int currentImageIndex = imageContents.indexOf(activity.currentImageContent);
    int nextImageIndex = (currentImageIndex + direction) % imageContents.length;

    setState(() {
      activity.currentImageContent = imageContents[nextImageIndex];
    });
  }


void _addActivity() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String title = '';

      return AlertDialog(
        title: Text('Add Activity'),
        content: TextField(
          onChanged: (value) {
            title = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (title.isNotEmpty) {
                setState(() {
                  activities.add(
                    Activity(
                      title: title,
                      contents: [], // Initialize contents as an empty list
                    ),
                  );
                });

                // Add the activity to the Firestore collection
                FirebaseFirestore.instance
                    .collection('Activities') // Replace 'Activities' with your desired collection name
                    .add({
                  'title': title,
                  'contents': [], // Initialize contents as an empty list in Firestore as well
                });

                Navigator.of(context).pop();
              }
            },
            child: Text('Add'),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.jpg'),
                ),
                SizedBox(width: 8),
                Text(
                  'Redcross',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Text(
              'Activities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var activity in activities) _buildActivitySection(activity),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Activity newActivity = Activity(
            title: 'New Activity',
            contents: [],
            currentImageContent: ImageContent(imageUrl: ''),
            subBranchId: widget.subBranchId,
          );
          addActivity(newActivity);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Activity {
  String title;
  List<Content> contents;
  ImageContent currentImageContent;
  String subBranchId;

  Activity({
    required this.title,
    required this.contents,
    required this.currentImageContent,
    required this.subBranchId,
  });

  Activity.fromSnapshot(DocumentSnapshot snapshot, {required this.subBranchId})
      : title = snapshot['title'],
        contents = _parseContents(snapshot['contents']),
        currentImageContent = _parseCurrentImageContent(
            snapshot['currentImageContent'],
            _parseContents(snapshot['contents']));

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'contents': _serializeContents(contents),
      'currentImageContent': _serializeCurrentImageContent(currentImageContent),
      'subBranchId': subBranchId,
    };
  }

  static List<Content> _parseContents(List<dynamic>? contentData) {
    if (contentData == null) return [];

    return contentData.map<Content>((data) {
      if (data['type'] == 'text') {
        return TextContent(text: data['text'] ?? '');
      } else if (data['type'] == 'image') {
        return ImageContent(imageUrl: data['imageUrl'] ?? '');
      } else if (data['type'] == 'video') {
        return VideoContent(videoUrl: data['videoUrl'] ?? '');
      }
      return TextContent(text: ''); // Add a default return statement
    }).toList();
  }

  static ImageContent _parseCurrentImageContent(
      String imageUrl, List<Content> contents) {
    if (imageUrl.isEmpty || contents.isEmpty) {
      return ImageContent(imageUrl: '');
    }

    return contents.firstWhere(
      (content) => content is ImageContent && content.imageUrl == imageUrl,
      orElse: () => ImageContent(imageUrl: ''),
    ) as ImageContent;
  }

  static List<Map<String, String>?> _serializeContents(
      List<Content?> contents) {
    return contents.where((content) => content != null).map((content) {
      if (content is TextContent) {
        return {
          'type': 'text',
          'text': content.text,
        };
      } else if (content is ImageContent) {
        return {
          'type': 'image',
          'imageUrl': content.imageUrl,
        };
      } else if (content is VideoContent) {
        return {
          'type': 'video',
          'videoUrl': content.videoUrl,
        };
      }
      return null;
    }).toList();
  }

  static String _serializeCurrentImageContent(
      ImageContent currentImageContent) {
    if (currentImageContent == null || currentImageContent.imageUrl.isEmpty) {
      return ''; // Return an empty string if no current image content
    }

    return currentImageContent.imageUrl;
  }
}

abstract class Content {}

class TextContent extends Content {
  String text;

  TextContent({required this.text});
}

class ImageContent extends Content {
  String imageUrl;

  ImageContent({required this.imageUrl});
}

class VideoContent extends Content {
  String videoUrl;
  VideoPlayerController videoController;

  VideoContent({required this.videoUrl})
      : videoController = VideoPlayerController.network(videoUrl);
}

class AddContentDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Add Content'),
      children: [
        ListTile(
          leading: Icon(Icons.text_fields),
          title: Text('Text'),
          onTap: () => Navigator.pop(context, TextContent(text: '')),
        ),
        ListTile(
          leading: Icon(Icons.photo),
          title: Text('Image'),
          onTap: () => Navigator.pop(context, ImageContent(imageUrl: '')),
        ),
        ListTile(
          leading: Icon(Icons.videocam),
          title: Text('Video'),
          onTap: () => Navigator.pop(context, VideoContent(videoUrl: '')),
        ),
      ],
    );
  }
}

class EditTextContentDialog extends StatefulWidget {
  final String initialText;
  final ValueChanged<String> onTextSaved;

  EditTextContentDialog({required this.initialText, required this.onTextSaved});

  @override
  _EditTextContentDialogState createState() => _EditTextContentDialogState();
}

class _EditTextContentDialogState extends State<EditTextContentDialog> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Text'),
      content: TextField(
        controller: _textEditingController,
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onTextSaved(_textEditingController.text);
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
*/

/*import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityPage extends StatefulWidget {
  final String subBranchId;

  ActivityPage({required this.subBranchId}) : super();

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  List<Activity> activities = [];

  @override
  void initState() {
    super.initState();
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('Activities')
          .where('subBranchId', isEqualTo: widget.subBranchId)
          .get();

      List<Activity> fetchedActivities = [];
      querySnapshot.docs.forEach((doc) {
        Activity activity =
            Activity.fromSnapshot(doc, subBranchId: widget.subBranchId);
        fetchedActivities.add(activity);
      });

      setState(() {
        activities = fetchedActivities;
      });
    } catch (e) {
      print('Error fetching activities: $e');
    }
  }

  Future<void> addActivity(Activity activity) async {
    try {
      await firestore.collection('Activities').add(activity.toMap());
    } catch (e) {
      print('Error adding activity: $e');
    }
  }

  Future<void> addImageContent(Activity activity) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String? imageUrl = await uploadImage(File(pickedFile.path)) ?? '';
      if (imageUrl != null) {
        setState(() {
          activity.contents.add(ImageContent(imageUrl: imageUrl));
        });
      }
    }
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = reference.putFile(imageFile);
      TaskSnapshot storageTaskSnapshot = await uploadTask;
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  void _addActivity() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';

        return AlertDialog(
          title: Text('Add Activity'),
          content: TextField(
            onChanged: (value) {
              title = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (title.isNotEmpty) {
                  setState(() {
                    activities.add(
                      Activity(
                        title: title,
                        contents: [],
                        currentImageContent:
                            ImageContent(imageUrl: ''), // Add this line
                        subBranchId: '', // Add your desired subBranchId here
                      ),
                    );
                  });

                  // Add the activity to the Firestore collection
                  FirebaseFirestore.instance
                      .collection(
                          'Activities') // Replace 'Activities' with your desired collection name
                      .add({
                    'title': title,
                    'contents':
                        [], // Initialize contents as an empty list in Firestore as well
                  });

                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildActivitySection(Activity activity) {
    final List<ImageContent> imageContents =
        activity.contents.whereType<ImageContent>().toList();
    final List<Content> nonImageContents =
        activity.contents.where((content) => content is! ImageContent).toList();

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                activity.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                onPressed: () => _addContent(activity),
                icon: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 8),
          Stack(
            children: [
              if (imageContents.isNotEmpty)
                _buildImageContentItem(imageContents.first),
            ],
          ),
          if (imageContents.length > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _toggleContent(activity, -1),
                  icon: Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () => _toggleContent(activity, 1),
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < nonImageContents.length; i++)
                _buildContentItem(nonImageContents[i], i),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageContentItem(ImageContent content) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(
          content.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildContentItem(Content content, int index) {
    if (content is TextContent) {
      return ListTile(
        title: Text(content.text),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _editTextContent(content),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteContent(index),
            ),
          ],
        ),
      );
    } else if (content is ImageContent) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                content.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteContent(index),
              ),
            ),
          ],
        ),
      );
    } else if (content is VideoContent) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: VideoPlayer(content.videoController),
        ),
      );
    }
    return SizedBox.shrink();
  }

  Future<void> _addContent(Activity activity) async {
    final result = await showDialog(
      context: context,
      builder: (context) => AddContentDialog(),
    );

    if (result != null && result is Content) {
      setState(() {
        activity.contents.add(result);
      });
    }
  }

  void _editTextContent(TextContent content) {
    showDialog(
      context: context,
      builder: (context) => EditTextContentDialog(
        initialText: content.text,
        onTextSaved: (newText) {
          setState(() {
            content.text = newText;
          });
        },
      ),
    );
  }

  void _deleteContent(int index) {
    setState(() {
      activities[index].contents.removeAt(index);
    });
  }

  void _toggleContent(Activity activity, int direction) {
    final List<ImageContent> imageContents =
        activity.contents.whereType<ImageContent>().toList();

    int currentImageIndex = imageContents.indexOf(activity.currentImageContent);
    int nextImageIndex = (currentImageIndex + direction) % imageContents.length;

    setState(() {
      activity.currentImageContent = imageContents[nextImageIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.jpg'),
                ),
                SizedBox(width: 8),
                Text(
                  'Redcross',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Text(
              'Activities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var activity in activities) _buildActivitySection(activity),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addActivity,
        child: Icon(Icons.add),
      ),
    );
  }
}



class Activity {
  String title;
  List<Content> contents;
  ImageContent currentImageContent;
  String subBranchId;

  Activity({
    required this.title,
    required this.contents,
    required this.currentImageContent,
    required this.subBranchId,
  });

  Activity.fromSnapshot(DocumentSnapshot snapshot, {required this.subBranchId})
      : title = snapshot['title'],
        contents = _parseContents(snapshot['contents']),
        currentImageContent = _parseCurrentImageContent(
            snapshot['currentImageContent'],
            _parseContents(snapshot['contents']));

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'contents': _serializeContents(contents),
      'currentImageContent': _serializeCurrentImageContent(currentImageContent),
      'subBranchId': subBranchId,
    };
  }

  

  static List<Content> _parseContents(List<dynamic>? contentData) {
    if (contentData == null) return [];

    return contentData.map<Content>((data) {
      if (data['type'] == 'text') {
        return TextContent(text: data['text'] ?? '');
      } else if (data['type'] == 'image') {
        return ImageContent(imageUrl: data['imageUrl'] ?? '');
      } else if (data['type'] == 'video') {
        return VideoContent(videoUrl: data['videoUrl'] ?? '');
      }
      return TextContent(text: ''); // Add a default return statement
    }).toList();
  }

  static ImageContent _parseCurrentImageContent(
      String imageUrl, List<Content> contents) {
    if (imageUrl.isEmpty || contents.isEmpty) {
      return ImageContent(imageUrl: '');
    }

    return contents.firstWhere(
      (content) => content is ImageContent && content.imageUrl == imageUrl,
      orElse: () => ImageContent(imageUrl: ''),
    ) as ImageContent;
  }

  static List<Map<String, String>?> _serializeContents(
      List<Content?> contents) {
    return contents.where((content) => content != null).map((content) {
      if (content is TextContent) {
        return {
          'type': 'text',
          'text': content.text,
        };
      } else if (content is ImageContent) {
        return {
          'type': 'image',
          'imageUrl': content.imageUrl,
        };
      } else if (content is VideoContent) {
        return {
          'type': 'video',
          'videoUrl': content.videoUrl,
        };
      }
      return null;
    }).toList();
  }

  static String _serializeCurrentImageContent(
      ImageContent currentImageContent) {
    if (currentImageContent == null || currentImageContent.imageUrl.isEmpty) {
      return ''; // Return an empty string if no current image content
    }

    return currentImageContent.imageUrl;
  }
}

abstract class Content {}

class TextContent extends Content {
  String text;

  TextContent({required this.text});
}

class ImageContent extends Content {
  String imageUrl;

  ImageContent({required this.imageUrl});
}

class VideoContent extends Content {
  String videoUrl;
  VideoPlayerController videoController;

  VideoContent({required this.videoUrl})
      : videoController = VideoPlayerController.network(videoUrl);
}

class AddContentDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Add Content'),
      children: [
        ListTile(
          leading: Icon(Icons.text_fields),
          title: Text('Text'),
          onTap: () => Navigator.pop(context, TextContent(text: '')),
        ),
        ListTile(
          leading: Icon(Icons.photo),
          title: Text('Image'),
          onTap: () => Navigator.pop(context, ImageContent(imageUrl: '')),
        ),
        ListTile(
          leading: Icon(Icons.videocam),
          title: Text('Video'),
          onTap: () => Navigator.pop(context, VideoContent(videoUrl: '')),
        ),
      ],
    );
  }
}

class EditTextContentDialog extends StatefulWidget {
  final String initialText;
  final ValueChanged<String> onTextSaved;

  EditTextContentDialog({required this.initialText, required this.onTextSaved});

  @override
  _EditTextContentDialogState createState() => _EditTextContentDialogState();
}

class AddTextContentDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String text = '';

    return AlertDialog(
      title: Text('Add Text Announcement'),
      content: TextField(
        onChanged: (value) {
          text = value;
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (text.isNotEmpty) {
              Navigator.of(context).pop(text);
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}

class _EditTextContentDialogState extends State<EditTextContentDialog> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Text'),
      content: TextField(
        controller: _textEditingController,
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onTextSaved(_textEditingController.text);
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
*/

/*import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityPage extends StatefulWidget {
  final String subBranchId;

  ActivityPage({required this.subBranchId}) : super();

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  List<Activity> activities = [];

  @override
  void initState() {
    super.initState();
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('Activities')
          .where('subBranchId', isEqualTo: widget.subBranchId)
          .get();

      List<Activity> fetchedActivities = [];
      querySnapshot.docs.forEach((doc) {
        Activity activity =
            Activity.fromSnapshot(doc, subBranchId: widget.subBranchId);
        fetchedActivities.add(activity);
      });

      setState(() {
        activities = fetchedActivities;
      });
    } catch (e) {
      print('Error fetching activities: $e');
    }
  }

  Future<void> updateActivityContents(Activity activity) async {
    try {
      await firestore
          .collection('Activities')
          .doc(activity.id) // Use the 'id' field instead of 'documentId'
          .update({'contents': activity.toMap()['contents']});
    } catch (e) {
      print('Error updating activity contents: $e');
    }
  }

  Future<void> addActivity(Activity activity) async {
    try {
      DocumentReference docRef =
          await firestore.collection('Activities').add(activity.toMap());
      activity.id = docRef.id; // Assign the generated ID to the activity

      setState(() {
        activities.add(activity);
      });
    } catch (e) {
      print('Error adding activity: $e');
    }
  }

  Future<void> addImageContent(Activity activity) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String? imageUrl = await uploadImage(File(pickedFile.path)) ?? '';
      if (imageUrl != null) {
        setState(() {
          activity.contents.add(ImageContent(imageUrl: imageUrl));
        });
      }
    }
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = reference.putFile(imageFile);
      TaskSnapshot storageTaskSnapshot = await uploadTask;
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Widget _buildActivitySection(Activity activity) {
    final List<ImageContent> imageContents =
        activity.contents.whereType<ImageContent>().toList();
    final List<Content> nonImageContents =
        activity.contents.where((content) => content is! ImageContent).toList();

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                activity.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                onPressed: () => _addContent(activity),
                icon: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 8),
          Stack(
            children: [
              if (imageContents.isNotEmpty)
                _buildImageContentItem(imageContents.first),
            ],
          ),
          if (imageContents.length > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _toggleContent(activity, -1),
                  icon: Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () => _toggleContent(activity, 1),
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < nonImageContents.length; i++)
                _buildContentItem(nonImageContents[i], i),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageContentItem(ImageContent content) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(
          content.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildContentItem(Content content, int index) {
    if (content is TextContent) {
      return ListTile(
        title: Text(content.text),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _editTextContent(content),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteContent(index),
            ),
          ],
        ),
      );
    } else if (content is ImageContent) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                content.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteContent(index),
              ),
            ),
          ],
        ),
      );
    } else if (content is VideoContent) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: VideoPlayer(content.videoController),
        ),
      );
    }
    return SizedBox.shrink();
  }

  Future<void> _addContent(Activity activity) async {
    showDialog(
      context: context,
      builder: (context) => AddContentDialog(
        onTextContentAdded: (String text) async {
          final textContent = TextContent(text: text);
          activity.contents.add(textContent);
          await updateActivityContents(activity);
        },
      ),
    );
  }

  void _editTextContent(TextContent content) {
    showDialog(
      context: context,
      builder: (context) => EditTextContentDialog(
        textEditingController: TextEditingController(text: content.text),
        onTextSaved: (newText) {
          setState(() {
            content.text = newText;
          });
        },
      ),
    );
  }

  void _deleteContent(int index) {
    setState(() {
      activities[index].contents.removeAt(index);
    });
  }

  void _toggleContent(Activity activity, int direction) {
    final List<ImageContent> imageContents =
        activity.contents.whereType<ImageContent>().toList();

    int currentImageIndex = imageContents.indexOf(activity.currentImageContent);
    int nextImageIndex = (currentImageIndex + direction) % imageContents.length;

    setState(() {
      activity.currentImageContent = imageContents[nextImageIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.jpg'),
                ),
                SizedBox(width: 8),
                Text(
                  'Redcross',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Text(
              'Activities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var activity in activities) _buildActivitySection(activity),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addActivity();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addActivity() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';

        return AlertDialog(
          title: Text('Add Activity'),
          content: TextField(
            onChanged: (value) {
              title = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (title.isNotEmpty) {
                  Activity newActivity = Activity(
                    id: '', // Initialize with empty id
                    documentId: '', // Initialize with empty documentId
                    title: title,
                    contents: [],
                    currentImageContent: ImageContent(imageUrl: ''),
                    subBranchId: widget.subBranchId,
                  );
                  addActivity(newActivity);

                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class Activity {
  String id;
  String documentId;
  String title;
  List<Content> contents;
  ImageContent currentImageContent;
  String subBranchId;

  Activity({
    required this.id,
    required this.documentId,
    required this.title,
    required this.contents,
    required this.currentImageContent,
    required this.subBranchId,
  });

  Activity.fromSnapshot(DocumentSnapshot snapshot, {required this.subBranchId})
      : id = snapshot.id,
        documentId = snapshot.id, // Assign the documentId field
        title = snapshot['title'],
        contents = _parseContents(snapshot['contents']),
        currentImageContent = _parseCurrentImageContent(
            snapshot['currentImageContent'],
            _parseContents(snapshot['contents']));

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'contents': _serializeContents(contents),
      'currentImageContent': _serializeCurrentImageContent(currentImageContent),
      'subBranchId': subBranchId,
    };
  }

  static List<Content> _parseContents(List<dynamic>? contentData) {
    if (contentData == null) return [];

    return contentData.map<Content>((data) {
      if (data['type'] == 'text') {
        return TextContent(text: data['text'] ?? '');
      } else if (data['type'] == 'image') {
        return ImageContent(imageUrl: data['imageUrl'] ?? '');
      } else if (data['type'] == 'video') {
        return VideoContent(videoUrl: data['videoUrl'] ?? '');
      }
      return TextContent(text: ''); // Add a default return statement
    }).toList();
  }

  static ImageContent _parseCurrentImageContent(
      String imageUrl, List<Content> contents) {
    if (imageUrl.isEmpty || contents.isEmpty) {
      return ImageContent(imageUrl: '');
    }

    return contents.firstWhere(
      (content) => content is ImageContent && content.imageUrl == imageUrl,
      orElse: () => ImageContent(imageUrl: ''),
    ) as ImageContent;
  }

  static List<Map<String, String>?> _serializeContents(
      List<Content?> contents) {
    return contents.where((content) => content != null).map((content) {
      if (content is TextContent) {
        return {
          'type': 'text',
          'text': content.text,
        };
      } else if (content is ImageContent) {
        return {
          'type': 'image',
          'imageUrl': content.imageUrl,
        };
      } else if (content is VideoContent) {
        return {
          'type': 'video',
          'videoUrl': content.videoUrl,
        };
      }
      return null;
    }).toList();
  }

  static String _serializeCurrentImageContent(
      ImageContent currentImageContent) {
    if (currentImageContent == null || currentImageContent.imageUrl.isEmpty) {
      return ''; // Return an empty string if no current image content
    }

    return currentImageContent.imageUrl;
  }
}

abstract class Content {}

class TextContent extends Content {
  String text;

  TextContent({required this.text});
}

class ImageContent extends Content {
  String imageUrl;

  ImageContent({required this.imageUrl});
}

class VideoContent extends Content {
  String videoUrl;
  VideoPlayerController videoController;

  VideoContent({required this.videoUrl})
      : videoController = VideoPlayerController.network(videoUrl);
}

class AddContentDialog extends StatefulWidget {
  final Function(String) onTextContentAdded;

  AddContentDialog({required this.onTextContentAdded});

  @override
  _AddContentDialogState createState() => _AddContentDialogState();
}

class _AddContentDialogState extends State<AddContentDialog> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Content'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.text_fields),
            title: Text('Text'),
            onTap: () async {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => EditTextContentDialog(
                  textEditingController: TextEditingController(),
                  onTextSaved: widget.onTextContentAdded,
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text('Image'),
            onTap: () async {
              final imageContent = ImageContent(imageUrl: '');
              Navigator.pop(context);
              widget.onTextContentAdded(_textEditingController.text);
            },
          ),
          ListTile(
            leading: Icon(Icons.videocam),
            title: Text('Video'),
            onTap: () async {
              final videoContent = VideoContent(videoUrl: '');
              Navigator.pop(context);
              widget.onTextContentAdded(_textEditingController.text);
            },
          ),
        ],
      ),
    );
  }
}

class EditTextContentDialog extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function(String) onTextSaved;

  EditTextContentDialog({
    required this.textEditingController,
    required this.onTextSaved,
  });

  @override
  _EditTextContentDialogState createState() => _EditTextContentDialogState();
}

class _EditTextContentDialogState extends State<EditTextContentDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Text'),
      content: TextField(
        controller: widget.textEditingController,
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onTextSaved(widget.textEditingController.text);
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
*/

/*import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityPage extends StatefulWidget {
  final String subBranchId;

  ActivityPage({required this.subBranchId}) : super();

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  List<Activity> activities = [];

  @override
  void initState() {
    super.initState();
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('Activities')
          .where('subBranchId', isEqualTo: widget.subBranchId)
          .get();

      List<Activity> fetchedActivities = [];
      querySnapshot.docs.forEach((doc) {
        Activity activity =
            Activity.fromSnapshot(doc, subBranchId: widget.subBranchId);
        fetchedActivities.add(activity);
      });

      setState(() {
        activities = fetchedActivities;
      });
    } catch (e) {
      print('Error fetching activities: $e');
    }
  }

  Future<void> updateActivityContents(Activity activity) async {
    try {
      await firestore
          .collection('Activities')
          .doc(activity.id) // Use the 'id' field instead of 'documentId'
          .update({'contents': activity.toMap()['contents']});
    } catch (e) {
      print('Error updating activity contents: $e');
    }
  }

  Future<void> addActivity(Activity activity) async {
    try {
      DocumentReference docRef =
          await firestore.collection('Activities').add(activity.toMap());
      activity.id = docRef.id; // Assign the generated ID to the activity

      setState(() {
        activities.add(activity);
      });
    } catch (e) {
      print('Error adding activity: $e');
    }
  }

  Future<void> addImageContent(Activity activity) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String? imageUrl = await uploadImage(File(pickedFile.path));
      if (imageUrl != null) {
        setState(() {
          activity.contents.add(ImageContent(imageUrl: imageUrl));
        });
        await updateActivityContents(activity);
      }
    }
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference reference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('images/$fileName');
      firebase_storage.UploadTask uploadTask = reference.putFile(imageFile);
      firebase_storage.TaskSnapshot storageTaskSnapshot = await uploadTask;
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Widget _buildActivitySection(Activity activity) {
    final List<ImageContent> imageContents =
        activity.contents.whereType<ImageContent>().toList();
    final List<Content> nonImageContents =
        activity.contents.where((content) => content is! ImageContent).toList();

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                activity.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                onPressed: () => _addContent(activity),
                icon: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 8),
          Stack(
            children: [
              if (imageContents.isNotEmpty)
                _buildImageContentItem(imageContents.first),
            ],
          ),
          if (imageContents.length > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _toggleContent(activity, -1),
                  icon: Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () => _toggleContent(activity, 1),
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < nonImageContents.length; i++)
                _buildContentItem(nonImageContents[i], i),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageContentItem(ImageContent content) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(
          content.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildContentItem(Content content, int index) {
    if (content is TextContent) {
      return ListTile(
        title: Text(content.text),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _editTextContent(content),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteContent(index),
            ),
          ],
        ),
      );
    } else if (content is ImageContent) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                content.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteContent(index),
              ),
            ),
          ],
        ),
      );
    } else if (content is VideoContent) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: VideoPlayer(content.videoController),
        ),
      );
    }
    return SizedBox.shrink();
  }

  Future<void> _addContent(Activity activity) async {
    showDialog(
      context: context,
      builder: (context) => AddContentDialog(
        onTextContentAdded: (String text) async {
          final textContent = TextContent(text: text);
          activity.contents.add(textContent);
          await updateActivityContents(activity);
        },
        onImageContentAdded: () async {
          await addImageContent(activity);
        },
      ),
    );
  }

  void _editTextContent(TextContent content) {
    showDialog(
      context: context,
      builder: (context) => EditTextContentDialog(
        textEditingController: TextEditingController(text: content.text),
        onTextSaved: (newText) {
          setState(() {
            content.text = newText;
          });
        },
      ),
    );
  }

  void _deleteContent(int index) {
    setState(() {
      activities[index].contents.removeAt(index);
    });
  }

  void _toggleContent(Activity activity, int direction) {
    final List<ImageContent> imageContents =
        activity.contents.whereType<ImageContent>().toList();

    int currentImageIndex = imageContents.indexOf(activity.currentImageContent);

    int nextImageIndex = (currentImageIndex + direction) % imageContents.length;

    if (nextImageIndex < 0) {
      nextImageIndex = imageContents.length - 1;
    }

    setState(() {
      activity.currentImageContent = imageContents[nextImageIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.jpg'),
                ),
                SizedBox(width: 8),
                Text(
                  'Redcross',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Text(
              'Activities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var activity in activities) _buildActivitySection(activity),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addActivity();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addActivity() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';

        return AlertDialog(
          title: Text('Add Activity'),
          content: TextField(
            onChanged: (value) {
              title = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (title.isNotEmpty) {
                  Activity newActivity = Activity(
                    id: '', // Initialize with empty id
                    documentId: '', // Initialize with empty documentId
                    title: title,
                    contents: [],
                    currentImageContent: ImageContent(imageUrl: ''),
                    subBranchId: widget.subBranchId,
                  );
                  addActivity(newActivity);

                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class Activity {
  String id;
  String documentId;
  String title;
  List<Content> contents;
  ImageContent currentImageContent;
  String subBranchId;

  Activity({
    required this.id,
    required this.documentId,
    required this.title,
    required this.contents,
    required this.currentImageContent,
    required this.subBranchId,
  });

  Activity.fromSnapshot(DocumentSnapshot snapshot, {required this.subBranchId})
      : id = snapshot.id,
        documentId = snapshot.id, // Assign the documentId field
        title = snapshot['title'],
        contents = _parseContents(snapshot['contents']),
        currentImageContent = _parseCurrentImageContent(
            snapshot['currentImageContent'],
            _parseContents(snapshot['contents']));

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'contents': _serializeContents(contents),
      'currentImageContent': _serializeCurrentImageContent(currentImageContent),
      'subBranchId': subBranchId,
    };
  }

  static List<Content> _parseContents(List<dynamic>? contentData) {
    if (contentData == null) return [];

    return contentData.map<Content>((data) {
      if (data['type'] == 'text') {
        return TextContent(text: data['text'] ?? '');
      } else if (data['type'] == 'image') {
        return ImageContent(imageUrl: data['imageUrl'] ?? '');
      } else if (data['type'] == 'video') {
        return VideoContent(videoUrl: data['videoUrl'] ?? '');
      }
      return TextContent(text: ''); // Add a default return statement
    }).toList();
  }

  static ImageContent _parseCurrentImageContent(
      String imageUrl, List<Content> contents) {
    if (imageUrl.isEmpty || contents.isEmpty) {
      return ImageContent(imageUrl: '');
    }

    return contents.firstWhere(
      (content) => content is ImageContent && content.imageUrl == imageUrl,
      orElse: () => ImageContent(imageUrl: ''),
    ) as ImageContent;
  }

  static List<Map<String, dynamic>?> _serializeContents(
      List<Content?> contents) {
    return contents.where((content) => content != null).map((content) {
      if (content is TextContent) {
        return {
          'type': 'text',
          'text': content.text,
        };
      } else if (content is ImageContent) {
        return {
          'type': 'image',
          'imageUrl': content.imageUrl,
        };
      } else if (content is VideoContent) {
        return {
          'type': 'video',
          'videoUrl': content.videoUrl,
        };
      }
      return null;
    }).toList();
  }

  static String _serializeCurrentImageContent(
      ImageContent currentImageContent) {
    if (currentImageContent == null || currentImageContent.imageUrl.isEmpty) {
      return ''; // Return an empty string if no current image content
    }

    return currentImageContent.imageUrl;
  }
}

abstract class Content {}

class TextContent extends Content {
  String text;

  TextContent({required this.text});
}

class ImageContent extends Content {
  String imageUrl;

  ImageContent({required this.imageUrl});
}

class VideoContent extends Content {
  String videoUrl;
  VideoPlayerController videoController;

  VideoContent({required this.videoUrl})
      : videoController = VideoPlayerController.network(videoUrl);
}

class AddContentDialog extends StatefulWidget {
  final Function(String) onTextContentAdded;
  final Function() onImageContentAdded;

  AddContentDialog(
      {required this.onTextContentAdded, required this.onImageContentAdded});

  @override
  _AddContentDialogState createState() => _AddContentDialogState();
}

class _AddContentDialogState extends State<AddContentDialog> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Content'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.text_fields),
            title: Text('Text'),
            onTap: () async {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => EditTextContentDialog(
                  textEditingController: TextEditingController(),
                  onTextSaved: widget.onTextContentAdded,
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text('Image'),
            onTap: () async {
              Navigator.pop(context);
              widget.onImageContentAdded();
            },
          ),
          ListTile(
            leading: Icon(Icons.videocam),
            title: Text('Video'),
            onTap: () async {
              final videoContent = VideoContent(videoUrl: '');
              Navigator.pop(context);
              widget.onTextContentAdded(_textEditingController.text);
            },
          ),
        ],
      ),
    );
  }
}

class EditTextContentDialog extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function(String) onTextSaved;

  EditTextContentDialog({
    required this.textEditingController,
    required this.onTextSaved,
  });

  @override
  _EditTextContentDialogState createState() => _EditTextContentDialogState();
}

class _EditTextContentDialogState extends State<EditTextContentDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Text'),
      content: TextField(
        controller: widget.textEditingController,
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onTextSaved(widget.textEditingController.text);
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
*/

/*import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityPage extends StatefulWidget {
  final String subBranchId;

  ActivityPage({required this.subBranchId}) : super();

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  List<Activity> activities = [];

  @override
  void initState() {
    super.initState();
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('Activities')
          .where('subBranchId', isEqualTo: widget.subBranchId)
          .get();

      List<Activity> fetchedActivities = [];
      querySnapshot.docs.forEach((doc) {
        Activity activity =
            Activity.fromSnapshot(doc, subBranchId: widget.subBranchId);
        fetchedActivities.add(activity);
      });

      setState(() {
        activities = fetchedActivities;
      });
    } catch (e) {
      print('Error fetching activities: $e');
    }
  }

  Future<void> updateActivityContents(Activity activity) async {
    try {
      await firestore
          .collection('Activities')
          .doc(activity.id) // Use the 'id' field instead of 'documentId'
          .update({'contents': activity.toMap()['contents']});
    } catch (e) {
      print('Error updating activity contents: $e');
    }
  }

  Future<void> addActivity(Activity activity) async {
    try {
      DocumentReference docRef =
          await firestore.collection('Activities').add(activity.toMap());
      activity.id = docRef.id; // Assign the generated ID to the activity

      setState(() {
        activities.add(activity);
      });
    } catch (e) {
      print('Error adding activity: $e');
    }
  }

  Future<void> addImageContent(Activity activity) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String? imageUrl = await uploadImage(File(pickedFile.path));
      if (imageUrl != null) {
        setState(() {
          activity.contents.add(ImageContent(imageUrl: imageUrl));
        });
        await updateActivityContents(activity);
      }
    }
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference reference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('images/$fileName');
      firebase_storage.UploadTask uploadTask = reference.putFile(imageFile);
      firebase_storage.TaskSnapshot storageTaskSnapshot = await uploadTask;
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Widget _buildActivitySection(Activity activity) {
    final List<ImageContent> imageContents =
        activity.contents.whereType<ImageContent>().toList();
    final List<Content> nonImageContents =
        activity.contents.where((content) => content is! ImageContent).toList();

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                activity.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                onPressed: () => _addContent(activity),
                icon: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 8),
          Stack(
            children: [
              if (imageContents.isNotEmpty)
                GestureDetector(
                  onTap: () => _showImageDialog(activity, imageContents.first),
                  child: _buildImageContentItem(activity, imageContents.first),
                ),
            ],
          ),
          if (imageContents.length > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _toggleContent(activity, -1),
                  icon: Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () => _toggleContent(activity, 1),
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < nonImageContents.length; i++)
                _buildContentItem(nonImageContents[i], i),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageContentItem(Activity activity, ImageContent content) {
    return GestureDetector(
      onTap: () => _showImageDialog(activity, content),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                content.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteImageContent(activity, content),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentItem(Content content, int index) {
    if (content is TextContent) {
      return ListTile(
        title: Text(content.text),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _editTextContent(content),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteContent(index),
            ),
          ],
        ),
      );
    } else if (content is ImageContent) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                content.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteContent(index),
              ),
            ),
          ],
        ),
      );
    } else if (content is VideoContent) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: VideoPlayer(content.videoController),
        ),
      );
    }
    return SizedBox.shrink();
  }

  Future<void> _addContent(Activity activity) async {
    showDialog(
      context: context,
      builder: (context) => AddContentDialog(
        onTextContentAdded: (String text) async {
          final textContent = TextContent(text: text);
          activity.contents.add(textContent);
          await updateActivityContents(activity);
        },
        onImageContentAdded: () async {
          await addImageContent(activity);
        },
      ),
    );
  }

  void _editTextContent(TextContent content) {
    showDialog(
      context: context,
      builder: (context) => EditTextContentDialog(
        textEditingController: TextEditingController(text: content.text),
        onTextSaved: (newText) {
          setState(() {
            content.text = newText;
          });
        },
      ),
    );
  }

  void _deleteContent(int index) {
    setState(() {
      activities[index].contents.removeAt(index);
    });
  }

  void _deleteImageContent(Activity activity, ImageContent content) async {
    final updatedContents = activity.contents
        .where((element) =>
            !(element is ImageContent && element.imageUrl == content.imageUrl))
        .toList();
    activity.contents = updatedContents;
    if (activity.currentImageContent.imageUrl == content.imageUrl) {
      activity.currentImageContent = ImageContent(
          imageUrl:
              ''); // Set a default image when the current image is deleted
    }
    await updateActivityContents(activity);

    // Remove the image from Firebase Storage as well
    final firebase_storage.Reference reference =
        firebase_storage.FirebaseStorage.instance.refFromURL(content.imageUrl);
    try {
      await reference.delete();
    } catch (e) {
      print('Error deleting image from Firebase Storage: $e');
    }

    setState(() {}); // Rebuild the widget tree to reflect the changes
  }

  void _toggleContent(Activity activity, int direction) {
    final List<ImageContent> imageContents =
        activity.contents.whereType<ImageContent>().toList();

    if (imageContents.isEmpty) {
      return;
    }

    int currentImageIndex = imageContents.indexOf(activity.currentImageContent);
    int nextImageIndex = (currentImageIndex + direction) % imageContents.length;

    if (nextImageIndex < 0) {
      nextImageIndex = imageContents.length - 1;
    }

    setState(() {
      activity.currentImageContent = imageContents[nextImageIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.jpg'),
                ),
                SizedBox(width: 8),
                Text(
                  'Redcross',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Text(
              'Activities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var activity in activities) _buildActivitySection(activity),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addActivity();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addActivity() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';

        return AlertDialog(
          title: Text('Add Activity'),
          content: TextField(
            onChanged: (value) {
              title = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (title.isNotEmpty) {
                  Activity newActivity = Activity(
                    id: '', // Initialize with empty id
                    documentId: '', // Initialize with empty documentId
                    title: title,
                    contents: [],
                    currentImageContent: ImageContent(imageUrl: ''),
                    subBranchId: widget.subBranchId,
                  );
                  addActivity(newActivity);

                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showImageDialog(Activity activity, ImageContent content) {
    List<ImageContent> imageContents =
        activity.contents.whereType<ImageContent>().toList();
    showDialog(
      context: context,
      builder: (context) => ImageDialog(
        imageContents: imageContents,
        initialImageContent: content,
      ),
    );
  }
}

class Activity {
  String id;
  String documentId;
  String title;
  List<Content> contents;
  ImageContent currentImageContent;
  String subBranchId;
  int? currentImageIndex;

  Activity({
    required this.id,
    required this.documentId,
    required this.title,
    required this.contents,
    required this.currentImageContent,
    required this.subBranchId,
  });

  Activity.fromSnapshot(DocumentSnapshot snapshot, {required this.subBranchId})
      : id = snapshot.id,
        documentId = snapshot.id, // Assign the documentId field
        title = snapshot['title'],
        contents = _parseContents(snapshot['contents']),
        currentImageContent = _parseCurrentImageContent(
            snapshot['currentImageContent'],
            _parseContents(snapshot['contents']));

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'contents': _serializeContents(contents),
      'currentImageContent': _serializeCurrentImageContent(currentImageContent),
      'subBranchId': subBranchId,
    };
  }

  static List<Content> _parseContents(List<dynamic>? contentData) {
    if (contentData == null) return [];

    return contentData.map<Content>((data) {
      if (data['type'] == 'text') {
        return TextContent(text: data['text'] ?? '');
      } else if (data['type'] == 'image') {
        return ImageContent(imageUrl: data['imageUrl'] ?? '');
      } else if (data['type'] == 'video') {
        return VideoContent(videoUrl: data['videoUrl'] ?? '');
      }
      return TextContent(text: ''); // Add a default return statement
    }).toList();
  }

  static ImageContent _parseCurrentImageContent(
      String imageUrl, List<Content> contents) {
    if (imageUrl.isEmpty || contents.isEmpty) {
      return ImageContent(imageUrl: '');
    }

    return contents.firstWhere(
      (content) => content is ImageContent && content.imageUrl == imageUrl,
      orElse: () => ImageContent(imageUrl: ''),
    ) as ImageContent;
  }

  static List<Map<String, dynamic>?> _serializeContents(
      List<Content?> contents) {
    return contents.where((content) => content != null).map((content) {
      if (content is TextContent) {
        return {
          'type': 'text',
          'text': content.text,
        };
      } else if (content is ImageContent) {
        return {
          'type': 'image',
          'imageUrl': content.imageUrl,
        };
      } else if (content is VideoContent) {
        return {
          'type': 'video',
          'videoUrl': content.videoUrl,
        };
      }
      return null;
    }).toList();
  }

  static String _serializeCurrentImageContent(
      ImageContent currentImageContent) {
    if (currentImageContent == null || currentImageContent.imageUrl.isEmpty) {
      return ''; // Return an empty string if no current image content
    }

    return currentImageContent.imageUrl;
  }
}

abstract class Content {}

class TextContent extends Content {
  String text;

  TextContent({required this.text});
}

class ImageContent extends Content {
  String imageUrl;

  ImageContent({required this.imageUrl});
}

class VideoContent extends Content {
  String videoUrl;
  VideoPlayerController videoController;

  VideoContent({required this.videoUrl})
      : videoController = VideoPlayerController.network(videoUrl);
}

class AddContentDialog extends StatefulWidget {
  final Function(String) onTextContentAdded;
  final Function() onImageContentAdded;

  AddContentDialog(
      {required this.onTextContentAdded, required this.onImageContentAdded});

  @override
  _AddContentDialogState createState() => _AddContentDialogState();
}

class _AddContentDialogState extends State<AddContentDialog> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Content'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.text_fields),
            title: Text('Text'),
            onTap: () async {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => EditTextContentDialog(
                  textEditingController: TextEditingController(),
                  onTextSaved: widget.onTextContentAdded,
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text('Image'),
            onTap: () async {
              Navigator.pop(context);
              widget.onImageContentAdded();
            },
          ),
          ListTile(
            leading: Icon(Icons.videocam),
            title: Text('Video'),
            onTap: () async {
              final videoContent = VideoContent(videoUrl: '');
              Navigator.pop(context);
              widget.onTextContentAdded(_textEditingController.text);
            },
          ),
        ],
      ),
    );
  }
}

class EditTextContentDialog extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function(String) onTextSaved;

  EditTextContentDialog({
    required this.textEditingController,
    required this.onTextSaved,
  });

  @override
  _EditTextContentDialogState createState() => _EditTextContentDialogState();
}

class _EditTextContentDialogState extends State<EditTextContentDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Text'),
      content: TextField(
        controller: widget.textEditingController,
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onTextSaved(widget.textEditingController.text);
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}

class ImageDialog extends StatefulWidget {
  final List<ImageContent> imageContents;
  final ImageContent initialImageContent;

  ImageDialog({required this.imageContents, required this.initialImageContent});

  @override
  _ImageDialogState createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.imageContents.indexOf(widget.initialImageContent);
  }

  void _swipeImage(int direction) {
    setState(() {
      _currentIndex += direction;
      if (_currentIndex >= widget.imageContents.length) {
        _currentIndex = 0;
      } else if (_currentIndex < 0) {
        _currentIndex = widget.imageContents.length - 1;
      }
    });
  }

  void _deleteImage() {
    final deletedImageContent = widget.imageContents[_currentIndex];
    final activity = context
        .findAncestorStateOfType<_ActivityPageState>()!
        .activities[_currentIndex];
    final activityPageState =
        context.findAncestorStateOfType<_ActivityPageState>()!;
    activityPageState._deleteImageContent(activity, deletedImageContent);

    setState(() {
      widget.imageContents.removeAt(_currentIndex);
      if (_currentIndex >= widget.imageContents.length) {
        _currentIndex = widget.imageContents.length - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final imageContent = widget.imageContents[_currentIndex];
    return Dialog(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null) {
            _swipeImage(details.primaryVelocity! > 0 ? -1 : 1);
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.network(
              imageContent.imageUrl,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => _swipeImage(-1),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () => _swipeImage(1),
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: ElevatedButton.icon(
                onPressed: _deleteImage,
                icon: Icon(Icons.delete),
                label: Text('Delete'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityPage extends StatefulWidget {
  final String subBranchId;

  ActivityPage({required this.subBranchId}) : super();

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  List<Activity> activities = [];

  @override
  void initState() {
    super.initState();
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('Activities')
          .where('subBranchId', isEqualTo: widget.subBranchId)
          .get();

      List<Activity> fetchedActivities = [];
      querySnapshot.docs.forEach((doc) {
        Activity activity =
            Activity.fromSnapshot(doc, subBranchId: widget.subBranchId);
        fetchedActivities.add(activity);
      });

      setState(() {
        activities = fetchedActivities;
      });
    } catch (e) {
      print('Error fetching activities: $e');
    }
  }

  Future<void> updateActivityContents(Activity activity) async {
    try {
      await firestore
          .collection('Activities')
          .doc(activity.id) // Use the 'id' field instead of 'documentId'
          .update({'contents': activity.toMap()['contents']});
    } catch (e) {
      print('Error updating activity contents: $e');
    }
  }

  Future<void> addActivity(Activity activity) async {
    try {
      DocumentReference docRef =
          await firestore.collection('Activities').add(activity.toMap());
      activity.id = docRef.id; // Assign the generated ID to the activity

      setState(() {
        activities.add(activity);
      });
    } catch (e) {
      print('Error adding activity: $e');
    }
  }

  Future<void> addImageContent(Activity activity) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String? imageUrl = await uploadImage(File(pickedFile.path));
      if (imageUrl != null) {
        setState(() {
          activity.contents.add(ImageContent(imageUrl: imageUrl));
        });
        await updateActivityContents(activity);
      }
    }
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference reference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('images/$fileName');
      firebase_storage.UploadTask uploadTask = reference.putFile(imageFile);
      firebase_storage.TaskSnapshot storageTaskSnapshot = await uploadTask;
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Widget _buildActivitySection(Activity activity) {
    final List<ImageContent> imageContents =
        activity.contents.whereType<ImageContent>().toList();
    final List<Content> nonImageContents =
        activity.contents.where((content) => content is! ImageContent).toList();

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                activity.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                onPressed: () => _addContent(activity),
                icon: Icon(Icons.add),
              ),
              IconButton(
                onPressed: () => _deleteActivity(activity),
                icon: Icon(Icons.delete),
              ),
            ],
          ),
          SizedBox(height: 8),
          Stack(
            children: [
              if (imageContents.isNotEmpty)
                GestureDetector(
                  onTap: () => _showImageDialog(activity, imageContents.first),
                  child: _buildImageContentItem(activity, imageContents.first),
                ),
            ],
          ),
          if (imageContents.length > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _toggleContent(activity, -1),
                  icon: Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () => _toggleContent(activity, 1),
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < nonImageContents.length; i++)
                _buildContentItem(nonImageContents[i], i),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageContentItem(Activity activity, ImageContent content) {
    return GestureDetector(
      onTap: () => _showImageDialog(activity, content),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                content.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteImageContent(activity, content),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentItem(Content content, int index) {
    if (content is TextContent) {
      return ListTile(
        title: Text(content.text),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _editTextContent(content),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteContent(index),
            ),
          ],
        ),
      );
    } else if (content is ImageContent) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                content.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteContent(index),
              ),
            ),
          ],
        ),
      );
    } else if (content is VideoContent) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: VideoPlayer(content.videoController),
        ),
      );
    }
    return SizedBox.shrink();
  }

  Future<void> _addContent(Activity activity) async {
    showDialog(
      context: context,
      builder: (context) => AddContentDialog(
        onTextContentAdded: (String text) async {
          final textContent = TextContent(text: text);
          activity.contents.add(textContent);
          await updateActivityContents(activity);
        },
        onImageContentAdded: () async {
          await addImageContent(activity);
        },
      ),
    );
  }

  void _editTextContent(TextContent content) {
    showDialog(
      context: context,
      builder: (context) => EditTextContentDialog(
        textEditingController: TextEditingController(text: content.text),
        onTextSaved: (newText) {
          setState(() {
            content.text = newText;
          });
        },
      ),
    );
  }

  void _deleteContent(int index) {
    setState(() {
      activities[index].contents.removeAt(index);
    });
  }

  void _deleteImageContent(Activity activity, ImageContent content) async {
    final updatedContents = activity.contents
        .where((element) =>
            !(element is ImageContent && element.imageUrl == content.imageUrl))
        .toList();
    activity.contents = updatedContents;
    if (activity.currentImageContent.imageUrl == content.imageUrl) {
      activity.currentImageContent = ImageContent(
          imageUrl:
              ''); // Set a default image when the current image is deleted
    }
    await updateActivityContents(activity);

    // Remove the image from Firebase Storage as well
    final firebase_storage.Reference reference =
        firebase_storage.FirebaseStorage.instance.refFromURL(content.imageUrl);
    try {
      await reference.delete();
    } catch (e) {
      print('Error deleting image from Firebase Storage: $e');
    }

    setState(() {}); // Rebuild the widget tree to reflect the changes
  }

  void _toggleContent(Activity activity, int direction) {
    final List<ImageContent> imageContents =
        activity.contents.whereType<ImageContent>().toList();

    if (imageContents.isEmpty) {
      return;
    }

    int currentImageIndex = imageContents.indexOf(activity.currentImageContent);
    int nextImageIndex = (currentImageIndex + direction) % imageContents.length;

    if (nextImageIndex < 0) {
      nextImageIndex = imageContents.length - 1;
    }

    setState(() {
      activity.currentImageContent = imageContents[nextImageIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.jpg'),
                ),
                SizedBox(width: 8),
                Text(
                  'Redcross',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Text(
              'Activities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var activity in activities) _buildActivitySection(activity),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addActivity();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addActivity() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';

        return AlertDialog(
          title: Text('Add Activity'),
          content: TextField(
            onChanged: (value) {
              title = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (title.isNotEmpty) {
                  Activity newActivity = Activity(
                    id: '', // Initialize with empty id
                    documentId: '', // Initialize with empty documentId
                    title: title,
                    contents: [],
                    currentImageContent: ImageContent(imageUrl: ''),
                    subBranchId: widget.subBranchId,
                  );
                  addActivity(newActivity);

                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showImageDialog(Activity activity, ImageContent content) {
    List<ImageContent> imageContents =
        activity.contents.whereType<ImageContent>().toList();
    showDialog(
      context: context,
      builder: (context) => ImageDialog(
        imageContents: imageContents,
        initialImageContent: content,
      ),
    );
  }

  Future<void> _deleteActivity(Activity activity) async {
    try {
      await firestore.collection('Activities').doc(activity.id).delete();
      for (var content in activity.contents) {
        if (content is ImageContent) {
          final firebase_storage.Reference reference = firebase_storage
              .FirebaseStorage.instance
              .refFromURL(content.imageUrl);
          await reference.delete();
        }
      }

      setState(() {
        activities.remove(activity);
      });
    } catch (e) {
      print('Error deleting activity: $e');
    }
  }
}

// Rest of the classes remain the same
class Activity {
  String id;
  String documentId;
  String title;
  List<Content> contents;
  ImageContent currentImageContent;
  String subBranchId;
  int? currentImageIndex;

  Activity({
    required this.id,
    required this.documentId,
    required this.title,
    required this.contents,
    required this.currentImageContent,
    required this.subBranchId,
  });

  Activity.fromSnapshot(DocumentSnapshot snapshot, {required this.subBranchId})
      : id = snapshot.id,
        documentId = snapshot.id, // Assign the documentId field
        title = snapshot['title'],
        contents = _parseContents(snapshot['contents']),
        currentImageContent = _parseCurrentImageContent(
            snapshot['currentImageContent'],
            _parseContents(snapshot['contents']));

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'contents': _serializeContents(contents),
      'currentImageContent': _serializeCurrentImageContent(currentImageContent),
      'subBranchId': subBranchId,
    };
  }

  static List<Content> _parseContents(List<dynamic>? contentData) {
    if (contentData == null) return [];

    return contentData.map<Content>((data) {
      if (data['type'] == 'text') {
        return TextContent(text: data['text'] ?? '');
      } else if (data['type'] == 'image') {
        return ImageContent(imageUrl: data['imageUrl'] ?? '');
      } else if (data['type'] == 'video') {
        return VideoContent(videoUrl: data['videoUrl'] ?? '');
      }
      return TextContent(text: ''); // Add a default return statement
    }).toList();
  }

  static ImageContent _parseCurrentImageContent(
      String imageUrl, List<Content> contents) {
    if (imageUrl.isEmpty || contents.isEmpty) {
      return ImageContent(imageUrl: '');
    }

    return contents.firstWhere(
      (content) => content is ImageContent && content.imageUrl == imageUrl,
      orElse: () => ImageContent(imageUrl: ''),
    ) as ImageContent;
  }

  static List<Map<String, dynamic>?> _serializeContents(
      List<Content?> contents) {
    return contents.where((content) => content != null).map((content) {
      if (content is TextContent) {
        return {
          'type': 'text',
          'text': content.text,
        };
      } else if (content is ImageContent) {
        return {
          'type': 'image',
          'imageUrl': content.imageUrl,
        };
      } else if (content is VideoContent) {
        return {
          'type': 'video',
          'videoUrl': content.videoUrl,
        };
      }
      return null;
    }).toList();
  }

  static String _serializeCurrentImageContent(
      ImageContent currentImageContent) {
    if (currentImageContent == null || currentImageContent.imageUrl.isEmpty) {
      return ''; // Return an empty string if no current image content
    }

    return currentImageContent.imageUrl;
  }
}

abstract class Content {}

class TextContent extends Content {
  String text;

  TextContent({required this.text});
}

class ImageContent extends Content {
  String imageUrl;

  ImageContent({required this.imageUrl});
}

class VideoContent extends Content {
  String videoUrl;
  VideoPlayerController videoController;

  VideoContent({required this.videoUrl})
      : videoController = VideoPlayerController.network(videoUrl);
}

class AddContentDialog extends StatefulWidget {
  final Function(String) onTextContentAdded;
  final Function() onImageContentAdded;

  AddContentDialog(
      {required this.onTextContentAdded, required this.onImageContentAdded});

  @override
  _AddContentDialogState createState() => _AddContentDialogState();
}

class _AddContentDialogState extends State<AddContentDialog> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Content'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.text_fields),
            title: Text('Text'),
            onTap: () async {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => EditTextContentDialog(
                  textEditingController: TextEditingController(),
                  onTextSaved: widget.onTextContentAdded,
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text('Image'),
            onTap: () async {
              Navigator.pop(context);
              widget.onImageContentAdded();
            },
          ),
          ListTile(
            leading: Icon(Icons.videocam),
            title: Text('Video'),
            onTap: () async {
              final videoContent = VideoContent(videoUrl: '');
              Navigator.pop(context);
              widget.onTextContentAdded(_textEditingController.text);
            },
          ),
        ],
      ),
    );
  }
}

class EditTextContentDialog extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function(String) onTextSaved;

  EditTextContentDialog({
    required this.textEditingController,
    required this.onTextSaved,
  });

  @override
  _EditTextContentDialogState createState() => _EditTextContentDialogState();
}

class _EditTextContentDialogState extends State<EditTextContentDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Text'),
      content: TextField(
        controller: widget.textEditingController,
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onTextSaved(widget.textEditingController.text);
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}

class ImageDialog extends StatefulWidget {
  final List<ImageContent> imageContents;
  final ImageContent initialImageContent;

  ImageDialog({required this.imageContents, required this.initialImageContent});

  @override
  _ImageDialogState createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.imageContents.indexOf(widget.initialImageContent);
  }

  void _swipeImage(int direction) {
    setState(() {
      _currentIndex += direction;
      if (_currentIndex >= widget.imageContents.length) {
        _currentIndex = 0;
      } else if (_currentIndex < 0) {
        _currentIndex = widget.imageContents.length - 1;
      }
    });
  }

  void _deleteImage() {
    final deletedImageContent = widget.imageContents[_currentIndex];
    final activity = context
        .findAncestorStateOfType<_ActivityPageState>()!
        .activities[_currentIndex];
    final activityPageState =
        context.findAncestorStateOfType<_ActivityPageState>()!;
    activityPageState._deleteImageContent(activity, deletedImageContent);

    setState(() {
      widget.imageContents.removeAt(_currentIndex);
      if (_currentIndex >= widget.imageContents.length) {
        _currentIndex = widget.imageContents.length - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final imageContent = widget.imageContents[_currentIndex];
    return Dialog(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null) {
            _swipeImage(details.primaryVelocity! > 0 ? -1 : 1);
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.network(
              imageContent.imageUrl,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => _swipeImage(-1),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () => _swipeImage(1),
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: ElevatedButton.icon(
                onPressed: _deleteImage,
                icon: Icon(Icons.delete),
                label: Text('Delete'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
