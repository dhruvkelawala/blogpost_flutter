import 'package:dio/dio.dart';
import './models/blogpost.dart';
import 'dart:convert';

final Dio dio = Dio();

Future<List> getBlogs() async {
  final resp = (await dio.get('https://webstackles.com/api/blog/info/'));

  return resp.data.map((data) => Blogpost.fromJson(data)).toList();
}
