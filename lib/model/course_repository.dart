import 'dart:convert';

import 'package:meuapp/core/constants.dart';
import 'package:meuapp/model/course_model.dart';
import 'package:http/http.dart' as http;

class CourseRepository {
  final Uri url = Uri.parse("$urlBaseApi/courses");

  Future<List<CourseEntity>> getAll() async {
    List<CourseEntity> courseList = [];

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      for (var course in json) {
        courseList.add(CourseEntity.fromJson(course));
      }
    }
    return courseList;
  }

  postNewCourse(CourseEntity courseEntity) async {
    final json = jsonEncode(CourseEntity.toJson(courseEntity));
    var response = await http.post(url, body: json);
    if (response.statusCode != 201) {
      throw "Problemas ao inserir seus dados";
    }
  }

  deleteCourse(String id) async {
    final url = '$urlBaseApi/courses/$id';
    var response = await http.delete(Uri.parse(url));
    if (response.statusCode != 200) {
      throw 'Problemas ao excluir seus dados';
    }
  }

  putUpdateCourse(CourseEntity courseEntity) async {
    final url = '$urlBaseApi/courses/${courseEntity.id}';
    final json = jsonEncode(CourseEntity.toJson(courseEntity));
    var response = await http.put(Uri.parse(url), body: json);
    if (response.statusCode != 200) {
      throw 'Problemas ao atualizar seus dados';
    }
  }
}
