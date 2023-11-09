import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shrimad_bhagwat_geeta/app/view/chapter_view.dart';

Widget allChapter(List<dynamic> chaptersData) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: chaptersData.length,
    itemBuilder: (context, index) {
      var data = chaptersData[index];
      String hiTitle = data['name'];
      String enTitle = data['translation'];
      int chpNo = data['chapter_number'];
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChapterView(chpNo: chpNo),
            ),
          );
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              '${index + 1}',
              style: GoogleFonts.oswald(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            hiTitle,
            style: GoogleFonts.oswald(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
              fontSize: 19,
            ),
          ),
          subtitle: Text(
            enTitle,
            style: GoogleFonts.oswald(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w300,
              letterSpacing: 1.1,
              fontSize: 18,
            ),
          ),
        ),
      );
    },
  );
}
