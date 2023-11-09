import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shrimad_bhagwat_geeta/core/api/api.dart';
import 'package:shrimad_bhagwat_geeta/core/constants/conts.dart';
import 'package:shrimad_bhagwat_geeta/core/utils/snackbar/custom_snackbar.dart';

class AllVerses extends StatefulWidget {
  final int chpNo;
  final int slokNo;
  final int totalSlok;
  const AllVerses({
    super.key,
    required this.chpNo,
    required this.slokNo,
    required this.totalSlok,
  });

  @override
  State<AllVerses> createState() => _AllVersesState();
}

class _AllVersesState extends State<AllVerses> {
  Map<String, dynamic> versesData = {};

  // slokas
  String slok = '';
  String enSlok = '';

  // translation
  Map<String, dynamic> tejData = {};
  Map<String, dynamic> purohitData = {};
  Map<String, dynamic> sanData = {};
  Map<String, dynamic> adiData = {};
  Map<String, dynamic> gambirData = {};
  Map<String, dynamic> ramsData = {};
  Map<String, dynamic> ramanData = {};
  Map<String, dynamic> abhinavData = {};
  Map<String, dynamic> sankarData = {};

  // Commentary
  Map<String, dynamic> sivaData = {};
  Map<String, dynamic> chinmayData = {};
  Map<String, dynamic> madhavData = {};
  Map<String, dynamic> anandData = {};
  Map<String, dynamic> jayaData = {};
  Map<String, dynamic> vallabhData = {};
  Map<String, dynamic> msData = {};
  Map<String, dynamic> sridData = {};
  Map<String, dynamic> dhanData = {};
  Map<String, dynamic> venkatData = {};
  Map<String, dynamic> puruData = {};
  Map<String, dynamic> neelData = {};

  bool isLoading = false;

  int currentSlok = 1;
  int currentChp = 1;

  @override
  void initState() {
    super.initState();
    fetchAllSlok();
  }

  Future<void> fetchAllSlok() async {
    currentSlok = widget.slokNo;
    currentChp = widget.chpNo;

    await getSlok(currentSlok, currentChp);
  }

  fetchNextSlok() async {
    int slok;
    int chp;

    if (currentSlok > 0 && currentSlok < widget.totalSlok) {
      slok = currentSlok + 1;
      currentSlok = slok;
    } else {
      showSnackBar(context, 'No more verses in this chapter', true);
      return;
    }

    chp = currentChp;

    // if (currentChp > 0 && currentChp < 18) {
    //   chp = currentChp;
    // } else {
    //   showSnackBar(context, 'No more chapter', true);
    //   return;
    // }

    await getSlok(slok, chp);
  }

  getSlok(int sloka, int chp) async {
    setState(() {
      isLoading = true;
    });

    versesData = await Api.getSlok(
      chp,
      sloka,
    );

    // translators

    tejData = versesData['tej'];
    purohitData = versesData['purohit'];
    sanData = versesData['san'];
    adiData = versesData['adi'];
    gambirData = versesData['gambir'];
    ramsData = versesData['rams'];
    ramanData = versesData['raman'];
    abhinavData = versesData['abhinav'];
    sankarData = versesData['sankar'];

    // Commentators

    sivaData = versesData['siva'];
    chinmayData = versesData['chinmay'];
    madhavData = versesData['madhav'];
    anandData = versesData['anand'];
    jayaData = versesData['jaya'];
    vallabhData = versesData['vallabh'];
    msData = versesData['ms'];
    sridData = versesData['srid'];
    dhanData = versesData['dhan'];
    venkatData = versesData['venkat'];
    puruData = versesData['puru'];
    neelData = versesData['neel'];

    // Slokas

    slok = versesData['slok'];
    enSlok = versesData['transliteration'];

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await fetchNextSlok();
        },
        child: const Icon(
          Icons.arrow_circle_right_rounded,
        ),
      ),
      body: SafeArea(
        child: isLoading != true
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 34),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Text(
                            slok,
                            style: GoogleFonts.oswald(
                              fontSize: 28,
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            enSlok,
                            style: GoogleFonts.oswald(
                              fontSize: 28,
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Translations
                    const Divider(),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 3, bottom: 8),
                                child: Text(
                                  'Translations',
                                  style: GoogleFonts.oswald(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          const SizedBox(height: 6),
                          Text(
                            tejData['ht'],
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '~ ${tejData['author']}',
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 17,
                            ),
                          ),
                          const Divider(),
                          const SizedBox(height: 6),
                          Text(
                            ramsData['ht'],
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '~ ${ramsData['author']}',
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 17,
                            ),
                          ),
                          const Divider(),
                          const SizedBox(height: 6),
                          Text(
                            sivaData['et'],
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '~ ${sivaData['author']}',
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 17,
                            ),
                          ),
                          const Divider(),
                          const SizedBox(height: 6),
                          Text(
                            purohitData['et'],
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '~ ${purohitData['author']}',
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 17,
                            ),
                          ),
                          const Divider(),
                          const SizedBox(height: 6),
                          Text(
                            sanData['et'],
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '~ ${sanData['author']}',
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Commentators
                    const Divider(), const SizedBox(height: 50),
                    const Divider(),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text(
                                  'Commentary',
                                  style: GoogleFonts.oswald(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          const SizedBox(height: 6),
                          Text(
                            chinmayData['hc'],
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '~ ${chinmayData['author']}',
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 17,
                            ),
                          ),
                          const Divider(),
                          const SizedBox(height: 6),
                          Text(
                            ramsData['hc'],
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '~ ${ramsData['author']}',
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 17,
                            ),
                          ),
                          const Divider(),
                          const SizedBox(height: 6),
                          Text(
                            sivaData['ec'],
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '~ ${sivaData['author']}',
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 17,
                            ),
                          ),
                          const Divider(),
                          const SizedBox(height: 6),
                          Text(
                            puruData['sc'],
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '~ ${puruData['author']}',
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 17,
                            ),
                          ),
                          const Divider(),
                          const SizedBox(height: 6),
                          Text(
                            venkatData['sc'],
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '~ ${venkatData['author']}',
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 17,
                            ),
                          ),
                          const Divider(),
                          const SizedBox(height: 6),
                          Text(
                            dhanData['sc'],
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '~ ${dhanData['author']}',
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 17,
                            ),
                          ),
                          const Divider(),
                          const SizedBox(height: 6),
                          Text(
                            neelData['sc'],
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '~ ${neelData['author']}',
                            style: GoogleFonts.oswald(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 17,
                            ),
                          ),
                          const Divider(),
                          const SizedBox(height: 25),
                        ],
                      ),
                    ),
                    Text(
                      madeBy,
                      style: GoogleFonts.oswald(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      appVersion,
                      style: GoogleFonts.oswald(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              )
            : const LinearProgressIndicator(),
      ),
    );
  }
}
