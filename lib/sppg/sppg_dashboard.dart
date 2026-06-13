import 'package:flutter/material.dart';
import 'pages/school_menu_page.dart';
// import halaman lainnya

// Di dalam method navigasi:
void _navigateToSchoolMenu(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => const SchoolMenuPage()));
}