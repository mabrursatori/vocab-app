import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:vocab_app/model/vocab.dart';
import 'package:vocab_app/style/style.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vocab_app/view/form_widget.dart';
import 'package:vocab_app/view/word_widget.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/widgets.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with WidgetsBindingObserver {
  late AppLifecycleState _lastLifecycleState;
  TextEditingController controller = TextEditingController();

  final List<Vocab> vocabs = [];

  final List<String> alphabet = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];

  List<String> types = [
    "Adjectiv",
    "Adverb",
    "Conjuction",
    "Interjection",
    "Noun",
    "Preposition",
    "Pronoun",
    "Verb"
  ];

  TextEditingController englishController = TextEditingController();
  TextEditingController indoController = TextEditingController();
  TextEditingController englishExampleController = TextEditingController();
  TextEditingController indoExampleController = TextEditingController();
  String? selectedType;

  late Box<dynamic> vocabsBox;
  bool isSearchFilled = false;
  List<Vocab> staticVocabs = [];
  bool isKeyboardVisible = false;
  String valueOfSearch = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    var keyboardVisibilityController = KeyboardVisibilityController();

    // Subscribe
    keyboardVisibilityController.onChange.listen((bool visible) {
      isKeyboardVisible = visible;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _lastLifecycleState = state;
      if (_lastLifecycleState == AppLifecycleState.paused ||
          _lastLifecycleState == AppLifecycleState.detached ||
          _lastLifecycleState == AppLifecycleState.inactive) {
        for (int i = 0; vocabsBox.length != 0; i++) {
          vocabsBox.deleteAt(0);
        }
        staticVocabs.forEach((e) {
          vocabsBox.add(e);
        });
      } else if (_lastLifecycleState == AppLifecycleState.resumed) {
        controller.text = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Hive.openBox("vocabs"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                //TODE: berhasil
                vocabsBox = Hive.box("vocabs");
                if (vocabsBox.length == 0) {
                  // vocabsBox.add(new Vocab(
                  //     english: "Eat",
                  //     indonesia: "Makan",
                  //     englishExample: "I'm eat rice",
                  //     indoExample: "Aku makan Nasi",
                  //     type: "verb"));
                  // vocabsBox.add(new Vocab(
                  //     english: "Chicken",
                  //     indonesia: "Ayam",
                  //     englishExample: "I'm eat rice",
                  //     indoExample: "Aku makan Nasi",
                  //     type: "verb"));
                }
                return ValueListenableBuilder(
                    valueListenable: vocabsBox.listenable(),
                    builder: (BuildContext context, Box<dynamic> value,
                        Widget? child) {
                      int total = vocabsBox.length;
                      vocabs.clear();
                      for (int i = 0; i < total; i++) {
                        vocabs.add(vocabsBox.getAt(i));
                      }

                      if (!isSearchFilled) {
                        if (staticVocabs.length == 0 ||
                            staticVocabs.length != vocabsBox.length) {
                          staticVocabs.clear();
                          for (int i = 0; i < total; i++) {
                            staticVocabs.add(vocabsBox.getAt(i));
                          }
                        }
                      }

                      return SafeArea(
                        child: Column(
                          children: [
                            Container(
                              decoration:
                                  BoxDecoration(color: Color(0xFFB5DEFF)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          (isSearchFilled)
                                              ? "Search Result is ${vocabs.length}"
                                              : "You Have ${vocabs.length} Vocabulary",
                                          style: poppins.copyWith(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: IconButton(
                                            onPressed: () {
                                              // controller.text = "";
                                              showAnimatedDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return SingleChildScrollView(
                                                      child: ListBody(
                                                    children: <Widget>[
                                                      Container(
                                                          height: (!isKeyboardVisible)
                                                              ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height
                                                              : null,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: FormWidget(
                                                            title: "Add New",
                                                            englishController:
                                                                englishController,
                                                            indoController:
                                                                indoController,
                                                            englishExampleController:
                                                                englishExampleController,
                                                            indoExampleController:
                                                                indoExampleController,
                                                            save: () {
                                                              //TODO: VALIDATION NOT EMPTY
                                                              bool isFilled =
                                                                  isValid();

                                                              if (!isFilled) {
                                                                showTopSnackBar(
                                                                  context,
                                                                  CustomSnackBar
                                                                      .error(
                                                                    message:
                                                                        "All Form Must Be Filled",
                                                                  ),
                                                                );
                                                              }

                                                              Vocab newVocab = new Vocab(
                                                                  english:
                                                                      englishController
                                                                          .text
                                                                          .capitalize(),
                                                                  indonesia:
                                                                      indoController
                                                                          .text
                                                                          .capitalize(),
                                                                  englishExample:
                                                                      englishExampleController
                                                                          .text
                                                                          .capitalize(),
                                                                  indoExample:
                                                                      indoExampleController
                                                                          .text
                                                                          .capitalize(),
                                                                  type: selectedType
                                                                      .toString());

                                                              //TODO: VALIDTION NOT SAME DATA
                                                              bool isExist =
                                                                  false;
                                                              vocabs
                                                                  .forEach((e) {
                                                                if (e ==
                                                                    newVocab) {
                                                                  //TODO: DATA IS SAME
                                                                  isExist =
                                                                      true;
                                                                  showTopSnackBar(
                                                                    context,
                                                                    CustomSnackBar
                                                                        .error(
                                                                      message:
                                                                          "Failed Save, Vocabulary Is Already Exist",
                                                                    ),
                                                                  );
                                                                }
                                                              });

                                                              //TODO: SAVE NEW DATA
                                                              if (isFilled &&
                                                                  !isExist) {
                                                                if (isSearchFilled) {
                                                                  staticVocabs.add(
                                                                      newVocab);

                                                                  if (newVocab
                                                                      .english
                                                                      .toLowerCase()
                                                                      .isSame(
                                                                          valueOfSearch)) {
                                                                    vocabsBox.add(
                                                                        newVocab);
                                                                  }
                                                                } else {
                                                                  vocabsBox.add(
                                                                      newVocab);
                                                                }

                                                                vocabs.clear();
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                refreshTextField();
                                                                showTopSnackBar(
                                                                  context,
                                                                  CustomSnackBar
                                                                      .success(
                                                                    message:
                                                                        "Good job, your new vocabulary is successfully saved",
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                            close: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              refreshTextField();
                                                            },
                                                            selectedType:
                                                                selectedType,
                                                            types: types,
                                                            changeType:
                                                                changeType,
                                                          )),
                                                    ],
                                                  ));
                                                },
                                                animationType:
                                                    DialogTransitionType.scale,
                                                curve: Curves.fastOutSlowIn,
                                                duration: Duration(seconds: 1),
                                              );
                                            },
                                            icon: Icon(Icons.add),
                                            color: Colors.blue,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 50,
                                      child: TextField(
                                        controller: controller,
                                        onChanged: (String value) {
                                          valueOfSearch = value.trim();
                                          if (value.trim() != "") {
                                            isSearchFilled = true;
                                            for (int i = 0;
                                                vocabsBox.length != 0;
                                                i++) {
                                              vocabsBox.deleteAt(0);
                                            }
//vocabs.clear();
                                            //vocabsBox.clear();
                                            staticVocabs.forEach((e) {
                                              if (e.english
                                                  .toLowerCase()
                                                  .isSame(
                                                      value.toLowerCase())) {
                                                vocabsBox.add(e);
                                                //  vocabs.add(e);
                                              }
                                            });

                                            // vocabs.clear();
                                          } else {
                                            isSearchFilled = false;
                                            for (int i = 0;
                                                vocabsBox.length != 0;
                                                i++) {
                                              vocabsBox.deleteAt(0);
                                            }
                                            staticVocabs.forEach((e) {
                                              vocabsBox.add(e);
                                            });
                                            // vocabs.clear();
                                          }
                                        },
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Colors.white.withOpacity(0.3),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: Color(0xFFFFFFFF))),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: Color(0xFFFFFFFF))),
                                            hintText: "Search",
                                            hintStyle: poppins.copyWith(
                                                color: Colors.blue),
                                            labelText: "Search",
                                            labelStyle: poppins.copyWith(
                                                color: Colors.blue),
                                            suffixIcon: Icon(
                                              Icons.search,
                                              color: Colors.blue,
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: (vocabsBox.length > 0)
                                    ? ListView.builder(
                                        itemCount: alphabet.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          String alpha = alphabet[index];
                                          List<Vocab> selectedVocabs = vocabs
                                              .where(
                                                  (e) => e.english[0] == alpha)
                                              .toList();
                                          selectedVocabs.sort((a, b) =>
                                              a.english.compareTo(b.english));
                                          if (selectedVocabs.length != 0) {
                                            // TODO: if OK
                                            return WordWidget(
                                              char: alpha,
                                              index: index,
                                              vocabs: selectedVocabs,
                                              deleteVocab: (Vocab vocab) {
                                                showAnimatedDialog(
                                                  context: context,
                                                  barrierDismissible: true,
                                                  builder:
                                                      (BuildContext context) {
                                                    return SingleChildScrollView(
                                                        child: ListBody(
                                                      children: <Widget>[
                                                        Container(
                                                            height:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child: Center(
                                                                child: Card(
                                                              elevation: 5,
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            20),
                                                                height: 130,
                                                                color: Colors
                                                                    .white,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      "Are you sure to deleted this vocabulary ?",
                                                                      style: poppins.copyWith(
                                                                          fontSize:
                                                                              15),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(primary: Color(0XFFD57E7E)),
                                                                            onPressed: () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            child: Text("Cancel")),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(primary: Color(0XFFC6D57E)),
                                                                            onPressed: () {
                                                                              deleteVocab(vocab);
                                                                              if (isSearchFilled) {
                                                                                staticVocabs.removeAt(staticVocabs.indexOf(vocab));
                                                                              }
                                                                              Navigator.of(context).pop();
                                                                              showTopSnackBar(
                                                                                context,
                                                                                CustomSnackBar.success(
                                                                                  message: "Your vocabulary is successfully deleted",
                                                                                ),
                                                                              );
                                                                            },
                                                                            child: Text("Yes"))
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )))
                                                      ],
                                                    ));
                                                  },
                                                  animationType:
                                                      DialogTransitionType
                                                          .scale,
                                                  curve: Curves.fastOutSlowIn,
                                                  duration:
                                                      Duration(seconds: 1),
                                                );
                                              },
                                              editVocab: editVocab,
                                            );
                                          } else {
                                            return SizedBox();
                                          }
                                        })
                                    : Center(
                                        child: Text(
                                          (isSearchFilled)
                                              ? "Your search result is empty"
                                              : "Your vocabulary is empty, let's create new vocabulary",
                                          style: poppins,
                                          textAlign: TextAlign.center,
                                        ),
                                      ))
                          ],
                        ),
                      );
                    });
              }
            } else {
              return Center(
                  child: SpinKitSquareCircle(
                color: Colors.blue,
                size: 50.0,
              ));
            }
          }),
    );
  }

  void deleteVocab(Vocab vocab) {
    vocabsBox.deleteAt(vocabs.indexOf(vocab));
    vocabs.remove(vocab);
  }

  void changeType(String? type) {
    selectedType = type;
  }

  bool isValid() {
    return englishController.text.isEmpty
        ? false
        : indoController.text.isEmpty
            ? false
            : englishExampleController.text.isEmpty
                ? false
                : indoExampleController.text.isEmpty
                    ? false
                    : (selectedType ?? "").isEmpty
                        ? false
                        : true;
  }

  void refreshTextField() {
    englishController.text = "";
    indoController.text = "";
    englishExampleController.text = "";
    indoExampleController.text = "";
    selectedType = null;
  }

  void editVocab(Vocab vocab) {
    Vocab oldVocab = vocabs[vocabs.indexOf(vocab)];
    englishController.text = oldVocab.english;
    indoController.text = oldVocab.indonesia;
    englishExampleController.text = oldVocab.englishExample;
    indoExampleController.text = oldVocab.indoExample;
    selectedType = oldVocab.type;
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
            child: ListBody(
          children: <Widget>[
            Container(
                height: (!isKeyboardVisible)
                    ? MediaQuery.of(context).size.height
                    : null,
                width: MediaQuery.of(context).size.width,
                child: FormWidget(
                  title: "Edit",
                  englishController: englishController,
                  indoController: indoController,
                  englishExampleController: englishExampleController,
                  indoExampleController: indoExampleController,
                  save: () {
                    //TODO: VALIDATION NOT EMPTY
                    bool isFilled = isValid();

                    if (!isFilled) {
                      showTopSnackBar(
                        context,
                        CustomSnackBar.error(
                          message: "All Form Must Be Filled",
                        ),
                      );
                    }

                    Vocab newVocab = new Vocab(
                        english: englishController.text.capitalize(),
                        indonesia: indoController.text.capitalize(),
                        englishExample:
                            englishExampleController.text.capitalize(),
                        indoExample: indoExampleController.text.capitalize(),
                        type: selectedType.toString());

                    //TODO: SAVE NEW DATA
                    if (isFilled) {
                      vocabsBox.putAt(vocabs.indexOf(oldVocab), newVocab);
                      staticVocabs[staticVocabs.indexOf(oldVocab)] = newVocab;
                      vocabs.clear();
                      Navigator.of(context).pop();
                      refreshTextField();
                      showTopSnackBar(
                        context,
                        CustomSnackBar.success(
                          message:
                              "Good job, your vocabulary is successfully updated",
                        ),
                      );
                    }
                  },
                  close: () {
                    Navigator.of(context).pop();
                    refreshTextField();
                  },
                  selectedType: selectedType,
                  types: types,
                  changeType: changeType,
                )),
          ],
        ));
      },
      animationType: DialogTransitionType.scale,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (this != "") {
      String str = this.toLowerCase().trim();
      return "${str[0].toUpperCase()}${str.substring(1)}";
    }
    return "";
  }

  bool isSame(String other) {
    bool isSame = false;
    if (this.length < other.length) return false;
    for (int i = 0; i < other.length; i++) {
      isSame = this[i] == other[i];
      if (!isSame) {
        return isSame;
      }
    }
    return isSame;
  }
}
