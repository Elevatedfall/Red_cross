/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NextPage extends StatefulWidget {
  final String subBranchId;

  NextPage({required this.subBranchId});

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> members = [];

  Future<void> _updateSecretaryName(String newName) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'secretaryName': newName});
  }

  Future<void> _updateSecretaryContact(String newContact) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'secretaryContact': newContact});
  }

  Future<void> _updateMembers(List<String> updatedMembers) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'members': updatedMembers});
  }

  void _addMember() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newMember = '';
        return AlertDialog(
          title: Text('Add Member'),
          content: TextField(
            onChanged: (value) {
              newMember = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  members.add(newMember);
                  _updateMembers(members);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firestore
            .collection('Branches')
            .doc(widget.subBranchId)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            final subBranchData =
                snapshot.data!.data() as Map<String, dynamic>?;

            if (subBranchData != null) {
              members = List<String>.from(
                  subBranchData['members'] as List<dynamic>? ?? []);

              return SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Branch Address:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subBranchData['branchAddress'] as String? ?? 'NA',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Contact Details:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subBranchData['contactDetails'] as String? ?? 'NA',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Secretary Name:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subBranchData['secretaryName'] as String? ?? 'NA',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            String newSecretaryName = '';
                            return AlertDialog(
                              title: Text('Edit Secretary Name'),
                              content: TextField(
                                onChanged: (value) {
                                  newSecretaryName = value;
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _updateSecretaryName(newSecretaryName);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Save'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Edit Secretary Name'),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Secretary Contact:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subBranchData['secretaryContact'] as String? ?? 'NA',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            String newSecretaryContact = '';
                            return AlertDialog(
                              title: Text('Edit Secretary Contact'),
                              content: TextField(
                                onChanged: (value) {
                                  newSecretaryContact = value;
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _updateSecretaryContact(
                                        newSecretaryContact);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Save'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Edit Secretary Contact'),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Members:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _addMember,
                      child: Text('Add Members'),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: members.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(members[index]),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text('Sub-branch data not found'));
            }
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NextPage extends StatefulWidget {
  final String subBranchId;

  NextPage({required this.subBranchId});

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> members = [];

  Future<void> _updateSecretaryName(String newName) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'secretaryName': newName});
  }

  Future<void> _updateSecretaryContact(String newContact) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'secretaryContact': newContact});
  }

  Future<void> _updateMembers(List<String> updatedMembers) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'members': updatedMembers});
  }

  void _addMember() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newMember = '';
        return AlertDialog(
          title: Text('Add Member'),
          content: TextField(
            onChanged: (value) {
              newMember = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  members.add(newMember);
                  _updateMembers(members);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firestore
            .collection('Branches')
            .doc(widget.subBranchId)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            final subBranchData =
                snapshot.data!.data() as Map<String, dynamic>?;

            if (subBranchData != null) {
              members = List<String>.from(
                  subBranchData['members'] as List<dynamic>? ?? []);

              return SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Branch Address:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subBranchData['branchAddress'] as String? ?? 'NA',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Contact Details:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subBranchData['contactDetails'] as String? ?? 'NA',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Secretary Name:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subBranchData['secretaryName'] as String? ?? 'NA',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            String newSecretaryName = '';
                            return AlertDialog(
                              title: Text('Edit Secretary Name'),
                              content: TextField(
                                onChanged: (value) {
                                  newSecretaryName = value;
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _updateSecretaryName(newSecretaryName);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Save'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Edit Secretary Name'),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Secretary Contact:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subBranchData['secretaryContact'] as String? ?? 'NA',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            String newSecretaryContact = '';
                            return AlertDialog(
                              title: Text('Edit Secretary Contact'),
                              content: TextField(
                                onChanged: (value) {
                                  newSecretaryContact = value;
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _updateSecretaryContact(
                                        newSecretaryContact);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Save'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Edit Secretary Contact'),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Members:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _addMember,
                      child: Text('Add Members'),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: members.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(members[index]),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text('Sub-branch data not found'));
            }
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
*/

/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NextPage extends StatefulWidget {
  final String subBranchId;

  NextPage({required this.subBranchId});

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> members = [];

  Future<void> _updateSecretaryName(String newName) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'secretaryName': newName});
  }

  Future<void> _updateSecretaryContact(String newContact) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'secretaryContact': newContact});
  }

  Future<void> _updateMembers(List<String> updatedMembers) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'members': updatedMembers});
  }

  void _addMember() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newMember = '';
        return AlertDialog(
          title: Text('Add Member'),
          content: TextField(
            onChanged: (value) {
              newMember = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  members.add(newMember);
                  _updateMembers(members);
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
              'Branch',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firestore
            .collection('Branches')
            .doc(widget.subBranchId)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            final subBranchData =
                snapshot.data!.data() as Map<String, dynamic>?;

            if (subBranchData != null) {
              members = List<String>.from(
                  subBranchData['members'] as List<dynamic>? ?? []);

              return SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Branch Address:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subBranchData['branchAddress'] as String? ?? 'NA',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Contact Details:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subBranchData['contactDetails'] as String? ?? 'NA',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Secretary Name:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subBranchData['secretaryName'] as String? ?? 'NA',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            String newSecretaryName = '';
                            return AlertDialog(
                              title: Text('Edit Secretary Name'),
                              content: TextField(
                                onChanged: (value) {
                                  newSecretaryName = value;
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _updateSecretaryName(newSecretaryName);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Save'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Edit Secretary Name'),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Secretary Contact:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subBranchData['secretaryContact'] as String? ?? 'NA',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            String newSecretaryContact = '';
                            return AlertDialog(
                              title: Text('Edit Secretary Contact'),
                              content: TextField(
                                onChanged: (value) {
                                  newSecretaryContact = value;
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _updateSecretaryContact(
                                        newSecretaryContact);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Save'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Edit Secretary Contact'),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Members:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _addMember,
                      child: Text('Add Members'),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: members.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(members[index]),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text('Sub-branch data not found'));
            }
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NextPage extends StatefulWidget {
  final String subBranchId;

  NextPage({required this.subBranchId});

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> members = [];

  Future<void> _updateSecretaryName(String newName) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'secretaryName': newName});
  }

  Future<void> _updateSecretaryContact(String newContact) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'secretaryContact': newContact});
  }

  Future<void> _updateMembers(List<String> updatedMembers) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'members': updatedMembers});
  }

  void _addMember() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newMember = '';
        return AlertDialog(
          title: Text('Add Member'),
          content: TextField(
            onChanged: (value) {
              newMember = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  members.add(newMember);
                  _updateMembers(members);
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
              'Branch',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Branches')
              .doc(widget.subBranchId)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Center(child: Text('Sub-branch data not found'));
            }

            final subBranchData =
                snapshot.data!.data() as Map<String, dynamic>?;

            if (subBranchData == null) {
              return Center(child: Text('Sub-branch data not available'));
            }

            final String branchAddress = subBranchData['branchAddress'] ?? 'NA';
            final String contactDetails =
                subBranchData['contactDetails'] ?? 'NA';
            final String secretaryName = subBranchData['secretaryName'] ?? 'NA';
            final String secretaryContact =
                subBranchData['secretaryContact'] ?? 'NA';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Branch Address:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  branchAddress,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.contact_mail),
                    SizedBox(width: 8),
                    Text(
                      'Contact Details:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  contactDetails,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Secretary:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    'Name: $secretaryName',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newSecretaryName = secretaryName;
                          return AlertDialog(
                            title: Text('Edit Secretary Name'),
                            content: TextField(
                              onChanged: (value) {
                                newSecretaryName = value;
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _updateSecretaryName(newSecretaryName);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(
                    'Contact: $secretaryContact',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newSecretaryContact = secretaryContact;
                          return AlertDialog(
                            title: Text('Edit Secretary Contact'),
                            content: TextField(
                              onChanged: (value) {
                                newSecretaryContact = value;
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _updateSecretaryContact(newSecretaryContact);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Members:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _addMember,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 8),
                      Text('Add Member'),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: members.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(Icons.person),
                      title: Text(members[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              String editedMember = members[index];
                              return AlertDialog(
                                title: Text('Edit Member'),
                                content: TextField(
                                  controller:
                                      TextEditingController(text: editedMember),
                                  onChanged: (value) {
                                    editedMember = value;
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        members[index] = editedMember;
                                        _updateMembers(members);
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Save'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
*/

/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NextPage extends StatefulWidget {
  final String subBranchId;

  NextPage({required this.subBranchId});

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _branchAddressController =
      TextEditingController();
  final TextEditingController _contactDetailsController =
      TextEditingController();
  final TextEditingController _secretaryNameController =
      TextEditingController();
  final TextEditingController _secretaryContactController =
      TextEditingController();
  List<String> members = [];

  @override
  void initState() {
    super.initState();
    fetchBranchData();
  }

  @override
  void dispose() {
    _branchAddressController.dispose();
    _contactDetailsController.dispose();
    _secretaryNameController.dispose();
    _secretaryContactController.dispose();
    super.dispose();
  }

  Future<void> fetchBranchData() async {
    try {
      // Fetch the branch data from Firestore
      DocumentSnapshot branchSnapshot =
          await _firestore.collection('Branches').doc(widget.subBranchId).get();

      if (branchSnapshot.exists) {
        Map<String, dynamic> branchData =
            branchSnapshot.data() as Map<String, dynamic>;

        setState(() {
          // Update the branch data
          _branchAddressController.text = branchData['branchAddress'] ?? 'N/A';
          _contactDetailsController.text =
              branchData['contactDetails'] ?? 'N/A';
          _secretaryNameController.text = branchData['secretaryName'] ?? 'N/A';
          _secretaryContactController.text =
              branchData['secretaryContact'] ?? 'N/A';
          members = List<String>.from(branchData['members'] ?? []);
        });
      }
    } catch (e) {
      print('Error fetching branch data: $e');
    }
  }

  void _addMember() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newMember = '';
        return AlertDialog(
          title: Text('Add Member'),
          content: TextField(
            onChanged: (value) {
              newMember = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  members.add(newMember);
                  _updateMembers(members);
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

  Future<void> _updateMembers(List<String> updatedMembers) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'members': updatedMembers});
  }

  Future<void> _updateSecretaryName(String newName) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'secretaryName': newName});
  }

  Future<void> _updateSecretaryContact(String newContact) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'secretaryContact': newContact});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Branch Address:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: _branchAddressController,
              readOnly: true,
            ),
            SizedBox(height: 16),
            Text(
              'Contact Details:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: _contactDetailsController,
              readOnly: true,
            ),
            SizedBox(height: 16),
            Text(
              'Secretary Name:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: _secretaryNameController,
              readOnly: true,
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String newSecretaryName = _secretaryNameController.text;
                    return AlertDialog(
                      title: Text('Edit Secretary Name'),
                      content: TextField(
                        onChanged: (value) {
                          newSecretaryName = value;
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _updateSecretaryName(newSecretaryName);
                            Navigator.of(context).pop();
                          },
                          child: Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Edit Secretary Name'),
            ),
            SizedBox(height: 16),
            Text(
              'Secretary Contact:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: _secretaryContactController,
              readOnly: true,
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String newSecretaryContact =
                        _secretaryContactController.text;
                    return AlertDialog(
                      title: Text('Edit Secretary Contact'),
                      content: TextField(
                        onChanged: (value) {
                          newSecretaryContact = value;
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _updateSecretaryContact(newSecretaryContact);
                            Navigator.of(context).pop();
                          },
                          child: Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Edit Secretary Contact'),
            ),
            SizedBox(height: 16),
            Text(
              'Members:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: _addMember,
              child: Text('Add Members'),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: members.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(members[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
*/

/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NextPage extends StatefulWidget {
  final String subBranchId;

  NextPage({required this.subBranchId});

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _branchAddressController =
      TextEditingController();
  final TextEditingController _contactDetailsController =
      TextEditingController();
  final TextEditingController _secretaryNameController =
      TextEditingController();
  final TextEditingController _secretaryContactController =
      TextEditingController();
  List<String> members = [];

  @override
  void initState() {
    super.initState();
    fetchBranchData();
  }

  @override
  void dispose() {
    _branchAddressController.dispose();
    _contactDetailsController.dispose();
    _secretaryNameController.dispose();
    _secretaryContactController.dispose();
    super.dispose();
  }

  Future<void> fetchBranchData() async {
    try {
      // Fetch the branch document from Firestore
      QuerySnapshot querySnapshot = await _firestore
          .collection('Branches')
          .where('subBranch', isEqualTo: widget.subBranchId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot branchSnapshot = querySnapshot.docs.first;
        if (branchSnapshot.exists) {
          Map<String, dynamic> branchData =
              branchSnapshot.data() as Map<String, dynamic>;

          setState(() {
            // Update the branch data
            _branchAddressController.text =
                branchData['branchAddress'] ?? 'N/A';
            _contactDetailsController.text =
                branchData['contactDetails'] ?? 'N/A';
            _secretaryNameController.text =
                branchData['secretaryName'] ?? 'N/A';
            _secretaryContactController.text =
                branchData['secretaryContact'] ?? 'N/A';
            members = List<String>.from(branchData['members'] ?? []);
          });
        }
      } else {
        print(
            'Document with subBranchId ${widget.subBranchId} does not exist in Firestore.');
      }
    } catch (e) {
      print('Error fetching branch data: $e');
    }
  }

  void _addMember() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newMember = '';
        return AlertDialog(
          title: Text('Add Member'),
          content: TextField(
            onChanged: (value) {
              newMember = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  members.add(newMember);
                  _updateMembers(members);
                  members = List<String>.from(members);
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

  Future<void> _updateMembers(List<String> updatedMembers) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument.update({'members': updatedMembers}).then((_) {
        print('Members updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating members in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
  }

  Future<void> _updateSecretaryName(String newName) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'secretaryName': newName});
  }

  Future<void> _updateSecretaryContact(String newContact) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'secretaryContact': newContact});
  }

  Future<void> _updateBranchAddress(String newAddress) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'branchAddress': newAddress});
  }

  Future<void> _updateContactDetails(String newDetails) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'contactDetails': newDetails});
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
              widget.subBranchId[0].toUpperCase() +
                  widget.subBranchId.substring(1).toLowerCase(),
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Branch Address:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newBranchAddress =
                              _branchAddressController.text;
                          return AlertDialog(
                            title: Text('Edit Branch Address'),
                            content: TextField(
                              onChanged: (value) {
                                newBranchAddress = value;
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _branchAddressController.text =
                                        newBranchAddress;
                                    _updateBranchAddress(newBranchAddress);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: TextFormField(
                controller: _branchAddressController,
                readOnly: true,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Contact Details:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newContactDetails =
                              _contactDetailsController.text;
                          return AlertDialog(
                            title: Text('Edit Contact Details'),
                            content: TextField(
                              onChanged: (value) {
                                newContactDetails = value;
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _contactDetailsController.text =
                                        newContactDetails;
                                    _updateContactDetails(newContactDetails);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: TextFormField(
                controller: _contactDetailsController,
                readOnly: true,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Secretary Name:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newSecretaryName =
                              _secretaryNameController.text;
                          return AlertDialog(
                            title: Text('Edit Secretary Name'),
                            content: TextField(
                              onChanged: (value) {
                                newSecretaryName = value;
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _secretaryNameController.text =
                                        newSecretaryName;
                                    _updateSecretaryName(newSecretaryName);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: TextFormField(
                controller: _secretaryNameController,
                readOnly: true,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Secretary Contact:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newSecretaryContact =
                              _secretaryContactController.text;
                          return AlertDialog(
                            title: Text('Edit Secretary Contact'),
                            content: TextField(
                              onChanged: (value) {
                                newSecretaryContact = value;
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _secretaryContactController.text =
                                        newSecretaryContact;
                                    _updateSecretaryContact(
                                        newSecretaryContact);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: TextFormField(
                controller: _secretaryContactController,
                readOnly: true,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Members:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: _addMember,
              child: Text('Add Members'),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: members.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(members[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NextPage extends StatefulWidget {
  final String subBranchId;

  NextPage({required this.subBranchId});

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _branchAddressController =
      TextEditingController();
  final TextEditingController _contactDetailsController =
      TextEditingController();
  final TextEditingController _secretaryNameController =
      TextEditingController();
  final TextEditingController _secretaryContactController =
      TextEditingController();
  List<String> members = [];

  @override
  void initState() {
    super.initState();
    fetchBranchData();
  }

  @override
  void dispose() {
    _branchAddressController.dispose();
    _contactDetailsController.dispose();
    _secretaryNameController.dispose();
    _secretaryContactController.dispose();
    super.dispose();
  }

  Future<void> fetchBranchData() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Branches')
          .where('subBranch', isEqualTo: widget.subBranchId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot branchSnapshot = querySnapshot.docs.first;
        if (branchSnapshot.exists) {
          Map<String, dynamic> branchData =
              branchSnapshot.data() as Map<String, dynamic>;

          setState(() {
            // Update the branch data
            _branchAddressController.text =
                branchData['branchAddress'] ?? 'N/A';
            _contactDetailsController.text =
                branchData['contactDetails'] ?? 'N/A';
            _secretaryNameController.text =
                branchData['secretaryName'] ?? 'N/A';
            _secretaryContactController.text =
                branchData['secretaryContact'] ?? 'N/A';
            members = List<String>.from(branchData['members'] ?? []);
          });
        }
      } else {
        print(
            'Document with subBranchId ${widget.subBranchId} does not exist in Firestore.');
      }
    } catch (e) {
      print('Error fetching branch data: $e');
    }
  }

  void _addMember() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newMember = '';
        return AlertDialog(
          title: Text('Add Member'),
          content: TextField(
            onChanged: (value) {
              newMember = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  members.add(newMember);
                  _updateMembers(members);
                  members = List<String>.from(members);
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

  Future<void> _updateMembers(List<String> updatedMembers) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument.update({'members': updatedMembers}).then((_) {
        print('Members updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating members in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
  }

  Future<void> _updateSecretaryName(String newName) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'secretaryName': newName}).then((_) {
      print('Secretary Name updated successfully in Firestore.');
    }).catchError((error) {
      print('Error updating Secretary Name in Firestore: $error');
    });
  }

  Future<void> _updateSecretaryContact(String newContact) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'secretaryContact': newContact}).then((_) {
      print('Secretary Contact updated successfully in Firestore.');
    }).catchError((error) {
      print('Error updating Secretary Contact in Firestore: $error');
    });
  }

  Future<void> _updateBranchAddress(String newAddress) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'branchAddress': newAddress}).then((_) {
      print('Branch Address updated successfully in Firestore.');
    }).catchError((error) {
      print('Error updating Branch Address in Firestore: $error');
    });
  }

  Future<void> _updateContactDetails(String newDetails) async {
    final subBranchDoc =
        _firestore.collection('Branches').doc(widget.subBranchId);
    await subBranchDoc.update({'contactDetails': newDetails}).then((_) {
      print('Contact Details updated successfully in Firestore.');
    }).catchError((error) {
      print('Error updating Contact Details in Firestore: $error');
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
              widget.subBranchId[0].toUpperCase() +
                  widget.subBranchId.substring(1).toLowerCase(),
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Branch Address:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newBranchAddress =
                              _branchAddressController.text;
                          return AlertDialog(
                            title: Text('Edit Branch Address'),
                            content: TextField(
                              onChanged: (value) {
                                newBranchAddress = value;
                              },
                              controller: TextEditingController(
                                text: newBranchAddress,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _branchAddressController.text =
                                        newBranchAddress;
                                    _updateBranchAddress(newBranchAddress);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: TextFormField(
                controller: _branchAddressController,
                readOnly: true,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Contact Details:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newContactDetails =
                              _contactDetailsController.text;
                          return AlertDialog(
                            title: Text('Edit Contact Details'),
                            content: TextField(
                              onChanged: (value) {
                                newContactDetails = value;
                              },
                              controller: TextEditingController(
                                text: newContactDetails,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _contactDetailsController.text =
                                        newContactDetails;
                                    _updateContactDetails(newContactDetails);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: TextFormField(
                controller: _contactDetailsController,
                readOnly: true,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Secretary Name:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newSecretaryName =
                              _secretaryNameController.text;
                          return AlertDialog(
                            title: Text('Edit Secretary Name'),
                            content: TextField(
                              onChanged: (value) {
                                newSecretaryName = value;
                              },
                              controller: TextEditingController(
                                text: newSecretaryName,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _secretaryNameController.text =
                                        newSecretaryName;
                                    _updateSecretaryName(newSecretaryName);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: TextFormField(
                controller: _secretaryNameController,
                readOnly: true,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Secretary Contact:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newSecretaryContact =
                              _secretaryContactController.text;
                          return AlertDialog(
                            title: Text('Edit Secretary Contact'),
                            content: TextField(
                              onChanged: (value) {
                                newSecretaryContact = value;
                              },
                              controller: TextEditingController(
                                text: newSecretaryContact,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _secretaryContactController.text =
                                        newSecretaryContact;
                                    _updateSecretaryContact(
                                        newSecretaryContact);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: TextFormField(
                controller: _secretaryContactController,
                readOnly: true,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Members:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: _addMember,
              child: Text('Add Members'),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: members.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(members[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
*/

/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NextPage extends StatefulWidget {
  final String subBranchId;

  NextPage({required this.subBranchId});

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _branchAddressController =
      TextEditingController();
  final TextEditingController _contactDetailsController =
      TextEditingController();
  final TextEditingController _secretaryNameController =
      TextEditingController();
  final TextEditingController _secretaryContactController =
      TextEditingController();
  List<String> members = [];

  @override
  void initState() {
    super.initState();
    fetchBranchData();
  }

  @override
  void dispose() {
    _branchAddressController.dispose();
    _contactDetailsController.dispose();
    _secretaryNameController.dispose();
    _secretaryContactController.dispose();
    super.dispose();
  }

  Future<void> fetchBranchData() async {
    try {
      // Fetch the branch document from Firestore
      DocumentSnapshot branchSnapshot =
          await _firestore.collection('Branches').doc(widget.subBranchId).get();

      if (branchSnapshot.exists) {
        Map<String, dynamic> branchData =
            branchSnapshot.data() as Map<String, dynamic>;

        setState(() {
          // Update the branch data
          _branchAddressController.text = branchData['branchAddress'] ?? 'N/A';
          _contactDetailsController.text =
              branchData['contactDetails'] ?? 'N/A';
          _secretaryNameController.text = branchData['secretaryName'] ?? 'N/A';
          _secretaryContactController.text =
              branchData['secretaryContact'] ?? 'N/A';
          members = List<String>.from(branchData['members'] ?? []);
        });
      } else {
        print(
            'Document with subBranchId ${widget.subBranchId} does not exist in Firestore.');
      }
    } catch (e) {
      print('Error fetching branch data: $e');
    }
  }

  void _addMember() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newMember = '';
        return AlertDialog(
          title: Text('Add Member'),
          content: TextField(
            onChanged: (value) {
              newMember = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  members.add(newMember);
                  _updateMembers(members);
                  members = List<String>.from(members);
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

  Future<void> _updateMembers(List<String> updatedMembers) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument.update({'members': updatedMembers}).then((_) {
        print('Members updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating members in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
  }

  Future<void> _updateSecretaryName(String newName) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument.update({'secretaryName': newName}).then((_) {
        print('Secretary Name updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating Secretary Name in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
  }

  Future<void> _updateSecretaryContact(String newContact) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument
          .update({'secretaryContact': newContact}).then((_) {
        print('Secretary Contact updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating Secretary Contact in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
  }

  Future<void> _updateBranchAddress(String newAddress) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument.update({'branchAddress': newAddress}).then((_) {
        print('Branch Address updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating Branch Address in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
  }

  Future<void> _updateContactDetails(String newDetails) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument.update({'contactDetails': newDetails}).then((_) {
        print('Contact Details updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating Contact Details in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
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
              widget.subBranchId[0].toUpperCase() +
                  widget.subBranchId.substring(1).toLowerCase(),
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Branch Address:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newBranchAddress =
                              _branchAddressController.text;
                          return AlertDialog(
                            title: Text('Edit Branch Address'),
                            content: TextField(
                              onChanged: (value) {
                                newBranchAddress = value;
                              },
                              controller: TextEditingController(
                                text: newBranchAddress,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _branchAddressController.text =
                                        newBranchAddress;
                                    _updateBranchAddress(newBranchAddress);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: TextFormField(
                controller: _branchAddressController,
                readOnly: true,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Contact Details:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newContactDetails =
                              _contactDetailsController.text;
                          return AlertDialog(
                            title: Text('Edit Contact Details'),
                            content: TextField(
                              onChanged: (value) {
                                newContactDetails = value;
                              },
                              controller: TextEditingController(
                                text: newContactDetails,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _contactDetailsController.text =
                                        newContactDetails;
                                    _updateContactDetails(newContactDetails);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: TextFormField(
                controller: _contactDetailsController,
                readOnly: true,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Secretary Name:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newSecretaryName =
                              _secretaryNameController.text;
                          return AlertDialog(
                            title: Text('Edit Secretary Name'),
                            content: TextField(
                              onChanged: (value) {
                                newSecretaryName = value;
                              },
                              controller: TextEditingController(
                                text: newSecretaryName,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _secretaryNameController.text =
                                        newSecretaryName;
                                    _updateSecretaryName(newSecretaryName);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: TextFormField(
                controller: _secretaryNameController,
                readOnly: true,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Secretary Contact:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newSecretaryContact =
                              _secretaryContactController.text;
                          return AlertDialog(
                            title: Text('Edit Secretary Contact'),
                            content: TextField(
                              onChanged: (value) {
                                newSecretaryContact = value;
                              },
                              controller: TextEditingController(
                                text: newSecretaryContact,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _secretaryContactController.text =
                                        newSecretaryContact;
                                    _updateSecretaryContact(
                                        newSecretaryContact);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: TextFormField(
                controller: _secretaryContactController,
                readOnly: true,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Members:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: _addMember,
              child: Text('Add Members'),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: members.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(members[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
*/

/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NextPage extends StatefulWidget {
  final String subBranchId;

  NextPage({required this.subBranchId});

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _branchAddressController =
      TextEditingController();
  final TextEditingController _contactDetailsController =
      TextEditingController();
  final TextEditingController _secretaryNameController =
      TextEditingController();
  final TextEditingController _secretaryContactController =
      TextEditingController();
  List<String> members = [];

  @override
  void initState() {
    super.initState();
    fetchBranchData();
  }

  @override
  void dispose() {
    _branchAddressController.dispose();
    _contactDetailsController.dispose();
    _secretaryNameController.dispose();
    _secretaryContactController.dispose();
    super.dispose();
  }

  Future<void> fetchBranchData() async {
    try {
      // Fetch the branch document from Firestore
      QuerySnapshot querySnapshot = await _firestore
          .collection('Branches')
          .where('subBranch', isEqualTo: widget.subBranchId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot branchSnapshot = querySnapshot.docs.first;
        if (branchSnapshot.exists) {
          Map<String, dynamic> branchData =
              branchSnapshot.data() as Map<String, dynamic>;

          setState(() {
            // Update the branch data
            _branchAddressController.text =
                branchData['branchAddress'] ?? 'N/A';
            _contactDetailsController.text =
                branchData['contactDetails'] ?? 'N/A';
            _secretaryNameController.text =
                branchData['secretaryName'] ?? 'N/A';
            _secretaryContactController.text =
                branchData['secretaryContact'] ?? 'N/A';
            members = List<String>.from(branchData['members'] ?? []);
          });
        }
      } else {
        print(
            'Document with subBranchId ${widget.subBranchId} does not exist in Firestore.');
      }
    } catch (e) {
      print('Error fetching branch data: $e');
    }
  }

  void _addMember() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newMember = '';
        return AlertDialog(
          title: Text('Add Member'),
          content: TextField(
            onChanged: (value) {
              newMember = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  members.add(newMember);
                  _updateMembers(members);
                  members = List<String>.from(members);
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

  Future<void> _updateMembers(List<String> updatedMembers) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument.update({'members': updatedMembers}).then((_) {
        print('Members updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating members in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
  }

  Future<void> _updateSecretaryName(String newName) async {
    try {
      await _firestore
          .collection('Branches')
          .doc(widget.subBranchId)
          .update({'secretaryName': newName});

      print('Secretary Name updated successfully in Firestore.');
    } catch (e) {
      print('Error updating Secretary Name in Firestore: $e');
    }
  }

  Future<void> _updateSecretaryContact(String newContact) async {
    try {
      await _firestore
          .collection('Branches')
          .doc(widget.subBranchId)
          .update({'secretaryContact': newContact});

      print('Secretary Contact updated successfully in Firestore.');
    } catch (e) {
      print('Error updating Secretary Contact in Firestore: $e');
    }
  }

  Future<void> _updateBranchAddress(String newAddress) async {
    try {
      await _firestore
          .collection('Branches')
          .doc(widget.subBranchId)
          .update({'branchAddress': newAddress});

      print('Branch Address updated successfully in Firestore.');
    } catch (e) {
      print('Error updating Branch Address in Firestore: $e');
    }
  }

  Future<void> _updateContactDetails(String newDetails) async {
    try {
      await _firestore
          .collection('Branches')
          .doc(widget.subBranchId)
          .update({'contactDetails': newDetails});

      print('Contact Details updated successfully in Firestore.');
    } catch (e) {
      print('Error updating Contact Details in Firestore: $e');
    }
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
              widget.subBranchId[0].toUpperCase() +
                  widget.subBranchId.substring(1).toLowerCase(),
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Branch Address:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newBranchAddress =
                              _branchAddressController.text;
                          return AlertDialog(
                            title: Text('Edit Branch Address'),
                            content: TextField(
                              onChanged: (value) {
                                newBranchAddress = value;
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _branchAddressController.text =
                                        newBranchAddress;
                                    _updateBranchAddress(newBranchAddress);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: TextFormField(
                controller: _branchAddressController,
                readOnly: true,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Contact Details:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newContactDetails =
                              _contactDetailsController.text;
                          return AlertDialog(
                            title: Text('Edit Contact Details'),
                            content: TextField(
                              onChanged: (value) {
                                newContactDetails = value;
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _contactDetailsController.text =
                                        newContactDetails;
                                    _updateContactDetails(newContactDetails);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: TextFormField(
                controller: _contactDetailsController,
                readOnly: true,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Secretary Name:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newSecretaryName =
                              _secretaryNameController.text;
                          return AlertDialog(
                            title: Text('Edit Secretary Name'),
                            content: TextField(
                              onChanged: (value) {
                                newSecretaryName = value;
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _secretaryNameController.text =
                                        newSecretaryName;
                                    _updateSecretaryName(newSecretaryName);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: TextFormField(
                controller: _secretaryNameController,
                readOnly: true,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Secretary Contact:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newSecretaryContact =
                              _secretaryContactController.text;
                          return AlertDialog(
                            title: Text('Edit Secretary Contact'),
                            content: TextField(
                              onChanged: (value) {
                                newSecretaryContact = value;
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _secretaryContactController.text =
                                        newSecretaryContact;
                                    _updateSecretaryContact(
                                        newSecretaryContact);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: TextFormField(
                controller: _secretaryContactController,
                readOnly: true,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Members:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: _addMember,
              child: Text('Add Members'),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: members.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(members[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
*/

/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NextPage extends StatefulWidget {
  final String subBranchId;

  NextPage({required this.subBranchId});

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _branchAddressController =
      TextEditingController();
  final TextEditingController _contactDetailsController =
      TextEditingController();
  final TextEditingController _secretaryNameController =
      TextEditingController();
  final TextEditingController _secretaryContactController =
      TextEditingController();
  List<String> members = [];

  @override
  void initState() {
    super.initState();
    fetchBranchData();
  }

  @override
  void dispose() {
    _branchAddressController.dispose();
    _contactDetailsController.dispose();
    _secretaryNameController.dispose();
    _secretaryContactController.dispose();
    super.dispose();
  }

  Future<void> fetchBranchData() async {
    try {
      // Fetch the branch document from Firestore
      QuerySnapshot querySnapshot = await _firestore
          .collection('Branches')
          .where('subBranch', isEqualTo: widget.subBranchId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot branchSnapshot = querySnapshot.docs.first;
        if (branchSnapshot.exists) {
          Map<String, dynamic> branchData =
              branchSnapshot.data() as Map<String, dynamic>;

          setState(() {
            // Update the branch data
            _branchAddressController.text =
                branchData['branchAddress'] ?? 'N/A';
            _contactDetailsController.text =
                branchData['contactDetails'] ?? 'N/A';
            _secretaryNameController.text =
                branchData['secretaryName'] ?? 'N/A';
            _secretaryContactController.text =
                branchData['secretaryContact'] ?? 'N/A';
            members = List<String>.from(branchData['members'] ?? []);
          });
        }
      } else {
        print(
            'Document with subBranchId ${widget.subBranchId} does not exist in Firestore.');
      }
    } catch (e) {
      print('Error fetching branch data: $e');
    }
  }

  void _addMember() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newMember = '';
        return AlertDialog(
          title: Text('Add Member'),
          content: TextField(
            onChanged: (value) {
              newMember = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  members.add(newMember);
                  _updateMembers(members);
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

  Future<void> _updateMembers(List<String> updatedMembers) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument.update({'members': updatedMembers}).then((_) {
        print('Members updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating members in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
  }

  Future<void> _updateSecretaryName(String newName) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument.update({'secretaryName': newName}).then((_) {
        print('Secretary Name updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating Secretary Name in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
  }

  Future<void> _updateSecretaryContact(String newContact) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument
          .update({'secretaryContact': newContact}).then((_) {
        print('Secretary Contact updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating Secretary Contact in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
  }

  Future<void> _updateBranchAddress(String newAddress) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument.update({'branchAddress': newAddress}).then((_) {
        print('Branch Address updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating Branch Address in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
  }

  Future<void> _updateContactDetails(String newDetails) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument.update({'contactDetails': newDetails}).then((_) {
        print('Contact Details updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating Contact Details in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
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
              widget.subBranchId[0].toUpperCase() +
                  widget.subBranchId.substring(1).toLowerCase(),
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Branch Address:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newBranchAddress =
                              _branchAddressController.text;
                          return AlertDialog(
                            title: Text('Edit Branch Address'),
                            content: TextField(
                              onChanged: (value) {
                                newBranchAddress = value;
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _branchAddressController.text =
                                        newBranchAddress;
                                    _updateBranchAddress(newBranchAddress);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: TextFormField(
                controller: _branchAddressController,
                readOnly: true,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Contact Details:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newContactDetails =
                              _contactDetailsController.text;
                          return AlertDialog(
                            title: Text('Edit Contact Details'),
                            content: TextField(
                              onChanged: (value) {
                                newContactDetails = value;
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _contactDetailsController.text =
                                        newContactDetails;
                                    _updateContactDetails(newContactDetails);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: TextFormField(
                controller: _contactDetailsController,
                readOnly: true,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Secretary Name:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newSecretaryName =
                              _secretaryNameController.text;
                          return AlertDialog(
                            title: Text('Edit Secretary Name'),
                            content: TextField(
                              onChanged: (value) {
                                newSecretaryName = value;
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _secretaryNameController.text =
                                        newSecretaryName;
                                    _updateSecretaryName(newSecretaryName);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: TextFormField(
                controller: _secretaryNameController,
                readOnly: true,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Secretary Contact:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newSecretaryContact =
                              _secretaryContactController.text;
                          return AlertDialog(
                            title: Text('Edit Secretary Contact'),
                            content: TextField(
                              onChanged: (value) {
                                newSecretaryContact = value;
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _secretaryContactController.text =
                                        newSecretaryContact;
                                    _updateSecretaryContact(
                                        newSecretaryContact);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: TextFormField(
                controller: _secretaryContactController,
                readOnly: true,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Members:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: _addMember,
              child: Text('Add Members'),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: members.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(members[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
*/

/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NextPage extends StatefulWidget {
  final String subBranchId;

  NextPage({required this.subBranchId});

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _branchAddressController =
      TextEditingController();
  final TextEditingController _contactDetailsController =
      TextEditingController();
  final TextEditingController _secretaryNameController =
      TextEditingController();
  final TextEditingController _secretaryContactController =
      TextEditingController();
  List<String> members = [];

  @override
  void initState() {
    super.initState();
    fetchBranchData();
  }

  @override
  void dispose() {
    _branchAddressController.dispose();
    _contactDetailsController.dispose();
    _secretaryNameController.dispose();
    _secretaryContactController.dispose();
    super.dispose();
  }

  Future<void> fetchBranchData() async {
    try {
      // Fetch the branch document from Firestore
      QuerySnapshot querySnapshot = await _firestore
          .collection('Branches')
          .where('subBranch', isEqualTo: widget.subBranchId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot branchSnapshot = querySnapshot.docs.first;
        if (branchSnapshot.exists) {
          Map<String, dynamic> branchData =
              branchSnapshot.data() as Map<String, dynamic>;

          setState(() {
            // Update the branch data
            _branchAddressController.text =
                branchData['branchAddress'] ?? 'N/A';
            _contactDetailsController.text =
                branchData['contactDetails'] ?? 'N/A';
            _secretaryNameController.text =
                branchData['secretaryName'] ?? 'N/A';
            _secretaryContactController.text =
                branchData['secretaryContact'] ?? 'N/A';
            members = List<String>.from(branchData['members'] ?? []);
          });
        }
      } else {
        print(
            'Document with subBranchId ${widget.subBranchId} does not exist in Firestore.');
      }
    } catch (e) {
      print('Error fetching branch data: $e');
    }
  }

  void _addMember() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newMember = '';
        return AlertDialog(
          title: Text('Add Member'),
          content: TextField(
            onChanged: (value) {
              newMember = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  members.add(newMember);
                  _updateMembers(members);
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

  Future<void> _updateMembers(List<String> updatedMembers) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument.update({'members': updatedMembers}).then((_) {
        print('Members updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating members in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
  }

  Future<void> _updateSecretaryName(String newName) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument.update({'secretaryName': newName}).then((_) {
        print('Secretary Name updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating Secretary Name in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
  }

  Future<void> _updateSecretaryContact(String newContact) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument
          .update({'secretaryContact': newContact}).then((_) {
        print('Secretary Contact updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating Secretary Contact in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
  }

  Future<void> _updateBranchAddress(String newAddress) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument.update({'branchAddress': newAddress}).then((_) {
        print('Branch Address updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating Branch Address in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
  }

  Future<void> _updateContactDetails(String newDetails) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument.update({'contactDetails': newDetails}).then((_) {
        print('Contact Details updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating Contact Details in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
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
              widget.subBranchId[0].toUpperCase() +
                  widget.subBranchId.substring(1).toLowerCase(),
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 8),
                    Text(
                      'Branch Address',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String newBranchAddress = _branchAddressController.text;
                        return AlertDialog(
                          title: Text('Edit Branch Address'),
                          content: TextField(
                            onChanged: (value) {
                              newBranchAddress = value;
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _branchAddressController.text =
                                      newBranchAddress;
                                  _updateBranchAddress(newBranchAddress);
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text('Save'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                subtitle: TextFormField(
                  controller: _branchAddressController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Row(
                  children: [
                    Icon(Icons.phone),
                    SizedBox(width: 8),
                    Text(
                      'Contact Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String newContactDetails =
                            _contactDetailsController.text;
                        return AlertDialog(
                          title: Text('Edit Contact Details'),
                          content: TextField(
                            onChanged: (value) {
                              newContactDetails = value;
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _contactDetailsController.text =
                                      newContactDetails;
                                  _updateContactDetails(newContactDetails);
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text('Save'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                subtitle: TextFormField(
                  controller: _contactDetailsController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 8),
                    Text(
                      'Secretary Name',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String newSecretaryName = _secretaryNameController.text;
                        return AlertDialog(
                          title: Text('Edit Secretary Name'),
                          content: TextField(
                            onChanged: (value) {
                              newSecretaryName = value;
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _secretaryNameController.text =
                                      newSecretaryName;
                                  _updateSecretaryName(newSecretaryName);
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text('Save'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                subtitle: TextFormField(
                  controller: _secretaryNameController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Row(
                  children: [
                    Icon(Icons.phone),
                    SizedBox(width: 8),
                    Text(
                      'Secretary Contact',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String newSecretaryContact =
                            _secretaryContactController.text;
                        return AlertDialog(
                          title: Text('Edit Secretary Contact'),
                          content: TextField(
                            onChanged: (value) {
                              newSecretaryContact = value;
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _secretaryContactController.text =
                                      newSecretaryContact;
                                  _updateSecretaryContact(newSecretaryContact);
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text('Save'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                subtitle: TextFormField(
                  controller: _secretaryContactController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Members',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: _addMember,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8),
                  Text('Add Members'),
                ],
              ),
            ),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: members.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    title: Text(members[index]),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  final String title;
  final String description;

  Activity({required this.title, required this.description});
}

class NextPage extends StatefulWidget {
  final String subBranchId;

  NextPage({required this.subBranchId});

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _branchAddressController =
      TextEditingController();
  final TextEditingController _contactDetailsController =
      TextEditingController();
  final TextEditingController _secretaryNameController =
      TextEditingController();
  final TextEditingController _secretaryContactController =
      TextEditingController();
  List<String> members = [];
  List<Activity> activities = [];

  @override
  void initState() {
    super.initState();
    fetchBranchData();
    fetchBranchActivities();
  }

  @override
  void dispose() {
    _branchAddressController.dispose();
    _contactDetailsController.dispose();
    _secretaryNameController.dispose();
    _secretaryContactController.dispose();
    super.dispose();
  }

  Future<void> fetchBranchData() async {
    try {
      // Fetch the branch document from Firestore
      QuerySnapshot querySnapshot = await _firestore
          .collection('Branches')
          .where('subBranch', isEqualTo: widget.subBranchId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot branchSnapshot = querySnapshot.docs.first;
        if (branchSnapshot.exists) {
          Map<String, dynamic> branchData =
              branchSnapshot.data() as Map<String, dynamic>;

          setState(() {
            // Update the branch data
            _branchAddressController.text =
                branchData['branchAddress'] ?? 'N/A';
            _contactDetailsController.text =
                branchData['contactDetails'] ?? 'N/A';
            _secretaryNameController.text =
                branchData['secretaryName'] ?? 'N/A';
            _secretaryContactController.text =
                branchData['secretaryContact'] ?? 'N/A';
            members = List<String>.from(branchData['members'] ?? []);
          });
        }
      } else {
        print(
            'Document with subBranchId ${widget.subBranchId} does not exist in Firestore.');
      }
    } catch (e) {
      print('Error fetching branch data: $e');
    }
  }

  Future<void> fetchBranchActivities() async {
    try {
      final String lowerCaseSubBranchId = widget.subBranchId.toLowerCase();

      // Fetch the activities for the branch from Firestore
      QuerySnapshot querySnapshot = await _firestore
          .collection('Activities')
          .where('subBranchId', isEqualTo: lowerCaseSubBranchId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          // Update the activities list
          activities = querySnapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return Activity(
              title: data['title'] ?? 'N/A',
              description: data['description'] ?? 'N/A',
            );
          }).toList();
        });
      } else {
        print('No activities found for branch: ${widget.subBranchId}');
      }
    } catch (e) {
      print('Error fetching branch activities: $e');
    }
  }

  void _addMember() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newMember = '';
        return AlertDialog(
          title: Text('Add Member'),
          content: TextField(
            onChanged: (value) {
              newMember = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  members.add(newMember);
                  _updateMembers(members);
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

  Future<void> _updateMembers(List<String> updatedMembers) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument.update({'members': updatedMembers}).then((_) {
        print('Members updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating members in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
  }

  Future<void> _updateSecretaryName(String newName) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument.update({'secretaryName': newName}).then((_) {
        print('Secretary Name updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating Secretary Name in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
  }

  Future<void> _updateSecretaryContact(String newContact) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument
          .update({'secretaryContact': newContact}).then((_) {
        print('Secretary Contact updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating Secretary Contact in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
  }

  Future<void> _updateBranchAddress(String newAddress) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument.update({'branchAddress': newAddress}).then((_) {
        print('Branch Address updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating Branch Address in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
  }

  Future<void> _updateContactDetails(String newDetails) async {
    final subBranchQuerySnapshot = await _firestore
        .collection('Branches')
        .where('subBranch', isEqualTo: widget.subBranchId)
        .get();

    if (subBranchQuerySnapshot.docs.isNotEmpty) {
      final subBranchDocument = subBranchQuerySnapshot.docs.first.reference;

      await subBranchDocument.update({'contactDetails': newDetails}).then((_) {
        print('Contact Details updated successfully in Firestore.');
      }).catchError((error) {
        print('Error updating Contact Details in Firestore: $error');
      });
    } else {
      print('SubBranch document does not exist.');
    }
  }

  void _showActivitiesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Activities'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (activities.isNotEmpty)
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: activities.map((activity) {
                    return ListTile(
                      title: Text(activity.title),
                      subtitle: Text(activity.description),
                    );
                  }).toList(),
                ),
              if (activities.isEmpty)
                Text('No activities found for this branch.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
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
              widget.subBranchId[0].toUpperCase() +
                  widget.subBranchId.substring(1).toLowerCase(),
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 8),
                    Text(
                      'Branch Address',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String newBranchAddress = _branchAddressController.text;
                        return AlertDialog(
                          title: Text('Edit Branch Address'),
                          content: TextField(
                            onChanged: (value) {
                              newBranchAddress = value;
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _branchAddressController.text =
                                      newBranchAddress;
                                  _updateBranchAddress(newBranchAddress);
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text('Save'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                subtitle: TextFormField(
                  controller: _branchAddressController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Row(
                  children: [
                    Icon(Icons.phone),
                    SizedBox(width: 8),
                    Text(
                      'Contact Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String newContactDetails =
                            _contactDetailsController.text;
                        return AlertDialog(
                          title: Text('Edit Contact Details'),
                          content: TextField(
                            onChanged: (value) {
                              newContactDetails = value;
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _contactDetailsController.text =
                                      newContactDetails;
                                  _updateContactDetails(newContactDetails);
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text('Save'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                subtitle: TextFormField(
                  controller: _contactDetailsController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 8),
                    Text(
                      'Secretary Name',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String newSecretaryName = _secretaryNameController.text;
                        return AlertDialog(
                          title: Text('Edit Secretary Name'),
                          content: TextField(
                            onChanged: (value) {
                              newSecretaryName = value;
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _secretaryNameController.text =
                                      newSecretaryName;
                                  _updateSecretaryName(newSecretaryName);
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text('Save'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                subtitle: TextFormField(
                  controller: _secretaryNameController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Row(
                  children: [
                    Icon(Icons.phone),
                    SizedBox(width: 8),
                    Text(
                      'Secretary Contact',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String newSecretaryContact =
                            _secretaryContactController.text;
                        return AlertDialog(
                          title: Text('Edit Secretary Contact'),
                          content: TextField(
                            onChanged: (value) {
                              newSecretaryContact = value;
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _secretaryContactController.text =
                                      newSecretaryContact;
                                  _updateSecretaryContact(newSecretaryContact);
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text('Save'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                subtitle: TextFormField(
                  controller: _secretaryContactController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Members',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: _addMember,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8),
                  Text('Add Members'),
                ],
              ),
            ),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: members.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    title: Text(members[index]),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            Text(
              'Activities',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: _showActivitiesDialog,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.event),
                  SizedBox(width: 8),
                  Text('View Activities'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
