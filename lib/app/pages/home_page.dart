import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shrimad_bhagwat_geeta/core/api/api.dart';
import 'package:shrimad_bhagwat_geeta/core/widgets/all_chapter_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> allChapters = [];

  @override
  void initState() {
    super.initState();
    getChapters();
  }

  getChapters() async {
    allChapters = await Api.getAllChapters();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shrimad Bhagwat Geeta',
          style: GoogleFonts.oswald(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Theme.of(context).colorScheme.secondary,
            letterSpacing: 1.4,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              allChapter(allChapters),
            ],
          ),
        ),
      ),
    );
  }
}
