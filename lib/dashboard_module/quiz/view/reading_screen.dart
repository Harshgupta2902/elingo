import 'package:flutter/material.dart';
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/dashboard_module/quiz/model/get_reading_data.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/box_decoration.dart';
import 'package:vocablury/utilities/theme/button_decoration.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  final modelData = GetReadingData.fromJson(jsonData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.zircon,
      appBar: CustomAppBar(
        title: "English Grammar",
        isProfileView: false,
        bgColor: AppColors.zircon,
        actionOnTap: () {
          return;
        },
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              child: Text(
                "English Grammar For Reading",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: modelData.sections?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final section = modelData.sections?[index];
                final sectionTitle = section?.sectionTitle ?? "";
                final questions = section?.questions ?? [];

                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  decoration: AppBoxDecoration.getBorderBoxDecoration(
                    showShadow: true,
                    borderColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    iconColor: AppColors.scienceBlue,

                    title: Text(
                      sectionTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    // pa
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "A transcript is a comprehensive record of a student's academic...",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.scienceBlue,
                            ),
                      ),
                    ),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: questions.length,
                        itemBuilder: (BuildContext context, int index) {
                          final question = questions[index];
                          final options = question.options;
                          final answer = question.answer;

                          return QuizQuestionTile(
                            sentence: question.sentence ?? "",
                            options: options ?? [],
                            answer: answer.toString(),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class QuizQuestionTile extends StatefulWidget {
  final String sentence;
  final List<dynamic> options;
  final String answer;

  const QuizQuestionTile({
    super.key,
    required this.sentence,
    required this.options,
    required this.answer,
  });

  @override
  QuizQuestionTileState createState() => QuizQuestionTileState();
}

class QuizQuestionTileState extends State<QuizQuestionTile> {
  bool showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      focusColor: AppColors.scienceBlue,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.sentence ?? ""),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.options.asMap().entries.map((entry) {
                    final int optionIndex = entry.key;
                    final String option = entry.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                      ),
                      child: Text(
                        '${optionIndex + 1}. $option',
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Column(
                children: [
                  OutlinedButton(
                    style: getOutlinedButtonStyle(
                        borderRadius: 12,
                        foregroundColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        borderColor: AppColors.scienceBlue,
                        borderWidth: 2.0,
                        buttonColor: Colors.white,
                        height: 40,
                        width: 80,
                        showShadow: false),
                    onPressed: () {
                      setState(() {
                        showAnswer = !showAnswer;
                      });
                    },
                    child: Text(
                      showAnswer ? 'Hide Correct Answer' : 'Show Correct Answer',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.scienceBlue,
                          ),
                    ),
                  ),
                  if (showAnswer)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Correct Answer: ${widget.answer}',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.green),
                      ),
                    ),
                ],
              )
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

const jsonData = {
  "title": "English Grammar Quiz for Reading ",
  "sections": [
    {
      "section_title": "Questions On Noun",
      "questions": [
        {
          "sentence": "I live in Amsterdam.",
          "options": ["In", "Live", "Amsterdam", "I"],
          "answer": "Amsterdam"
        },
        {
          "sentence": "I visited the Eiffel Tower in Paris.",
          "options": ["The", "Paris", "Eiffel Tower and Paris", "Eiffel Tower"],
          "answer": "Eiffel Tower and Paris"
        },
        {
          "sentence": "Bhutan is a beautiful country.",
          "options": ["A", "Country", "Beautiful", "Bhutan"],
          "answer": "Bhutan"
        },
        {
          "sentence": "Summer is very hot.",
          "options": ["Summer", "Very", "Hot", "Is"],
          "answer": "Summer"
        },
        {
          "sentence": "The moon looks so beautiful.",
          "options": ["Looks", "Moon", "The", "Beautiful"],
          "answer": "Moon"
        },
        {
          "sentence": "The doctor is an expert in his field.",
          "options": ["His", "Expert", "Field", "Doctor"],
          "answer": "Doctor"
        },
        {
          "sentence": "The mailman Mr. Joe was carrying postcards.",
          "options": ["Mailman", "Mr. Joe", "Postcards", "Mailman, Mr. Joe and postcards"],
          "answer": "Mailman, Mr. Joe and postcards"
        },
        {
          "sentence": "Are these mangoes tasty?",
          "options": ["Tasty", "Are", "These", "Mangoes"],
          "answer": "Mangoes"
        },
        {
          "sentence":
              "Hello Sophie! Will you play football with us as the climate is beautiful and the team is one player short?",
          "options": ["Football", "Sophie, football, climate, team, player", "Team", "Climate"],
          "answer": "Sophie, football, climate, team, player"
        },
        {
          "sentence": "Mike’s birthday party at the Sheraton was a success.",
          "options": ["Sheraton", "Mike", "Mike, party, Sheraton", "Party"],
          "answer": "Mike, party, Sheraton"
        }
      ]
    },
    {
      "section_title": "Questions On Pronoun",
      "questions": [
        {
          "sentence": "They were having dinner.",
          "options": ["Dinner", "They", "Were", "Having"],
          "answer": "They"
        },
        {
          "sentence": "I want to sleep.",
          "options": ["To", "Sleep", "I", "Want"],
          "answer": "I"
        },
        {
          "sentence": "Is that my laptop?",
          "options": ["My", "Laptop", "Is", "That"],
          "answer": "My"
        },
        {
          "sentence": "Everyone is sleeping in the dorm room.",
          "options": ["Sleeping", "Dorm", "Room", "Everyone"],
          "answer": "Everyone"
        },
        {
          "sentence": "We were playing scrabble.",
          "options": ["Playing", "Scrabble", "We", "Were"],
          "answer": "We"
        },
        {
          "sentence": "Look at Ellen, she is a beautiful artist.",
          "options": ["Beautiful", "She", "Ellen", "Artist"],
          "answer": "She"
        },
        {
          "sentence": "He is good at cricket.",
          "options": ["At", "Good", "Cricket", "He"],
          "answer": "He"
        },
        {
          "sentence": "This house is mine.",
          "options": ["This", "House", "Mine", "Is"],
          "answer": "Mine"
        },
        {
          "sentence": "Would you like to have coffee?",
          "options": ["Coffee", "Have", "You", "Would"],
          "answer": "You"
        },
        {
          "sentence": "Did you hear that?",
          "options": ["That", "Did", "You", "Hear"],
          "answer": "That"
        }
      ]
    },
    {
      "section_title": "Questions On Verb",
      "questions": [
        {
          "sentence": "The monkey sat by the door.",
          "options": ["Monkey", "By", "Door", "Sat"],
          "answer": "Sat"
        },
        {
          "sentence": "Jack left in a hurry.",
          "options": ["A", "Hurry", "Jack", "Left"],
          "answer": "Left"
        },
        {
          "sentence": "Michelle hurt her elbow while playing.",
          "options": ["Hurt", "Elbow", "Michelle", "Hurt, playing"],
          "answer": "Hurt, playing"
        },
        {
          "sentence": "Please open the door.",
          "options": ["Open", "The", "Please", "Door"],
          "answer": "Open"
        },
        {
          "sentence": "She bought a new car and started taking her driving lessons.",
          "options": ["Started", "New", "Taking", "Bought, started, taking"],
          "answer": "Bought, started, taking"
        },
        {
          "sentence": "Joe accepted the job offer.",
          "options": ["The", "Job", "Accepted", "Joe"],
          "answer": "Accepted"
        },
        {
          "sentence": "Kelly enjoys hip-hop music.",
          "options": ["Kelly", "Hip-hop", "Music", "Enjoys"],
          "answer": "Enjoys"
        },
        {
          "sentence": "We went to the grocery store and bought so many items that carrying them home became difficult.",
          "options": ["Went", "Bought", "Carrying", "All three"],
          "answer": "All three"
        },
        {
          "sentence": "The accountant is calculating the expenditure for the month of February.",
          "options": ["Accountant", "Calculating", "Month", "Expenditure"],
          "answer": "Calculating"
        },
        {
          "sentence": "Johnson earns a lot of money but he spends it too.",
          "options": ["Earns", "Spends", "Earns and spends", "Johnson"],
          "answer": "Earns"
        }
      ]
    },
    {
      "section_title": "Questions On Adjective",
      "questions": [
        {
          "sentence": "Ria lives in a beautiful house.",
          "options": ["Ria", "House", "Beautiful", "Lives"],
          "answer": "Beautiful"
        },
        {
          "sentence": "This store has a nice collection of shoes.",
          "options": ["Store", "Collection", "Nice", "Shoes"],
          "answer": "Nice"
        },
        {
          "sentence": "Linda McKenzie has five children.",
          "options": ["Linda", "Has", "Children", "Five"],
          "answer": "Five"
        },
        {
          "sentence": "There were 80 chairs in the auditorium.",
          "options": ["Were", "Auditorium", "80", "Chairs"],
          "answer": "80"
        },
        {
          "sentence": "A colorful butterfly was sitting in the garden.",
          "options": ["Garden", "Colorful", "Sitting", "Butterfly"],
          "answer": "Colorful"
        },
        {
          "sentence": "Only a few mangoes are remaining in the basket.",
          "options": ["Basket", "A few", "Mangoes", "Remaining"],
          "answer": "A few"
        },
        {
          "sentence": "This hot and humid weather is exhausting.",
          "options": ["Hot", "Humid", "Hot and humid", "Exhausting"],
          "answer": "Hot and humid"
        },
        {
          "sentence": "Sophie is a part-time worker at the salon.",
          "options": ["Sophie", "Part-time", "Worker", "Salon"],
          "answer": "Part-time"
        },
        {
          "sentence": "Meera lost her brown bag.",
          "options": ["Meera", "Brown", "Bag", "Lost"],
          "answer": "Brown"
        },
        {
          "sentence": "Paul tries to help homeless people.",
          "options": ["Tries", "Help", "Paul", "Homeless"],
          "answer": "Homeless"
        }
      ]
    },
    {
      "section_title": "Identify Present, Past Or Future Tense",
      "questions": [
        {
          "sentence": "He plays basketball every day.",
          "options": ["Present", "Past", "Future"],
          "answer": "Present"
        },
        {
          "sentence": "Meera will go to a concert.",
          "options": ["Present", "Past", "Future"],
          "answer": "Future"
        },
        {
          "sentence": "It rained heavily.",
          "options": ["Present", "Past", "Future"],
          "answer": "Past"
        },
        {
          "sentence": "The baby is crying.",
          "options": ["Past", "Present", "Future"],
          "answer": "Present"
        },
        {
          "sentence": "Dogs were barking a lot.",
          "options": ["Past", "Future", "Present"],
          "answer": "Past"
        },
        {
          "sentence": "The car was parked in the wrong lane.",
          "options": ["Past", "Present", "Future"],
          "answer": "Past"
        },
        {
          "sentence": "Kenny will visit her ailing grandfather after returning from work.",
          "options": ["Future", "Past", "Present"],
          "answer": "Future"
        }
      ]
    },
    {
      "section_title": "Fill In The Blanks",
      "questions": [
        {
          "sentence": "The students are __________ their notes.",
          "options": ["Wrote", "Written", "Writing", "Write"],
          "answer": "Writing"
        },
        {
          "sentence": "The doctor _____ out for ten minutes.",
          "options": ["Go", "Going", "Gone", "Went"],
          "answer": "Went"
        },
        {
          "sentence": "The new restaurant ______ last week.",
          "options": ["Open", "Opened", "Opening", "Start"],
          "answer": "Opened"
        }
      ]
    }
  ]
};
