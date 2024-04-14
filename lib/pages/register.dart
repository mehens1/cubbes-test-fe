import 'dart:convert';

import 'package:cubbes_test_fe/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:cubbes_test_fe/components/dropDownInput.dart';
import 'package:cubbes_test_fe/components/pageLogo.dart';
import 'package:cubbes_test_fe/components/passwordInput.dart';
import 'package:cubbes_test_fe/components/smallButton.dart';
import 'package:cubbes_test_fe/components/textInput.dart';
import 'package:cubbes_test_fe/components/titleText.dart';
import 'package:cubbes_test_fe/pages/login.dart';
import 'package:cubbes_test_fe/utils/apiCalls.dart';
import 'package:cubbes_test_fe/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _otherNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    loadUniversityData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _registerUser() async {
    if (_firstNameController.text.isEmpty) {
      showMessage(context, "First Name is required!");
      return;
    }

    if (_lastNameController.text.isEmpty) {
      showMessage(context, "Last Name is required!");
      return;
    }
    if (_emailController.text.isEmpty) {
      showMessage(context, "Email Address is required!");
      return;
    }
    if (_phoneNumberController.text.isEmpty) {
      showMessage(context, "Phone Number is required!");
      return;
    }
    if (_passwordController.text.isEmpty ||
        _passwordController.text.length < 6) {
      showMessage(
          context, "Password is required and must be at least 6 characters!");
      return;
    }
    if (_confirmPasswordController.text.isEmpty) {
      showMessage(context, "Confirm Password is required!");
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      showMessage(context, "Password not match!");
      return;
    }

    // Check if university is selected
    if (selectedUniversity?['value']?.toString() == null) {
      showMessage(context, "Please Select University!");
      return;
    }
    if (selectedFaculty?['value']?.toString() == null) {
      showMessage(context, "Please Select Faculty!");
      return;
    }
    if (selectedDepartment?['value']?.toString() == null) {
      showMessage(context, "Please Select Department!");
      return;
    }

    if (selectedLevel?['value']?.toString() == null) {
      showMessage(context, "Please Select Level!");
      return;
    }

    if (selectedSemester?['value']?.toString() == null) {
      showMessage(context, "Please Select Semester!");
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    var uniId = selectedUniversity?['value'].toString();
    var facultyId = selectedFaculty?['value'].toString();
    var deptId = selectedDepartment?['value']?.toString();
    var levelId = selectedLevel?['value']?.toString();
    var semesterId = selectedSemester?['value']?.toString();

    // return;

    try {
      final response = await register(
          _firstNameController.text.toString(),
          _lastNameController.text.toString(),
          _otherNameController.text.toString(),
          _emailController.text.toString(),
          _phoneNumberController.text.toString(),
          _passwordController.text.toString(),
          uniId.toString(),
          facultyId.toString(),
          deptId.toString(),
          levelId.toString(),
          semesterId.toString());

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('userToken', res['token']);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else {
        // Failed login, show error message
        var res = jsonDecode(response.body);
        String message =
            res['message']; // Access the 'message' key from the decoded map
        showMessage(context, message);
      }
    } catch (e) {
      // Error occurred during login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
    }

    setState(() {
      _isProcessing = false;
    });
  }

  // university Section
  bool isLoadingUniversities = false;
  List<Map<String, dynamic>> universities = [];
  Map<String, dynamic>? selectedUniversity;

  Future<void> loadUniversityData() async {
    setState(() {
      isLoadingUniversities = true;
    });

    try {
      final loadedUniversities = await loadUniversities();
      setState(() {
        universities = loadedUniversities.map((university) {
          return {
            'label': university['name'],
            'value': university['id'],
          };
        }).toList();

        // Set selectedUniversity to the first item in the list if it's not empty
        selectedUniversity = universities.isNotEmpty ? null : universities[0];
      });
    } catch (e) {
      // Handle error
      print('Error loading university data: $e');
      showMessage(context, 'Error loading university data: $e');
    }

    setState(() {
      isLoadingUniversities = false;
    });
  }

  // faculty section
  bool isLoadingFaculties = false;
  List<Map<String, dynamic>> faculties = [];
  Map<String, dynamic>? selectedFaculty;

  Future<void> loadFaculties(String universityId) async {
    setState(() {
      isLoadingFaculties = true;
    });

    try {
      final loadedFaculties = await loadFacultiesByUniversity(universityId);

      if (loadedFaculties.isEmpty) {
        showMessage(context, 'This University has no Faculties!');
        return;
      }

      setState(() {
        faculties = loadedFaculties.map((faculty) {
          return {
            'label': faculty['name'],
            'value': faculty['id'],
          };
        }).toList();

        // Set selectedFaculty to null or the first item in the list if not empty
        selectedFaculty = faculties.isNotEmpty ? null : faculties[0];
      });
    } catch (e) {
      // Handle error
      print('Error loading faculty data: $e');
      showMessage(context, 'Error loading faculty data: $e');
    }

    setState(() {
      isLoadingFaculties = false;
    });
  }

  // section to load departments
  List<Map<String, dynamic>> departments = [];
  Map<String, dynamic>? selectedDepartment;
  bool isLoadingDepartments = false;

  Future<void> loadDepartments(String facultyId) async {
    setState(() {
      isLoadingDepartments = true;
    });

    try {
      final loadedDepartments = await loadDepartmentsByFaculty(facultyId);
      if (loadedDepartments.isEmpty) {
        showMessage(context, 'This Faculties has no Departments!');
        setState(() {
          isLoadingDepartments = false;
        });
        return;
      }

      setState(() {
        departments = loadedDepartments.map((department) {
          return {
            'label': department['name'],
            'value': department['id'],
          };
        }).toList();

        // Set selectedDepartment to null or the first item in the list if not empty
        selectedDepartment = departments.isNotEmpty ? null : departments[0];
      });
    } catch (e) {
      // Handle error
      print('Error loading department data: $e');
      showMessage(context, 'Error loading department data: $e');
    }

    setState(() {
      isLoadingDepartments = false;
    });
  }

  // level Section
  bool isLoadingLevels = false;
  List<Map<String, dynamic>> levels = [];
  Map<String, dynamic>? selectedLevel;

  Future<void> loadLevel() async {
    setState(() {
      isLoadingLevels = true;
    });

    try {
      final loadedLevels = await loadLevels();

      setState(() {
        levels = loadedLevels.map((level) {
          return {
            'label': level['name'],
            'value': level['id'],
          };
        }).toList();

        // Set selectedUniversity to the first item in the list if it's not empty
        selectedLevel = levels.isNotEmpty ? null : levels[0];
      });
    } catch (e) {
      // Handle error
      print('Error loading university data: $e');
      showMessage(context, 'Error loading university data: $e');
    }

    setState(() {
      isLoadingLevels = false;
    });
  }

  // semester Section
  bool isLoadingSemester = false;
  List<Map<String, dynamic>> semesters = [];
  Map<String, dynamic>? selectedSemester;

  Future<void> loadSemester() async {
    setState(() {
      isLoadingSemester = true;
    });

    try {
      final loadedSemesters = await loadSemesters();

      setState(() {
        semesters = loadedSemesters.map((semester) {
          return {
            'label': semester['name'],
            'value': semester['id'],
          };
        }).toList();

        // Set selectedUniversity to the first item in the list if it's not empty
        selectedSemester = semesters.isNotEmpty ? null : semesters[0];
      });
    } catch (e) {
      // Handle error
      print('Error loading semesters data: $e');
      showMessage(context, 'Error loading semesters data: $e');
    }

    setState(() {
      isLoadingSemester = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderLogo(),
                const TitleText(text: 'Register'),
                TextInput(
                  controller: _firstNameController,
                  labelText: 'First Name',
                  icon: Icons.account_circle,
                ),
                TextInput(
                  controller: _lastNameController,
                  labelText: 'Last Name',
                  icon: Icons.account_circle,
                ),
                TextInput(
                  controller: _otherNameController,
                  labelText: 'Other Name (Optional)',
                  icon: Icons.account_circle,
                ),
                TextInput(
                  controller: _emailController,
                  labelText: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.email,
                ),
                TextInput(
                  controller: _phoneNumberController,
                  labelText: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  icon: Icons.phone,
                ),
                PasswordInput(
                  controller: _passwordController,
                  labelText: 'Password',
                  icon: Icons.lock,
                ),
                PasswordInput(
                  controller: _confirmPasswordController,
                  labelText: 'Confirm Password',
                  icon: Icons.lock,
                ),
                isLoadingUniversities
                    ? const CircularProgressIndicator()
                    : DropDownInput(
                        items: universities,
                        value: selectedUniversity,
                        hint: 'Select University',
                        onChanged: (value) {
                          setState(() {
                            selectedUniversity = value;
                          });
                          if (value != null) {
                            loadFaculties(value['value'].toString());
                          }
                        },
                      ),
                isLoadingFaculties
                    ? const CircularProgressIndicator()
                    : faculties.isEmpty
                        ? Container()
                        : DropDownInput(
                            items: faculties,
                            value: selectedFaculty,
                            hint: 'Select Faculty',
                            onChanged: (value) {
                              setState(() {
                                selectedFaculty = value;
                              });
                              if (value != null) {
                                loadDepartments(value['value'].toString());
                              }
                            },
                          ),
                isLoadingDepartments
                    ? const CircularProgressIndicator()
                    : departments.isEmpty
                        ? Container()
                        : DropDownInput(
                            items: departments,
                            value: selectedDepartment,
                            hint: 'Select Department',
                            onChanged: (value) {
                              setState(() {
                                selectedDepartment = value;
                              });
                              loadLevel();
                            },
                          ),
                isLoadingLevels
                    ? const CircularProgressIndicator()
                    : levels.isEmpty
                        ? Container()
                        : DropDownInput(
                            items: levels,
                            value: selectedLevel,
                            hint: 'Select Level',
                            onChanged: (value) {
                              setState(() {
                                selectedLevel = value;
                              });
                              loadSemester();
                            },
                          ),
                isLoadingSemester
                    ? const CircularProgressIndicator()
                    : semesters.isEmpty
                        ? Container()
                        : DropDownInput(
                            items: semesters,
                            value: selectedSemester,
                            hint: 'Select Semester',
                            onChanged: (value) {
                              setState(() {
                                selectedSemester = value;
                              });
                            },
                          ),
                _isProcessing
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 50),
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      )
                    : SmallButton(
                        onPressed: () {
                          _registerUser();
                        },
                        text: "Sign Up",
                      ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already a Member?',
                      style: TextStyle(fontSize: 18),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
