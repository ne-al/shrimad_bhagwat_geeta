import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shrimad_bhagwat_geeta/core/api/api.dart';
import 'package:shrimad_bhagwat_geeta/core/widgets/all_verses.dart';

class ChapterView extends StatefulWidget {
  final int chpNo;
  const ChapterView({
    super.key,
    required this.chpNo,
  });

  @override
  State<ChapterView> createState() => _ChapterViewState();
}

class _ChapterViewState extends State<ChapterView> {
  Map<String, dynamic> chpData = {};
  Map<String, dynamic> meaning = {};
  Map<String, dynamic> summary = {};
  String hiTitle = '';
  String enTitle = '';
  String hiMeaning = '';
  String enMeaning = '';
  String hiSummary = '';
  String enSummary = '';
  int versesCount = 1;
  int chapterNumber = 1;
  bool? isEnglish;

  late SharedPreferences prefs;

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getChpInfo();
  }

  Future getChpInfo() async {
    isLoading = true;
    prefs = await SharedPreferences.getInstance();
    isEnglish = prefs.getBool('isEnglish');

    chpData = await Api.getChapter(widget.chpNo);
    meaning = chpData['meaning'];
    summary = chpData['summary'];

    hiTitle = chpData['name'];
    enTitle = chpData['translation'];
    versesCount = chpData['verses_count'];
    chapterNumber = chpData['chapter_number'];

    hiMeaning = meaning['hi'];
    enMeaning = meaning['en'];

    hiSummary = summary['hi'];
    enSummary = summary['en'];

    if (isEnglish == null) {
      isEnglish = false;
    } else if (isEnglish != null) {
      prefs = await SharedPreferences.getInstance();
      isEnglish = prefs.getBool('isEnglish');
    }

    setState(() {});
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading != true
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 32,
                        bottom: 8,
                      ),
                      child: Text(
                        hiTitle,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.oswald(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      enTitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.oswald(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 4,
                            left: 12,
                            right: 12,
                            bottom: 4,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Meaning',
                                style: GoogleFonts.oswald(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Chapter: $chapterNumber',
                                    style: GoogleFonts.oswald(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                  Text(
                                    'Verses: $versesCount',
                                    style: GoogleFonts.oswald(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        const SizedBox(height: 16),
                        Text(
                          hiMeaning,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.oswald(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          enMeaning,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.oswald(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Summary',
                                style: GoogleFonts.oswald(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Show in english',
                                    style: GoogleFonts.oswald(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Switch(
                                    value: isEnglish!,
                                    onChanged: (bool value) async {
                                      final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setBool('isEnglish', value);
                                      isEnglish = value;

                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 12,
                                top: 12,
                                bottom: 6,
                              ),
                              child: Text(
                                'Hindi',
                                style: GoogleFonts.oswald(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            hiSummary,
                            style: GoogleFonts.oswald(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Visibility(
                          visible: isEnglish ?? false,
                          child: Column(
                            children: [
                              const Divider(),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 12,
                                      top: 6,
                                      bottom: 6,
                                    ),
                                    child: Text(
                                      'English',
                                      style: GoogleFonts.oswald(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              const SizedBox(height: 12),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  enSummary,
                                  style: GoogleFonts.oswald(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Divider(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Text(
                                'Verses: ',
                                style: GoogleFonts.oswald(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 26,
                                ),
                              ),
                              ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: versesCount,
                                itemBuilder: (context, index) {
                                  return TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AllVerses(
                                            chpNo: chapterNumber,
                                            slokNo: index + 1,
                                            totalSlok: versesCount,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      '${index + 1}',
                                      style: GoogleFonts.oswald(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              )
            : Container(),
      ),
    );
  }
}
