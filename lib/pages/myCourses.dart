import 'package:cubbes_test_fe/components/titleText.dart';
import 'package:cubbes_test_fe/utils/apiCalls.dart';
import 'package:cubbes_test_fe/utils/utils.dart';
import 'package:flutter/material.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({Key? key}) : super(key: key);

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  // List<String> courses = [
  //   'Course 1',
  //   'Course 2',
  //   'Course 3',
  //   // Add more courses as needed
  // ];

  @override
  void initState() {
    super.initState();
    loadCourse();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // university Section
  bool isLoadingCourses = false;
  List<Map<String, dynamic>> courses = [];

  Future<void> loadCourse() async {
    setState(() {
      isLoadingCourses = true;
    });

    // final loadedCourses = await loadMyCourses();
    try {
      final loadedCourses = await loadMyCourses();
      if (loadedCourses == null || loadedCourses.isEmpty) {
        showMessage(context, "No courses available for you");
        return;
      }

      setState(() {
        courses = loadedCourses.map((course) {
          return {
            'courses': course['name'],
            'code': course['code'],
          };
        }).toList();
      });
    } catch (e) {
      // Handle error
      Navigator.of(context).pop();
      showMessage(context, 'Error loading courses data: $e');
      print('Error loading courses data: $e');
    } finally {
      setState(() {
        isLoadingCourses = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: const Text('My Courses'),
        ),
        body: isLoadingCourses
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        title: Text(
                          course['courses'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        subtitle: Text(
                          course['code'],
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        onTap: () {
                          // Handle tile tap
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
