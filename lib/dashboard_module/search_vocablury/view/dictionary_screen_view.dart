import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  DictionaryScreenState createState() => DictionaryScreenState();
}

class DictionaryScreenState extends State<DictionaryScreen> {
  late List<Map<String, dynamic>> _wordData;
  late TextEditingController _textEditingController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _wordData = [];
  }

  Future<void> fetchData() async {
    try {
      isLoading = true;
      final response = await http.get(
        Uri.parse(
            'https://api.dictionaryapi.dev/api/v2/entries/en_US/${_textEditingController.text}'),
      );
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          _wordData = responseData.cast<Map<String, dynamic>>();
        });
        isLoading = false;
      } else {
        isLoading = false;
        throw Exception('Failed to load data');
      }
    } catch (e) {
      isLoading = false;
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.zircon,
      appBar: CustomAppBar(
        title: "Dictionary",
        isProfileView: false,
        bgColor: AppColors.zircon,
        actionOnTap: () {
          return;
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Enter word',
                prefixIcon: const Icon(Icons.search),
                suffixIcon:
                    // _wordData.isEmpty
                    //     ? CircularProgressIndicator(
                    //         color: AppColors.toryBlue,
                    //         backgroundColor: AppColors.white,
                    //       )
                    //     :
                    IconButton(
                  onPressed: () async {
                    await fetchData();
                  },
                  icon: const Icon(Icons.send),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: _wordData.isNotEmpty
                ? ListView.builder(
                    itemCount: _wordData.length,
                    itemBuilder: (context, index) {
                      final word = _wordData[index];
                      return ListTile(
                        title: Text(
                          word['word'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (word['phonetic'] != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text('Phonetic: ${word['phonetic']}'),
                              ),
                            if (word['meanings'] != null)
                              ...List<Widget>.from(
                                (word['meanings'] as List<dynamic>).map(
                                  (meaning) => Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          'Part of Speech: ${meaning['partOfSpeech']}',
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      ...List<Widget>.from((meaning['definitions'] as List<dynamic>)
                                          .map((definition) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4),
                                              child:
                                                  Text('Definition: ${definition['definition']}'),
                                            ),
                                            if (definition['synonyms'] != null &&
                                                (definition['synonyms'] as List).isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.only(top: 4),
                                                child: Text(
                                                    'Synonyms: ${definition['synonyms'].join(", ")}'),
                                              ),
                                            if (definition['antonyms'] != null &&
                                                (definition['antonyms'] as List).isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.only(top: 4),
                                                child: Text(
                                                    'Antonyms: ${definition['antonyms'].join(", ")}'),
                                              ),
                                          ],
                                        );
                                      })),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      _textEditingController.text.isNotEmpty
                          ? 'No results found'
                          : 'Enter a word to search',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
// import 'package:vocablury/components/app_bar/custom_app_bar.dart';
// import 'package:vocablury/dashboard_module/search_vocablury/controller/dictionary_controller.dart';
// import 'package:vocablury/dashboard_module/search_vocablury/model/dictionary_data_model.dart';
// import 'package:vocablury/utilities/theme/app_colors.dart';
//
// final _dictionaryController = Get.put(DictionaryController());
//
// class DictionaryScreen extends StatefulWidget {
//   const DictionaryScreen({super.key});
//
//   @override
//   State<DictionaryScreen> createState() => DictionaryScreenState();
// }
//
// class DictionaryScreenState extends State<DictionaryScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // _dictionaryController.getDictionary("bitter");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.zircon,
//       appBar: CustomAppBar(
//         title: "Dictionary",
//         isProfileView: false,
//         bgColor: AppColors.zircon,
//         leadingOnTap: () {
//           context.pop(context);
//         },
//         actionOnTap: () {
//           return;
//         },
//       ),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Obx(
//               () {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                   child: TextField(
//                     controller: _dictionaryController.inputController,
//                     // onChanged: _dictionaryController.searchWordMeaning,
//
//                     inputFormatters: [
//                       FilteringTextInputFormatter.allow(
//                         RegExp("[a-zA-Z]"),
//                       )
//                     ],
//                     decoration: InputDecoration(
//                       labelText: 'Search word meaning',
//                       prefixIcon: const Icon(Icons.search),
//                       suffixIcon: _dictionaryController.isLoading.value
//                           ? const SizedBox(height: 2, width: 2, child: CircularProgressIndicator())
//                           : GestureDetector(
//                               onTap: () async {
//                                 final word = _dictionaryController.inputController.text;
//
//                                 await _dictionaryController.getDictionary(word);
//                               },
//                               child: const Icon(
//                                 Icons.send,
//                                 color: Colors.deepPurple,
//                               ),
//                             ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             _dictionaryController.obx(
//               (state) {
//                 return SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     physics: const BouncingScrollPhysics(),
//                     child: Text("${state?.word.toString()}"));
//               },
//               onLoading: Container(),
//               onEmpty: const Text("No Data"),
//               //     onError: (error) {
//               //   return const Center(
//               //     child: Text("Custom Error "),
//               //   );
//               // }
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class WordDetailsView extends StatelessWidget {
//   final DictionaryDataModel wordModel;
//
//   WordDetailsView({Key? key, required this.wordModel}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       physics: const BouncingScrollPhysics(),
//       child: Container(
//         color: Colors.grey[200],
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Display word and phonetic
//             Text(
//               'Word: ${wordModel.word}',
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Phonetic: ${wordModel.phonetic}',
//               style: const TextStyle(fontStyle: FontStyle.italic),
//             ),
//             const SizedBox(height: 16),
//             // Display meanings
//             const Text(
//               'Meanings:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             // Loop through meanings and display
//             for (var meaning in wordModel.meanings ?? [])
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Part of Speech: ${meaning.partOfSpeech}',
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 4),
//                   // Loop through definitions and display
//                   for (var definition in meaning.definitions ?? [])
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Definition: ${definition.definition}',
//                         ),
//                         const SizedBox(height: 4),
//                         // Display synonyms if available
//                         if (definition.synonyms != null && definition.synonyms!.isNotEmpty)
//                           Text(
//                             'Synonyms: ${definition.synonyms!.join(", ")}',
//                           ),
//                         const SizedBox(height: 4),
//                         // Display antonyms if available
//                         if (definition.antonyms != null && definition.antonyms!.isNotEmpty)
//                           Text(
//                             'Antonyms: ${definition.antonyms!.join(", ")}',
//                           ),
//                         const SizedBox(height: 8),
//                       ],
//                     ),
//                   const SizedBox(height: 16),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
