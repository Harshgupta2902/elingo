import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/dashboard_module/quiz/model/get_audios_model.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

import '../../componants/custom_cards.dart';

class IrregularVerbsScreen extends StatefulWidget {
  const IrregularVerbsScreen({Key? key}) : super(key: key);

  @override
  IrregularVerbsScreenState createState() => IrregularVerbsScreenState();
}

class IrregularVerbsScreenState extends State<IrregularVerbsScreen> {
  final player = AudioPlayer();
  final flutterTts = FlutterTts();

  final modelData = GetAudiosModel.fromJson(jsonData);

  @override
  void initState() {
    super.initState();
  }

  Future _speak(String word) async {
    await flutterTts.speak(word);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.zircon,
      appBar: CustomAppBar(
        title: "Listening Practice",
        isProfileView: false,
        bgColor: AppColors.zircon,
        actionOnTap: () {
          return;
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              "Tap any word to Listen to pronunciation audio",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.black,
                  ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: modelData.verbs?.length ?? 0,
              itemBuilder: (context, index) {
                final verb = modelData.verbs?[index];

                return ReadingWordsContainer(
                  index: index + 1,
                  baseForm: verb?.baseForm ?? "",
                  pastParticiple: verb?.pastParticiple ?? "",
                  pastSimple: verb?.pastSimple ?? "",
                  verbTap: () {
                    _speak(verb?.baseForm ?? "");
                  },
                  pastParticipleTap: () {
                    _speak(verb?.pastParticiple ?? "");
                  },
                  pastSimpleTap: () {
                    _speak(verb?.pastSimple ?? "");
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _playAudio(String audioUrl) async {
    player.play(UrlSource(audioUrl));
    debugPrint('Playing audio from $audioUrl');
  }
}

const jsonData = {
  "verbs": [
    {
      "baseForm": "arise",
      "pastSimple": "arose",
      "pastParticiple": "arisen",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/arise-f72fb5c4.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/arose-12e89b77.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/arisen-ec98605e.mp3"
      }
    },
    {
      "baseForm": "be",
      "pastSimple": "was/were",
      "pastParticiple": "been",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/be-af9634ab.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/was-were-9e4a2122.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/been-c2381e64.mp3"
      }
    },
    {
      "baseForm": "bear",
      "pastSimple": "bore",
      "pastParticiple": "born",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/bear-bb8123a7.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/bore-314a9902.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/born-b8cc9e2a.mp3"
      }
    },
    {
      "baseForm": "beat",
      "pastSimple": "beat",
      "pastParticiple": "beaten",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/beat-cb7dfbb3.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/beat-cb7dfbb3.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/beaten-6df15a86.mp3"
      }
    },
    {
      "baseForm": "become",
      "pastSimple": "became",
      "pastParticiple": "become",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/become-0d6d119a.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/became-6c475e1f.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/become-0d6d119a.mp3"
      }
    },
    {
      "baseForm": "begin",
      "pastSimple": "began",
      "pastParticiple": "begun",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/begin-86e77b31.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/began-421c7ae5.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/begun-11b58109.mp3"
      }
    },
    {
      "baseForm": "bend",
      "pastSimple": "bent",
      "pastParticiple": "bent",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/bend-8ee2fb60.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/bent-f3ed7a9d.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/bent-f3ed7a9d.mp3"
      }
    },
    {
      "baseForm": "bet",
      "pastSimple": "bet",
      "pastParticiple": "bet",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/bet-b5e766db.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/bet-b5e766db.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/bet-b5e766db.mp3"
      }
    },
    {
      "baseForm": "bid (at a public sale)",
      "pastSimple": "bid",
      "pastParticiple": "bid",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/bid-02260f15.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/bid-02260f15.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/bid-02260f15.mp3"
      }
    },
    {
      "baseForm": "bid (ask)",
      "pastSimple": "bade/bid",
      "pastParticiple": "bidden/bid",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/bid-02260f15.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/bade-bid-c386282a.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/bidden-bid-20671d1f.mp3"
      }
    },
    {
      "baseForm": "bind",
      "pastSimple": "bound",
      "pastParticiple": "bound",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/bind-7f6d6501.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/bound-8c6f199e.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/bound-8c6f199e.mp3"
      }
    },
    {
      "baseForm": "bite",
      "pastSimple": "bit",
      "pastParticiple": "bitten",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/bite-573ef745.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/bit-26923834.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/bitten-bd0fbf82.mp3"
      }
    },
    {
      "baseForm": "bleed",
      "pastSimple": "bled",
      "pastParticiple": "bled",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/bleed-d8d2c5f5.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/bled-9ca45377.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/bled-9ca45377.mp3"
      }
    },
    {
      "baseForm": "blow",
      "pastSimple": "blew",
      "pastParticiple": "blown",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/blow-dafd88fc.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/blew-0afd9954.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/blown-7a02b2fe.mp3"
      }
    },
    {
      "baseForm": "break",
      "pastSimple": "broke",
      "pastParticiple": "broken",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/break-2e9c4e0f.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/broke-0ea73b97.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/broken-3fcaf482.mp3"
      }
    },
    {
      "baseForm": "breed",
      "pastSimple": "bred",
      "pastParticiple": "bred",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/breed-93e4481c.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/bred-a160c12d.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/bred-a160c12d.mp3"
      }
    },
    {
      "baseForm": "bring",
      "pastSimple": "brought",
      "pastParticiple": "brought",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/bring-0786a64e.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/brought-8814a51c.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/brought-8814a51c.mp3"
      }
    },
    {
      "baseForm": "broadcast",
      "pastSimple": "broadcast",
      "pastParticiple": "broadcast",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/broadcast-9e08f6ad.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/broadcast-9e08f6ad.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/broadcast-9e08f6ad.mp3"
      }
    },
    {
      "baseForm": "build",
      "pastSimple": "built",
      "pastParticiple": "built",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/build-8e65e138.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/built-b11cec00.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/built-b11cec00.mp3"
      }
    },
    {
      "baseForm": "burn",
      "pastSimple": "burnt/burned",
      "pastParticiple": "burnt/burned",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/burn-902c6c24.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/burnt-burned-197f74f1.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/burnt-burned-197f74f1.mp3"
      }
    },
    {
      "baseForm": "burst",
      "pastSimple": "burst",
      "pastParticiple": "burst",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/burst-2f3f8979.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/burst-2f3f8979.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/burst-2f3f8979.mp3"
      }
    },
    {
      "baseForm": "buy",
      "pastSimple": "bought",
      "pastParticiple": "bought",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/buy-42ea2b97.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/bought-ff4c45b1.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/bought-ff4c45b1.mp3"
      }
    },
    {
      "baseForm": "cast",
      "pastSimple": "cast",
      "pastParticiple": "cast",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/cast-acd837b2.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/cast-acd837b2.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/cast-acd837b2.mp3"
      }
    },
    {
      "baseForm": "catch",
      "pastSimple": "caught",
      "pastParticiple": "caught",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/catch-c3c61fac.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/caught-a9481cd2.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/caught-a9481cd2.mp3"
      }
    },
    {
      "baseForm": "choose",
      "pastSimple": "chose",
      "pastParticiple": "chosen",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/choose-d90ef9ff.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/chose-67b32324.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/chosen-bbd94e86.mp3"
      }
    },
    {
      "baseForm": "cling",
      "pastSimple": "clung",
      "pastParticiple": "clung",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/cling-b1ef8075.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/clung-28f971a6.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/clung-28f971a6.mp3"
      }
    },
    {
      "baseForm": "come",
      "pastSimple": "came",
      "pastParticiple": "come",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/come-279e8474.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/came-d91f8767.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/come-279e8474.mp3"
      }
    },
    {
      "baseForm": "cost",
      "pastSimple": "cost",
      "pastParticiple": "cost",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/cost-5d5c6a24.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/cost-5d5c6a24.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/cost-5d5c6a24.mp3"
      }
    },
    {
      "baseForm": "creep",
      "pastSimple": "crept",
      "pastParticiple": "crept",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/creep-1bcc8f73.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/crept-228c98af.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/crept-228c98af.mp3"
      }
    },
    {
      "baseForm": "cut",
      "pastSimple": "cut",
      "pastParticiple": "cut",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/cut-d0912378.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/cut-d0912378.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/cut-d0912378.mp3"
      }
    },
    {
      "baseForm": "deal",
      "pastSimple": "dealt",
      "pastParticiple": "dealt",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/deal-b987523b.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/dealt-f0e56417.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/dealt-f0e56417.mp3"
      }
    },
    {
      "baseForm": "dig",
      "pastSimple": "dug",
      "pastParticiple": "dug",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/dig-18f45d83.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/dug-d91b7f69.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/dug-d91b7f69.mp3"
      }
    },
    {
      "baseForm": "do",
      "pastSimple": "did",
      "pastParticiple": "done",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/do-d3a01d69.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/did-f2d926b7.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/done-33902267.mp3"
      }
    },
    {
      "baseForm": "draw",
      "pastSimple": "drew",
      "pastParticiple": "drawn",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/draw-0012b2a4.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/drew-c42a05c1.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/drawn-4991c78e.mp3"
      }
    },
    {
      "baseForm": "dream",
      "pastSimple": "dreamt/dreamed",
      "pastParticiple": "dreamt/dreamed",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/dream-7ac782c8.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/dreamt-dreamed-96da69a0.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/dreamt-dreamed-96da69a0.mp3"
      }
    },
    {
      "baseForm": "drink",
      "pastSimple": "drank",
      "pastParticiple": "drunk",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/drink-869ec016.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/drank-02c06320.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/drunk-32738931.mp3"
      }
    },
    {
      "baseForm": "drive",
      "pastSimple": "drove",
      "pastParticiple": "driven",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/drive-e78068fb.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/drove-9540250e.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/driven-c2e64631.mp3"
      }
    },
    {
      "baseForm": "dwell",
      "pastSimple": "dwelt/dwelled",
      "pastParticiple": "dwelt/dwelled",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/dwell-d7ef0dbb.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/dwelt-dwelled-e18346b6.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/dwelt-dwelled-e18346b6.mp3"
      }
    },
    {
      "baseForm": "eat",
      "pastSimple": "ate",
      "pastParticiple": "eaten",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/eat-a4521eed.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/ate-7891fb72.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/eaten-1de415fb.mp3"
      }
    },
    {
      "baseForm": "fall",
      "pastSimple": "fell",
      "pastParticiple": "fallen",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/fall-dc5b568c.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/fell-aff22ac8.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/fallen-c307f4fb.mp3"
      }
    },
    {
      "baseForm": "feed",
      "pastSimple": "fed",
      "pastParticiple": "fed",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/feed-cc5c3fb8.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/fed-fed24962.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/fed-fed24962.mp3"
      }
    },
    {
      "baseForm": "feel",
      "pastSimple": "felt",
      "pastParticiple": "felt",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/feel-7f2426ae.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/felt-9818858a.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/felt-9818858a.mp3"
      }
    },
    {
      "baseForm": "fight",
      "pastSimple": "fought",
      "pastParticiple": "fought",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/fight-adac2cd8.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/fought-7f9147b4.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/fought-7f9147b4.mp3"
      }
    },
    {
      "baseForm": "find",
      "pastSimple": "found",
      "pastParticiple": "found",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/find-5b12bc09.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/found-964c54e2.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/found-964c54e2.mp3"
      }
    },
    {
      "baseForm": "fit",
      "pastSimple": "fit/fitted",
      "pastParticiple": "fit/fitted",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/fit-222132d8.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/fitfitted-6d9e6e53.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/fitfitted-6d9e6e53.mp3"
      }
    },
    {
      "baseForm": "flee",
      "pastSimple": "fled",
      "pastParticiple": "fled",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/flee-5929e92d.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/fled-47425bb1.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/fled-47425bb1.mp3"
      }
    },
    {
      "baseForm": "fly",
      "pastSimple": "flew",
      "pastParticiple": "flown",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/fly-22c1a33f.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/flew-e9e50b2d.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/flown-11abef0e.mp3"
      }
    },
    {
      "baseForm": "forbid",
      "pastSimple": "forbade",
      "pastParticiple": "forbidden",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/forbid-62530577.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/forbade-42f623de.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/forbidden-a944b49c.mp3"
      }
    },
    {
      "baseForm": "forget",
      "pastSimple": "forgot",
      "pastParticiple": "forgotten",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/forget-1a6dddbf.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/forgot-d003bd24.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/forgotten-1113fbe2.mp3"
      }
    },
    {
      "baseForm": "forgive",
      "pastSimple": "forgave",
      "pastParticiple": "forgiven",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/forgive-b898ff61.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/forgave-163063da.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/forgiven-39e38d40.mp3"
      }
    },
    {
      "baseForm": "foresee",
      "pastSimple": "foresaw",
      "pastParticiple": "foreseen",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/foresee-63b735fc.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/foresaw-7fd68496.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/foreseen-3c0d14a3.mp3"
      }
    },
    {
      "baseForm": "forsake",
      "pastSimple": "forsook",
      "pastParticiple": "forsaken",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/forsake-38d0afb5.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/forsook-5c2c5369.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/forsaken-23611091.mp3"
      }
    },
    {
      "baseForm": "freeze",
      "pastSimple": "froze",
      "pastParticiple": "frozen",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/freeze-fabf2162.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/froze-bc9b52a2.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/frozen-98e3a950.mp3"
      }
    },
    {
      "baseForm": "get",
      "pastSimple": "got",
      "pastParticiple": "got/gotten",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/get-c1184884.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/got-0bd98bfb.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/got-gotten-5a6c1660.mp3"
      }
    },
    {
      "baseForm": "give",
      "pastSimple": "gave",
      "pastParticiple": "given",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/give-c695afa6.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/gave-fc9060a0.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/given-8064e1d6.mp3"
      }
    },
    {
      "baseForm": "go",
      "pastSimple": "went",
      "pastParticiple": "gone",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/go-fef2c059.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/went-e72d5691.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/gone-9ef04088.mp3"
      }
    },
    {
      "baseForm": "grind",
      "pastSimple": "ground",
      "pastParticiple": "ground",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/grind-f1757d65.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/ground-1bab1717.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/ground-1bab1717.mp3"
      }
    },
    {
      "baseForm": "grow",
      "pastSimple": "grew",
      "pastParticiple": "grown",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/grow-92e28441.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/grew-f1b08353.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/grown-49a724ac.mp3"
      }
    },
    {
      "baseForm": "hang",
      "pastSimple": "hung/hanged",
      "pastParticiple": "hung/hanged",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/hang-0134a681.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/hung-hanged-03d34d21.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/hung-hanged-03d34d21.mp3"
      }
    },
    {
      "baseForm": "have",
      "pastSimple": "had",
      "pastParticiple": "had",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/have-fd3c6f79.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/had-78b6769d.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/had-78b6769d.mp3"
      }
    },
    {
      "baseForm": "hear",
      "pastSimple": "heard",
      "pastParticiple": "heard",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/hear-760eaf3e.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/heard-211fe725.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/heard-211fe725.mp3"
      }
    },
    {
      "baseForm": "hide",
      "pastSimple": "hid",
      "pastParticiple": "hidden",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/hide-e3d530e4.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/hid-aa19e2e4.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/hidden-3edf14e4.mp3"
      }
    },
    {
      "baseForm": "hit",
      "pastSimple": "hit",
      "pastParticiple": "hit",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/hit-65714d3f.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/hit-65714d3f.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/hit-65714d3f.mp3"
      }
    },
    {
      "baseForm": "hoist",
      "pastSimple": "hoist/hoisted",
      "pastParticiple": "hoist/hoisted",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/hoist-f9ea6584.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/hoist-hoisted-66a1c867.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/hoist-hoisted-66a1c867.mp3"
      }
    },
    {
      "baseForm": "hold",
      "pastSimple": "held",
      "pastParticiple": "held",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/hold-f1c8b10b.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/held-36a5c652.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/held-36a5c652.mp3"
      }
    },
    {
      "baseForm": "hurt",
      "pastSimple": "hurt",
      "pastParticiple": "hurt",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/hurt-3fb0847e.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/hurt-3fb0847e.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/hurt-3fb0847e.mp3"
      }
    },
    {
      "baseForm": "keep",
      "pastSimple": "kept",
      "pastParticiple": "kept",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/keep-f44895f6.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/kept-507a2606.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/kept-507a2606.mp3"
      }
    },
    {
      "baseForm": "kneel",
      "pastSimple": "knelt/kneeled",
      "pastParticiple": "knelt/kneeled",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/kneel-dfd6c0e2.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/knelt-kneeled-3286ef46.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/knelt-kneeled-3286ef46.mp3"
      }
    },
    {
      "baseForm": "knit",
      "pastSimple": "knit/knitted",
      "pastParticiple": "knit/knitted",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/knit-147e091b.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/knit-knitted-a623e145.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/knit-knitted-a623e145.mp3"
      }
    },
    {
      "baseForm": "know",
      "pastSimple": "knew",
      "pastParticiple": "known",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/know-a4378cc1.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/knew-e89c552c.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/known-a61355d7.mp3"
      }
    },
    {
      "baseForm": "lay",
      "pastSimple": "laid",
      "pastParticiple": "laid",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/lay-ae27fc43.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/laid-5e8e081b.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/laid-5e8e081b.mp3"
      }
    },
    {
      "baseForm": "lead",
      "pastSimple": "led",
      "pastParticiple": "led",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/lead-163e46b6.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/led-96b899ab.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/led-96b899ab.mp3"
      }
    },
    {
      "baseForm": "lean",
      "pastSimple": "leant/leaned",
      "pastParticiple": "leant/leaned",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/lean-67f09e50.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/leant-leaned-0884e99c.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/leant-leaned-0884e99c.mp3"
      }
    },
    {
      "baseForm": "leap",
      "pastSimple": "leapt/leaped",
      "pastParticiple": "leapt/leaped",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/leap-ccb002ea.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/leapt-leaped-3c325791.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/leapt-leaped-3c325791.mp3"
      }
    },
    {
      "baseForm": "learn",
      "pastSimple": "learnt/learned",
      "pastParticiple": "learnt/learned",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/learn-cd1b33ac.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/learnt-learned-971b5159.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/learnt-learned-971b5159.mp3"
      }
    },
    {
      "baseForm": "leave",
      "pastSimple": "left",
      "pastParticiple": "left",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/leave-adf08344.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/left-422d5756.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/left-422d5756.mp3"
      }
    },
    {
      "baseForm": "lend",
      "pastSimple": "lent",
      "pastParticiple": "lent",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/lend-5fac1b78.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/lent-82202f81.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/lent-82202f81.mp3"
      }
    },
    {
      "baseForm": "lie (in bed)",
      "pastSimple": "lay",
      "pastParticiple": "lain",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/lie-35ecace3.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/lay-bd367541.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/lain-cd5fd5e7.mp3"
      }
    },
    {
      "baseForm": "light",
      "pastSimple": "lit/lighted",
      "pastParticiple": "lit/lighted",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/light-6fce0520.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/lit-lighted-c492a416.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/lit-lighted-c492a416.mp3"
      }
    },
    {
      "baseForm": "lose",
      "pastSimple": "lost",
      "pastParticiple": "lost",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/lose-90aaca7c.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/lost-de38b924.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/lost-de38b924.mp3"
      }
    },
    {
      "baseForm": "make",
      "pastSimple": "made",
      "pastParticiple": "made",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/make-44d52330.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/made-9eb6d1aa.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/made-9eb6d1aa.mp3"
      }
    },
    {
      "baseForm": "mean",
      "pastSimple": "meant",
      "pastParticiple": "meant",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/mean-ae9484f7.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/meant-5598cf2e.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/meant-5598cf2e.mp3"
      }
    },
    {
      "baseForm": "meet",
      "pastSimple": "met",
      "pastParticiple": "met",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/meet-84977d55.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/met-108a2cbd.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/met-108a2cbd.mp3"
      }
    },
    {
      "baseForm": "mow",
      "pastSimple": "mowed",
      "pastParticiple": "mown/mowed",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/mow-ceafa71f.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/mowed-cbf9505f.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/mown-mowed-c177231f.mp3"
      }
    },
    {
      "baseForm": "pay",
      "pastSimple": "paid",
      "pastParticiple": "paid",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/pay-73868f82.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/paid-30addc57.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/paid-30addc57.mp3"
      }
    },
    {
      "baseForm": "plead",
      "pastSimple": "pled/pleaded",
      "pastParticiple": "pled/pleaded",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/plead-b9adec10.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/pled-pleaded-525caf1f.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/pled-pleaded-525caf1f.mp3"
      }
    },
    {
      "baseForm": "prove",
      "pastSimple": "proved",
      "pastParticiple": "proved/proven",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/prove-3ce82264.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/proved-925baa26.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/proved-proven-dbafabf3.mp3"
      }
    },
    {
      "baseForm": "put",
      "pastSimple": "put",
      "pastParticiple": "put",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/put-f31a8e70.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/put-f31a8e70.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/put-f31a8e70.mp3"
      }
    },
    {
      "baseForm": "quit",
      "pastSimple": "quit",
      "pastParticiple": "quit",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/quit-8cdffee0.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/quit-8cdffee0.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/quit-8cdffee0.mp3"
      }
    },
    {
      "baseForm": "read",
      "pastSimple": "read",
      "pastParticiple": "read",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/reed-f906196c.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/read-e0525bdc.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/read-e0525bdc.mp3"
      }
    },
    {
      "baseForm": "ride",
      "pastSimple": "rode",
      "pastParticiple": "ridden",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/ride-5ad830d7.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/rode-9e52d8c6.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/ridden-64cd1353.mp3"
      }
    },
    {
      "baseForm": "ring",
      "pastSimple": "rang",
      "pastParticiple": "rung",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/ring-0d63c150.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/rang-51a786d0.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/rung-7acd64a1.mp3"
      }
    },
    {
      "baseForm": "rise",
      "pastSimple": "rose",
      "pastParticiple": "risen",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/rise-673f1e44.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/rose-150df10d.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/risen-0709f784.mp3"
      }
    },
    {
      "baseForm": "run",
      "pastSimple": "ran",
      "pastParticiple": "run",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/run-b4fd33f4.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/ran-1a110337.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/run-b4fd33f4.mp3"
      }
    },
    {
      "baseForm": "saw",
      "pastSimple": "sawed",
      "pastParticiple": "sawn/sawed",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/saw-b8ae10d9.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/sawed-d4906fa8.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/sawn-sawed-4e53212b.mp3"
      }
    },
    {
      "baseForm": "say",
      "pastSimple": "said",
      "pastParticiple": "said",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/say-8350367c.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/said-755ebf6e.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/said-755ebf6e.mp3"
      }
    },
    {
      "baseForm": "see",
      "pastSimple": "saw",
      "pastParticiple": "seen",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/see-3d7cf244.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/saw-b8ae10d9.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/seen-6d848175.mp3"
      }
    },
    {
      "baseForm": "seek",
      "pastSimple": "sought",
      "pastParticiple": "sought",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/seek-f10c8634.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/sought-6b01d2ce.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/sought-6b01d2ce.mp3"
      }
    },
    {
      "baseForm": "sell",
      "pastSimple": "sold",
      "pastParticiple": "sold",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/sell-4e9312ec.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/sold-58e47958.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/sold-58e47958.mp3"
      }
    },
    {
      "baseForm": "send",
      "pastSimple": "sent",
      "pastParticiple": "sent",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/send-de96aac2.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/sent-ca70da1c.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/sent-ca70da1c.mp3"
      }
    },
    {
      "baseForm": "set",
      "pastSimple": "set",
      "pastParticiple": "set",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/set-b933e51e.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/set-b933e51e.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/set-b933e51e.mp3"
      }
    },
    {
      "baseForm": "sew",
      "pastSimple": "sewed",
      "pastParticiple": "sewn/sewed",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/sew-e7cf8ee0.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/sewed-d48edfcf.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/sewn-sewed-b59ccd40.mp3"
      }
    },
    {
      "baseForm": "shake",
      "pastSimple": "shook",
      "pastParticiple": "shaken",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/shake-b5735af5.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/shook-6cb96a59.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/shaken-3d792f9f.mp3"
      }
    },
    {
      "baseForm": "shear",
      "pastSimple": "shore/sheared",
      "pastParticiple": "shorn/sheared",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/shear-971151bf.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/shore-sheared-2cbf5b6e.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/shore-sheared-2cbf5b6e.mp3"
      }
    },
    {
      "baseForm": "shed",
      "pastSimple": "shed",
      "pastParticiple": "shed",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/shed-f16763b8.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/shed-f16763b8.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/shed-f16763b8.mp3"
      }
    },
    {
      "baseForm": "shine",
      "pastSimple": "shone",
      "pastParticiple": "shone",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/shine-7e7677eb.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/shone-c1e265e7.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/shone-c1e265e7.mp3"
      }
    },
    {
      "baseForm": "shoot",
      "pastSimple": "shot",
      "pastParticiple": "shot",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/shoot-a08c27c3.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/shot-640c1227.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/shot-640c1227.mp3"
      }
    },
    {
      "baseForm": "show",
      "pastSimple": "showed",
      "pastParticiple": "shown",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/show-a95e3e53.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/showed-f4ff5642.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/shown-5c86f6d1.mp3"
      }
    },
    {
      "baseForm": "shrink",
      "pastSimple": "shrank",
      "pastParticiple": "shrunk",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/shrink-b1cf8234.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/shrank-2a8f116b.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/shrunk-b3f008de.mp3"
      }
    },
    {
      "baseForm": "shut",
      "pastSimple": "shut",
      "pastParticiple": "shut",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/shut-4369efa4.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/shut-4369efa4.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/shut-4369efa4.mp3"
      }
    },
    {
      "baseForm": "sing",
      "pastSimple": "sang",
      "pastParticiple": "sung",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/sing-bf49c17e.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/sang-65b64ea9.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/sung-aa8f8335.mp3"
      }
    },
    {
      "baseForm": "sink",
      "pastSimple": "sank",
      "pastParticiple": "sunk",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/sink-8e7f26cf.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/sank-582cf082.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/sunk-deaf98fc.mp3"
      }
    },
    {
      "baseForm": "sit",
      "pastSimple": "sat",
      "pastParticiple": "sat",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/sit-42df86f1.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/sat-efabd0bf.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/sat-efabd0bf.mp3"
      }
    },
    {
      "baseForm": "sleep",
      "pastSimple": "slept",
      "pastParticiple": "slept",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/sleep-b21e1198.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/slept-57589158.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/slept-57589158.mp3"
      }
    },
    {
      "baseForm": "slide",
      "pastSimple": "slid",
      "pastParticiple": "slid",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/slide-f7cdaca1.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/slid-031a318f.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/slid-031a318f.mp3"
      }
    },
    {
      "baseForm": "smell",
      "pastSimple": "smelt/smelled",
      "pastParticiple": "smelt/smelled",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/smell-1faf692a.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/smelt-smelled-e7876f45.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/smelt-smelled-e7876f45.mp3"
      }
    },
    {
      "baseForm": "sow",
      "pastSimple": "sowed",
      "pastParticiple": "sown/sowed",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/sow-009b1e7a.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/sowed-d0808be8.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/sown-sowed-399636b4.mp3"
      }
    },
    {
      "baseForm": "speak",
      "pastSimple": "spoke",
      "pastParticiple": "spoken",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/speak-b0ae3c99.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/spoke-c0a037cd.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/spoken-edd09bca.mp3"
      }
    },
    {
      "baseForm": "spell",
      "pastSimple": "spelt/spelled",
      "pastParticiple": "spelt/spelled",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/spell-f99705f9.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/spelt-spelled-1586c84c.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/spelt-spelled-1586c84c.mp3"
      }
    },
    {
      "baseForm": "spend",
      "pastSimple": "spent",
      "pastParticiple": "spent",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/spend-e2884302.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/spent-cab9aca7.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/spent-cab9aca7.mp3"
      }
    },
    {
      "baseForm": "spill",
      "pastSimple": "spilt/spilled",
      "pastParticiple": "spilt/spilled",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/spill-dfbe81bb.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/spilt-spilled-86306c24.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/spilt-spilled-86306c24.mp3"
      }
    },
    {
      "baseForm": "spin",
      "pastSimple": "span/spun",
      "pastParticiple": "spun",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/spin-4cbd3b67.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/span-spun-940bf34b.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/spun-a677326b.mp3"
      }
    },
    {
      "baseForm": "spit",
      "pastSimple": "spat/spit",
      "pastParticiple": "spat/spit",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/spit-730d644d.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/spat-spit-3b29dea8.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/spat-spit-3b29dea8.mp3"
      }
    },
    {
      "baseForm": "spread",
      "pastSimple": "spread",
      "pastParticiple": "spread",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/spread-3a3fd9af.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/spread-3a3fd9af.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/spread-3a3fd9af.mp3"
      }
    },
    {
      "baseForm": "stand",
      "pastSimple": "stood",
      "pastParticiple": "stood",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/stand-807e72d8.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/stood-aaa9688b.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/stood-aaa9688b.mp3"
      }
    },
    {
      "baseForm": "steal",
      "pastSimple": "stole",
      "pastParticiple": "stolen",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/steal-3fce471f.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/stole-b095216d.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/stolen-9c63dd16.mp3"
      }
    },
    {
      "baseForm": "stick",
      "pastSimple": "stuck",
      "pastParticiple": "stuck",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/stick-e71f9e39.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/stuck-b4dfae8f.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/stuck-b4dfae8f.mp3"
      }
    },
    {
      "baseForm": "sting",
      "pastSimple": "stung",
      "pastParticiple": "stung",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/sting-1f35f04a.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/stung-cc79a3f3.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/stung-cc79a3f3.mp3"
      }
    },
    {
      "baseForm": "stink",
      "pastSimple": "stank",
      "pastParticiple": "stunk",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/stink-748c8a24.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/stank-1a90fa9e.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/stunk-55640367.mp3"
      }
    },
    {
      "baseForm": "stride",
      "pastSimple": "strode",
      "pastParticiple": "stridden",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/stride-21723c0a.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/strode-ee75036f.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/stridden-2d718f47.mp3"
      }
    },
    {
      "baseForm": "strike",
      "pastSimple": "struck",
      "pastParticiple": "struck",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/strike-3889df41.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/struck-1c2ef4bf.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/struck-1c2ef4bf.mp3"
      }
    },
    {
      "baseForm": "strive",
      "pastSimple": "strove/strived",
      "pastParticiple": "striven/strived",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/strive-3f51f8e5.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/strove-strived-45755b70.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/striven-strived-88d33aac.mp3"
      }
    },
    {
      "baseForm": "swear",
      "pastSimple": "swore",
      "pastParticiple": "sworn",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/swear-a7f96e96.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/swore-d7523f3e.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/sworn-b761f836.mp3"
      }
    },
    {
      "baseForm": "sweat",
      "pastSimple": "sweat/sweated",
      "pastParticiple": "sweat/sweated",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/sweat-ac48e7b7.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/sweat-sweated-42fa5495.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/sweat-sweated-42fa5495.mp3"
      }
    },
    {
      "baseForm": "sweep",
      "pastSimple": "swept",
      "pastParticiple": "swept",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/sweep-cb24b394.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/swept-53f34603.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/swept-53f34603.mp3"
      }
    },
    {
      "baseForm": "swell",
      "pastSimple": "swelled",
      "pastParticiple": "swollen/swelled",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/swell-671b7d2e.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/swelled-a56dda25.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/swollen-swelled-a6cd8a98.mp3"
      }
    },
    {
      "baseForm": "swim",
      "pastSimple": "swam",
      "pastParticiple": "swum",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/swim-8b3e6551.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/swam-3c8e4e71.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/swum-ae14cf45.mp3"
      }
    },
    {
      "baseForm": "swing",
      "pastSimple": "swung",
      "pastParticiple": "swung",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/swing-1ebce93c.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/swung-52adba05.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/swung-52adba05.mp3"
      }
    },
    {
      "baseForm": "take",
      "pastSimple": "took",
      "pastParticiple": "taken",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/take-febd6efe.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/took-1014bb3f.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/taken-16c75ca4.mp3"
      }
    },
    {
      "baseForm": "teach",
      "pastSimple": "taught",
      "pastParticiple": "taught",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/teach-f4972e4f.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/taught-2807f8bf.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/taught-2807f8bf.mp3"
      }
    },
    {
      "baseForm": "tear",
      "pastSimple": "tore",
      "pastParticiple": "torn",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/tear-3e40037c.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/tore-9a171d48.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/torn-2b04df23.mp3"
      }
    },
    {
      "baseForm": "tell",
      "pastSimple": "told",
      "pastParticiple": "told",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/tell-1c4ffd4c.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/told-68966d1d.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/told-68966d1d.mp3"
      }
    },
    {
      "baseForm": "think",
      "pastSimple": "thought",
      "pastParticiple": "thought",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/think-66278e97.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/thought-d16f29eb.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/thought-d16f29eb.mp3"
      }
    },
    {
      "baseForm": "thrive",
      "pastSimple": "throve/thrived",
      "pastParticiple": "thriven/thrived",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/thrive-1cfc1cb4.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/throve-thrived-ed040d8a.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/thriven-thrived-c7a6ca92.mp3"
      }
    },
    {
      "baseForm": "throw",
      "pastSimple": "threw",
      "pastParticiple": "thrown",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/throw-f59a452d.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/threw-302af94a.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/thrown-8ec09cf0.mp3"
      }
    },
    {
      "baseForm": "tread",
      "pastSimple": "trod",
      "pastParticiple": "trod/trodden",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/tread-cf3b25db.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/trod-23cd3ead.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/trod-trodden-8acb4d51.mp3"
      }
    },
    {
      "baseForm": "understand",
      "pastSimple": "understood",
      "pastParticiple": "understood",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/understand-e4b14a6e.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/understood-428cd261.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/understood-428cd261.mp3"
      }
    },
    {
      "baseForm": "wake",
      "pastSimple": "woke",
      "pastParticiple": "woken",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/wake-82ef3967.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/woke-acf1fc47.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/woken-26f66a5e.mp3"
      }
    },
    {
      "baseForm": "wear",
      "pastSimple": "wore",
      "pastParticiple": "worn",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/wear-bd87b2c6.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/wore-19491dcd.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/worn-6eeb9742.mp3"
      }
    },
    {
      "baseForm": "weave",
      "pastSimple": "wove",
      "pastParticiple": "woven",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/weave-e414f2c1.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/wove-b823d0af.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/woven-d7ab3466.mp3"
      }
    },
    {
      "baseForm": "weep",
      "pastSimple": "wept",
      "pastParticiple": "wept",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/weep-06554c78.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/wept-a9a5d0d8.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/wept-a9a5d0d8.mp3"
      }
    },
    {
      "baseForm": "wet",
      "pastSimple": "wet/wetted",
      "pastParticiple": "wet/wetted",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/wet-efc11d2d.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/wet-wetted-9ad79477.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/wet-wetted-9ad79477.mp3"
      }
    },
    {
      "baseForm": "win",
      "pastSimple": "won",
      "pastParticiple": "won",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/win-5b2e0cff.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/won-cd096a98.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/won-cd096a98.mp3"
      }
    },
    {
      "baseForm": "wind",
      "pastSimple": "wound",
      "pastParticiple": "wound",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/wind-3fdf6bea.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/wound-db03d118.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/wound-db03d118.mp3"
      }
    },
    {
      "baseForm": "write",
      "pastSimple": "wrote",
      "pastParticiple": "written",
      "audioUrls": {
        "baseForm": "https://lingbase.com/files/mp3/complete-list-irregular/write-fc522fa5.mp3",
        "pastSimple": "https://lingbase.com/files/mp3/complete-list-irregular/wrote-15753a9d.mp3",
        "pastParticiple": "https://lingbase.com/files/mp3/complete-list-irregular/written-dc81a713.mp3"
      }
    }
  ]
};
