/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'SubBranchDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SubBranchDetailPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _branchesCollection =
      FirebaseFirestore.instance.collection('Branches');

  String? selectedDistrict;
  String? selectedSubBranch;
  List<String> districts = [];
  List<String> subBranches = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final querySnapshot = await _branchesCollection.get();
      final docs = querySnapshot.docs;

      setState(() {
        districts =
            docs.map((doc) => doc['district'] as String).toSet().toList();
      });

      if (selectedDistrict != null) {
        final subBranchQuerySnapshot = await _branchesCollection
            .where('district', isEqualTo: selectedDistrict)
            .get();

        setState(() {
          subBranches = subBranchQuerySnapshot.docs
              .map((doc) => doc['subBranch'] as String)
              .toList();
        });
      }
    } catch (e) {
      print('Failed to load data: $e');
    }
  }

  Future<List<String>> _getSubBranchesInSelectedDistrict() async {
    final querySnapshot = await _branchesCollection
        .where('district', isEqualTo: selectedDistrict)
        .get();

    return querySnapshot.docs.map((doc) => doc['subBranch'] as String).toList();
  }

  void _goToSubBranchDetailPage(String subBranchId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NextPage(subBranchId: subBranchId),
      ),
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
              'Homepage',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'District',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        DropdownButton<String>(
                          value: selectedDistrict,
                          items: districts.map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDistrict = newValue;
                              selectedSubBranch = null;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sub-branch',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        FutureBuilder<List<String>>(
                          future: _getSubBranchesInSelectedDistrict(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<String>> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final subBranchesInDistrict = snapshot.data ?? [];

                              return DropdownButton<String>(
                                value: selectedSubBranch,
                                items: subBranchesInDistrict.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedSubBranch = newValue;
                                  });
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (selectedSubBranch != null) {
                  _goToSubBranchDetailPage(selectedSubBranch!);
                }
              },
              child: Text('Next'),
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
import 'package:shared_preferences/shared_preferences.dart';
import 'SubBranchDetailPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _branchesCollection =
      FirebaseFirestore.instance.collection('Branches');

  String? selectedDistrict;
  String? selectedSubBranch;
  List<String> districts = [];
  List<String> subBranches = [];

  FirebaseAuth _auth = FirebaseAuth.instance;
  SharedPreferences? prefs;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    _loadData();
    _initializeCurrentUser();
  }

  Future<void> _loadData() async {
    try {
      final querySnapshot = await _branchesCollection.get();
      final docs = querySnapshot.docs;

      setState(() {
        districts =
            docs.map((doc) => doc['district'] as String).toSet().toList();
      });

      if (selectedDistrict != null) {
        final subBranchQuerySnapshot = await _branchesCollection
            .where('district', isEqualTo: selectedDistrict)
            .get();

        setState(() {
          subBranches = subBranchQuerySnapshot.docs
              .map((doc) => doc['subBranch'] as String)
              .toList();
        });
      }
    } catch (e) {
      print('Failed to load data: $e');
    }
  }

  Future<List<String>> _getSubBranchesInSelectedDistrict() async {
    final querySnapshot = await _branchesCollection
        .where('district', isEqualTo: selectedDistrict)
        .get();

    return querySnapshot.docs.map((doc) => doc['subBranch'] as String).toList();
  }

  void _goToSubBranchDetailPage(String subBranchId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NextPage(subBranchId: subBranchId),
      ),
    );
  }

  void _initializeCurrentUser() async {
    prefs = await SharedPreferences.getInstance();
    String? userId = prefs!.getString('userId');
    if (userId != null) {
      setState(() {
        currentUser = _auth.currentUser;
      });
    }
  }

  Future<void> _logoutUser() async {
    await _auth.signOut();
    await prefs!.remove('userId');
    setState(() {
      currentUser = null;
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
              'Homepage',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          if (currentUser != null)
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: _logoutUser,
            ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'District',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        DropdownButton<String>(
                          value: selectedDistrict,
                          items: districts.map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDistrict = newValue;
                              selectedSubBranch = null;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sub-branch',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        FutureBuilder<List<String>>(
                          future: _getSubBranchesInSelectedDistrict(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<String>> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final subBranchesInDistrict = snapshot.data ?? [];

                              return DropdownButton<String>(
                                value: selectedSubBranch,
                                items: subBranchesInDistrict.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedSubBranch = newValue;
                                  });
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (selectedSubBranch != null) {
                  _goToSubBranchDetailPage(selectedSubBranch!);
                }
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
