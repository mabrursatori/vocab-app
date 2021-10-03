import 'package:flutter/material.dart';
import 'package:vocab_app/model/vocab.dart';
import 'package:vocab_app/style/style.dart';

class WordWidget extends StatefulWidget {
  WordWidget(
      {Key? key,
      required this.char,
      required this.index,
      required this.vocabs,
      required this.deleteVocab,
      required this.editVocab})
      : super(key: key);

  final String char;
  final int index;
  final List<Vocab> vocabs;
  final Function(Vocab vocab) deleteVocab;
  final Function(Vocab vocab) editVocab;

  @override
  State<WordWidget> createState() => _WordWidgetState();
}

class _WordWidgetState extends State<WordWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.black, width: 1))),
            child: Text(
              widget.char,
              style:
                  poppins.copyWith(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          ExpansionPanelList(
            animationDuration: Duration(milliseconds: 500),
            dividerColor: Colors.grey,
            elevation: 1,
            children: widget.vocabs
                .map(
                  (e) => ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.english,
                                    style: poppins.copyWith(fontSize: 15),
                                  ),
                                  Text(
                                    e.indonesia,
                                    style: poppins.copyWith(
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey),
                                  )
                                ],
                              ),
                              Text(
                                e.type,
                                style: poppins.copyWith(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey),
                              )
                            ],
                          ),
                        );
                      },
                      isExpanded:
                          widget.vocabs[widget.vocabs.indexOf(e)].isExpanded,
                      body: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.englishExample,
                                    style: poppins.copyWith(fontSize: 15),
                                  ),
                                  Text(
                                    e.indoExample,
                                    style: poppins.copyWith(
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        widget.editVocab(e);
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.grey,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        widget.deleteVocab(e);
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.grey,
                                      ))
                                ],
                              )
                            ],
                          ))),
                )
                .toList(),
            expansionCallback: (int index, bool status) {
              setState(() {
                widget.vocabs[index].isExpanded =
                    !widget.vocabs[index].isExpanded;
              });
            },
          )
        ],
      ),
    );
  }
}
