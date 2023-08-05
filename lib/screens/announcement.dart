/*import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementPage extends StatefulWidget {
  final String branchName;

  AnnouncementPage({required this.branchName});

  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  List<Announcement> mainBranchAnnouncements = [];
  List<Announcement> localBranchAnnouncements = [];

  @override
  void initState() {
    super.initState();
    _fetchAnnouncements();
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
              'Announcement',
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
            _buildAnnouncementSection(
              'Main Branch Announcement',
              mainBranchAnnouncements,
              isMainBranch: true,
            ),
            _buildAnnouncementSection(
              '${widget.branchName} Announcement',
              localBranchAnnouncements,
              isMainBranch: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementSection(
    String sectionTitle,
    List<Announcement> announcements, {
    required bool isMainBranch,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                sectionTitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                onPressed: () => _addAnnouncement(isMainBranch),
                icon: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (announcements.isNotEmpty)
                  ...announcements.asMap().entries.map((entry) {
                    int index = entry.key;
                    Announcement announcement = entry.value;

                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      child: Column(
                        children: [
                          if (announcement.text != null) ...[
                            ListTile(
                              leading: Icon(
                                IconData(announcement.icon,
                                    fontFamily: 'MaterialIcons'),
                              ),
                              title: Text(announcement.text!),
                            ),
                            SizedBox(height: 8),
                          ],
                          if (announcement.imageUrl != null)
                            GestureDetector(
                              onTap: () => _showFullImage(
                                  context, announcement.imageUrl!),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(announcement.imageUrl!,
                                    fit: BoxFit.cover),
                              ),
                            ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteImageAnnouncement(
                                isMainBranch, announcements, index),
                          ),
                        ],
                      ),
                    );
                  }).toList()
                else
                  Text('No announcement'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFullImage(BuildContext context, String imageUrl) {
    if (imageUrl != null) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Image.network(imageUrl),
        ),
      );
    }
  }

  void _addAnnouncement(bool isMainBranch) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Announcement'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(FluentIcons.note_20_filled),
                  title: Text('Text Announcement'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _addTextAnnouncement(isMainBranch);
                  },
                ),
                ListTile(
                  leading: Icon(FluentIcons.image_24_regular),
                  title: Text('Image Announcement'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _addImageAnnouncement(isMainBranch);
                  },
                ),
                ListTile(
                  leading: Icon(FluentIcons.video_clip_24_regular),
                  title: Text('Video Announcement'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _addVideoAnnouncement(isMainBranch);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addTextAnnouncement(bool isMainBranch) {
    String text = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                setState(() {
                  final newAnnouncement = Announcement(
                    icon: FluentIcons.note_20_filled
                        .codePoint, // Store the icon as an integer
                    text: text,
                  );

                  if (isMainBranch) {
                    mainBranchAnnouncements.add(newAnnouncement);
                    _updateFirestoreAnnouncements(
                        "BHEL", mainBranchAnnouncements);
                  } else {
                    localBranchAnnouncements.add(newAnnouncement);
                    _updateFirestoreAnnouncements(
                        widget.branchName, localBranchAnnouncements);
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

  void _addVideoAnnouncement(bool isMainBranch) {
    // Implement the functionality to add video announcement
    // This method can be similar to _addImageAnnouncement method, but for videos.
    print('Add video announcement');
  }

  void _addImageAnnouncement(bool isMainBranch) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String imageUrl = await _uploadImageToFirebase(pickedFile.path);

      setState(() {
        final newAnnouncement = Announcement(
          icon: FluentIcons
              .image_24_regular.codePoint, // Store the icon as an integer
          imageUrl: imageUrl,
        );

        if (isMainBranch) {
          mainBranchAnnouncements.add(newAnnouncement);
          _updateFirestoreAnnouncements("BHEL", mainBranchAnnouncements);
        } else {
          localBranchAnnouncements.add(newAnnouncement);
          _updateFirestoreAnnouncements(
              widget.branchName, localBranchAnnouncements);
        }
      });
    }
  }

  Future<String> _uploadImageToFirebase(String imagePath) async {
    File imageFile = File(imagePath);
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child("images/$imageName");
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  Future<void> _fetchAnnouncements() async {
    // Fetch main branch announcements
    DocumentSnapshot mainBranchSnapshot = await FirebaseFirestore.instance
        .collection("Announcements")
        .doc("BHEL")
        .get();
    if (mainBranchSnapshot.exists) {
      var data = mainBranchSnapshot.data();
      if (data != null &&
          data is Map<String, dynamic> &&
          data['announcements'] != null) {
        setState(() {
          mainBranchAnnouncements = parseAnnouncements(data['announcements']);
        });
      }
    }

    // Fetch local branch announcements
    DocumentSnapshot localBranchSnapshot = await FirebaseFirestore.instance
        .collection("Announcements")
        .doc(widget.branchName)
        .get();
    if (localBranchSnapshot.exists) {
      var data = localBranchSnapshot.data();
      if (data != null &&
          data is Map<String, dynamic> &&
          data['announcements'] != null) {
        setState(() {
          localBranchAnnouncements = parseAnnouncements(data['announcements']);
        });
      }
    }
  }

  void _updateFirestoreAnnouncements(
      String branchName, List<Announcement> announcements) {
    List<Map<String, dynamic>> serializedAnnouncements =
        announcements.map((announcement) {
      return {
        'icon': announcement.icon,
        'text': announcement.text,
        'imageUrl': announcement.imageUrl,
      };
    }).toList();

    FirebaseFirestore.instance.collection("Announcements").doc(branchName).set({
      'announcements': serializedAnnouncements,
      'branchName': branchName,
    }).then((_) {
      // Trigger a rebuild to update the displayed announcements.
      setState(() {});
    });
  }

  void _deleteImageAnnouncement(
      bool isMainBranch, List<Announcement> announcements, int index) {
    setState(() {
      if (isMainBranch) {
        mainBranchAnnouncements.removeAt(index);
        _updateFirestoreAnnouncements("BHEL", mainBranchAnnouncements);
      } else {
        localBranchAnnouncements.removeAt(index);
        _updateFirestoreAnnouncements(
            widget.branchName, localBranchAnnouncements);
      }
    });
  }

  List<Announcement> parseAnnouncements(List<dynamic> announcements) {
    return announcements
        .map((announcement) => Announcement(
              icon: announcement['icon'],
              text: announcement['text'],
              imageUrl: announcement['imageUrl'],
            ))
        .toList();
  }
}

class Announcement {
  final int icon; // Store the icon as an integer (code point)
  final String? text;
  final String? imageUrl;

  Announcement({
    required this.icon,
    this.text,
    this.imageUrl,
  });
}
*/
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementPage extends StatefulWidget {
  final String branchName;

  AnnouncementPage({required this.branchName});

  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  List<Announcement> mainBranchAnnouncements = [];
  List<Announcement> localBranchAnnouncements = [];

  @override
  void initState() {
    super.initState();
    _fetchLocalBranchAnnouncements();
    _fetchMainBranchAnnouncements(); // Call this method to fetch local branch announcements
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
              'Announcement',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildAnnouncementSection(
              'Main Branch Announcement',
              mainBranchAnnouncements,
              isMainBranch: true,
            ),
          ),
          Expanded(
            child: _buildAnnouncementSection(
              '${widget.branchName} Announcement',
              localBranchAnnouncements,
              isMainBranch: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementSection(
    String sectionTitle,
    List<Announcement> announcements, {
    required bool isMainBranch,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                sectionTitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                onPressed: () => _addAnnouncement(isMainBranch),
                icon: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                Announcement announcement = announcements[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: Column(
                    children: [
                      if (announcement.text != null) ...[
                        ListTile(
                          leading: Icon(
                            IconData(announcement.icon,
                                fontFamily: 'MaterialIcons'),
                          ),
                          title: Text(announcement.text!),
                        ),
                        SizedBox(height: 8),
                      ],
                      if (announcement.imageUrl != null)
                        GestureDetector(
                          onTap: () =>
                              _showFullImage(context, announcement.imageUrl!),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.network(
                              announcement.imageUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () =>
                            _deleteImageAnnouncement(isMainBranch, index),
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

  void _showFullImage(BuildContext context, String imageUrl) {
    if (imageUrl != null) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Image.network(imageUrl),
        ),
      );
    }
  }

  void _addAnnouncement(bool isMainBranch) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Announcement'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(FluentIcons.note_20_filled),
                  title: Text('Text Announcement'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _addTextAnnouncement(isMainBranch);
                  },
                ),
                ListTile(
                  leading: Icon(FluentIcons.image_24_regular),
                  title: Text('Image Announcement'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _addImageAnnouncement(isMainBranch);
                  },
                ),
                ListTile(
                  leading: Icon(FluentIcons.video_clip_24_regular),
                  title: Text('Video Announcement'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _addVideoAnnouncement(isMainBranch);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addTextAnnouncement(bool isMainBranch) {
    String text = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                setState(() {
                  final newAnnouncement = Announcement(
                    icon: FluentIcons.note_20_filled.codePoint,
                    text: text,
                  );

                  if (isMainBranch) {
                    mainBranchAnnouncements.add(newAnnouncement);
                    _updateFirestoreAnnouncements(
                      "bhel",
                      mainBranchAnnouncements,
                    );
                  } else {
                    localBranchAnnouncements.add(newAnnouncement);
                    _updateFirestoreAnnouncements(
                      widget.branchName,
                      localBranchAnnouncements,
                    );
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

  void _addVideoAnnouncement(bool isMainBranch) {
    // Implement the functionality to add video announcement
    // This method can be similar to _addImageAnnouncement method, but for videos.
    print('Add video announcement');
  }

  void _addImageAnnouncement(bool isMainBranch) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String imageUrl = await _uploadImageToFirebase(pickedFile.path);

      setState(() {
        final newAnnouncement = Announcement(
          icon: FluentIcons.image_24_regular.codePoint,
          imageUrl: imageUrl,
        );

        if (isMainBranch) {
          mainBranchAnnouncements.add(newAnnouncement);
          _updateFirestoreAnnouncements(
            "bhel",
            mainBranchAnnouncements,
          );
        } else {
          localBranchAnnouncements.add(newAnnouncement);
          _updateFirestoreAnnouncements(
            widget.branchName,
            localBranchAnnouncements,
          );
        }
      });
    }
  }

  Future<String> _uploadImageToFirebase(String imagePath) async {
    File imageFile = File(imagePath);
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child("images/$imageName");
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  void _fetchLocalBranchAnnouncements() async {
    // Fetch local branch announcements
    DocumentSnapshot localBranchSnapshot = await FirebaseFirestore.instance
        .collection("Announcements")
        .doc(widget.branchName)
        .get();
    if (localBranchSnapshot.exists) {
      var data = localBranchSnapshot.data();
      if (data != null &&
          data is Map<String, dynamic> &&
          data['announcements'] != null) {
        setState(() {
          localBranchAnnouncements = parseAnnouncements(data['announcements']);
        });
      }
    }
  }

  void _fetchMainBranchAnnouncements() async {
    // Fetch main branch announcements (branchName = 'bhel')
    DocumentSnapshot mainBranchSnapshot = await FirebaseFirestore.instance
        .collection("Announcements")
        .doc("bhel")
        .get();
    if (mainBranchSnapshot.exists) {
      var data = mainBranchSnapshot.data();
      if (data != null &&
          data is Map<String, dynamic> &&
          data['announcements'] != null) {
        setState(() {
          mainBranchAnnouncements = parseAnnouncements(data['announcements']);
        });
      }
    }
  }

  void _deleteImageAnnouncement(bool isMainBranch, int index) {
    setState(() {
      if (isMainBranch) {
        mainBranchAnnouncements.removeAt(index);
        _updateFirestoreAnnouncements("bhel", mainBranchAnnouncements);
      } else {
        localBranchAnnouncements.removeAt(index);
        _updateFirestoreAnnouncements(
          widget.branchName,
          localBranchAnnouncements,
        );
      }
    });
  }

  List<Announcement> parseAnnouncements(List<dynamic> announcements) {
    return announcements
        .map((announcement) => Announcement(
              icon: announcement['icon'],
              text: announcement['text'],
              imageUrl: announcement['imageUrl'],
            ))
        .toList();
  }

  void _updateFirestoreAnnouncements(
      String branchName, List<Announcement> announcements) {
    List<Map<String, dynamic>> serializedAnnouncements =
        announcements.map((announcement) {
      return {
        'icon': announcement.icon,
        'text': announcement.text,
        'imageUrl': announcement.imageUrl,
      };
    }).toList();

    FirebaseFirestore.instance.collection("Announcements").doc(branchName).set({
      'announcements': serializedAnnouncements,
      'branchName': branchName,
    }).then((_) {
      // Trigger a rebuild to update the displayed announcements.
      setState(() {});
    });
  }
}

class Announcement {
  final int icon;
  final String? text;
  final String? imageUrl;

  Announcement({
    required this.icon,
    this.text,
    this.imageUrl,
  });
}
