import 'dart:convert';

import 'package:cubbes_test_fe/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// login function
Future<http.Response> login(String username, String password) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      body: {"username": username, "password": password},
    );
    return response;
  } catch (e) {
    print('Error occurred during login: $e');
    rethrow;
  }
}

// register function
Future<http.Response> register(
    String firstName,
    String lastName,
    String otherName,
    String email,
    String phoneNumber,
    String password,
    String uniId,
    String facultyId,
    String deptId,
    String levelId,
    String semesterId) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      body: {
        "first_name": firstName,
        "last_name": lastName,
        "other_name": otherName,
        "email": email,
        "phone_number": phoneNumber,
        "account_type": "1",
        "password": password,
        "university_id": uniId,
        "faculty_id": facultyId,
        "department_id": deptId,
        "school_level_id": levelId,
        "level_semester_id": semesterId,
      },
    );
    return response;
  } catch (e) {
    print('Error occurred during registration: $e');
    rethrow;
  }
}

// load universities
Future<List<Map<String, dynamic>>> loadUniversities() async {
  try {
    final response = await http.get(
      Uri.parse('$baseUrl/mobile/universities'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map<Map<String, dynamic>>((item) {
        return {
          'id': item['id'],
          'name': item['name'],
        };
      }).toList();
    } else {
      // Handle error
      throw Exception('Failed to load universities');
    }
  } catch (e) {
    // Handle error
    print('Error occurred while loading universities: $e');
    rethrow;
  }
}

// load faculties
Future<List<Map<String, dynamic>>> loadFacultiesByUniversity(String id) async {
  try {
    final response = await http.get(
      Uri.parse('$baseUrl/mobile/universities/$id/faculties'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map<Map<String, dynamic>>((item) {
        return {
          'id': item['id'],
          'name': item['name'],
        };
      }).toList();
    } else {
      // Handle error
      throw Exception('Failed to load faculties');
    }
  } catch (e) {
    // Handle error
    print('Error occurred while loading faculties: $e');
    rethrow;
  }
}

// load department
Future<List<Map<String, dynamic>>> loadDepartmentsByFaculty(String id) async {
  try {
    final response = await http.get(
      Uri.parse('$baseUrl/mobile/faculties/$id/departments'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map<Map<String, dynamic>>((item) {
        return {
          'id': item['id'],
          'name': item['name'],
        };
      }).toList();
    } else {
      // Handle error
      throw Exception('Failed to load faculties');
    }
  } catch (e) {
    // Handle error
    print('Error occurred while loading faculties: $e');
    rethrow;
  }
}

// load levels
Future<List<Map<String, dynamic>>> loadLevels() async {
  try {
    final response = await http.get(
      Uri.parse('$baseUrl/mobile/levels'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map<Map<String, dynamic>>((item) {
        return {
          'id': item['id'],
          'name': item['level'] + " Level",
        };
      }).toList();
    } else {
      // Handle error
      throw Exception('Failed to load universities');
    }
  } catch (e) {
    // Handle error
    print('Error occurred while loading universities: $e');
    rethrow;
  }
}

// load semesters
Future<List<Map<String, dynamic>>> loadSemesters() async {
  try {
    final response = await http.get(
      Uri.parse('$baseUrl/mobile/sememsters'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map<Map<String, dynamic>>((item) {
        return {
          'id': item['id'],
          'name': item['semester'] + " Semester",
        };
      }).toList();
    } else {
      // Handle error
      throw Exception('Failed to load Semesters');
    }
  } catch (e) {
    // Handle error
    print('Error occurred while loading Semesters: $e');
    rethrow;
  }
}

// load my courses
Future<List<Map<String, dynamic>>> loadMyCourses() async {
  try {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('userToken');

    if (token == null) {
      throw Exception('User token is null');
    }

    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    final response = await http.get(Uri.parse('$baseUrl/courses/my-courses'),
        headers: headers);

    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);
      if (responseData.containsKey('courses')) {
        final List<dynamic> data = responseData['courses'];
        return data.map<Map<String, dynamic>>((item) {
          return {
            'name': item['course_title'],
            'code': item['course_code'],
          };
        }).toList();
      } else {
        throw Exception('Response does not contain "data" key');
      }
    } else {
      // Handle error
      throw Exception('Failed to load courses: ${response.statusCode}');
    }
  } catch (e) {
    // Handle error
    print('Inner Error occurred while loading courses: $e');
    rethrow;
  }
}

// Future<List<Map<String, dynamic>>> loadMyCourses() async {
//   try {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     final token = pref.getString('userToken');

//     final Map<String, String> headers = {
//       'Authorization': 'Bearer $token',
//       'Accept': 'application/json',
//       // Add more headers as needed
//     };

//     final response = await http.get(Uri.parse('$baseUrl/courses/my-courses'),
//         headers: headers);

//     if (response.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(response.body)['data'];
//       return data.map<Map<String, dynamic>>((item) {
//         return {
//           'name': item['course_title'],
//           'code': item['course_code'],
//         };
//       }).toList();
//     } else {
//       // Handle error
//       throw Exception('Failed to load courses');
//     }
//   } catch (e) {
//     // Handle error
//     print('Inner Error occurred while loading courses: $e');
//     rethrow;
//   }
// }
