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
          .doc(activity.id)
          .update({'contents': activity.toMap()['contents']});
    } catch (e) {
      print('Error updating activity contents: $e');
    }
  }

  Future<void> addActivity(Activity activity) async {
    try {
      DocumentReference docRef =
          await firestore.collection('Activities').add(activity.toMap());
      activity.id = docRef.id;

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
      activity.currentImageContent = ImageContent(imageUrl: '');
    }
    await updateActivityContents(activity);

    final firebase_storage.Reference reference =
        firebase_storage.FirebaseStorage.instance.refFromURL(content.imageUrl);
    try {
      await reference.delete();
    } catch (e) {
      print('Error deleting image from Firebase Storage: $e');
    }

    setState(() {});
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
                    id: '',
                    documentId: '',
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
      return TextContent(text: '');
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
