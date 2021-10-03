import 'package:flutter/material.dart';
import 'package:vocab_app/style/style.dart';

// ignore: must_be_immutable
class FormWidget extends StatelessWidget {
  FormWidget(
      {Key? key,
      required this.englishController,
      required this.indoController,
      required this.englishExampleController,
      required this.indoExampleController,
      required this.save,
      required this.close,
      required this.types,
      required this.selectedType,
      required this.changeType,
      required this.title})
      : super(key: key) {
    type = selectedType;
  }

  final TextEditingController englishController;
  final TextEditingController indoController;
  final TextEditingController englishExampleController;
  final TextEditingController indoExampleController;
  final Function()? save;
  final Function()? close;
  final List<String> types;
  final String? selectedType;
  final Function(String? type) changeType;
  final String title;
  String? type;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          color: Colors.white,
          child: Container(
              height: 460,
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              color: Color(0xFFB5DEFF),
              child: Column(
                children: [
                  Container(
                      child: Text(
                    "${title.toString()} Vocabulary",
                    style: poppins.copyWith(
                        fontWeight: FontWeight.w900, color: Colors.blue),
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                      controller: englishController,
                      style: poppins.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.3),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 2, color: Color(0xFFFFFFFF))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 2, color: Color(0xFFFFFFFF))),
                        hintText: "English",
                        hintStyle: poppins.copyWith(color: Colors.blue),
                        labelText: "English",
                        labelStyle: poppins.copyWith(color: Colors.blue),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                      controller: indoController,
                      style: poppins.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.3),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 2, color: Color(0xFFFFFFFF))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 2, color: Color(0xFFFFFFFF))),
                        hintText: "Bahasa Indonesia",
                        hintStyle: poppins.copyWith(color: Colors.blue),
                        labelText: "Bahasa Indonesia",
                        labelStyle: poppins.copyWith(color: Colors.blue),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                      controller: englishExampleController,
                      style: poppins.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.3),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 2, color: Color(0xFFFFFFFF))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 2, color: Color(0xFFFFFFFF))),
                        hintText: "English Example",
                        hintStyle: poppins.copyWith(color: Colors.blue),
                        labelText: "English Example",
                        labelStyle: poppins.copyWith(color: Colors.blue),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                      controller: indoExampleController,
                      style: poppins.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.3),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 2, color: Color(0xFFFFFFFF))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 2, color: Color(0xFFFFFFFF))),
                        hintText: "Bahasa Indonesia Example",
                        hintStyle: poppins.copyWith(color: Colors.blue),
                        labelText: "Bahasa Indonesia Example",
                        labelStyle: poppins.copyWith(color: Colors.blue),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.3),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 2, color: Color(0xFFFFFFFF))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 2, color: Color(0xFFFFFFFF))),
                        ),
                        isEmpty: type == '',
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            style: poppins.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                            hint: Text(
                              "Choose Type",
                              style: poppins.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            value: type,
                            isDense: true,
                            onChanged: (String? newValue) {
                              type = newValue;
                              changeType(type);
                              state.didChange(newValue);
                            },
                            items: types.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0XFFD57E7E)),
                          onPressed: close,
                          child: Text("Cancel")),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0XFFC6D57E)),
                          onPressed: save,
                          child: Text("Save"))
                    ],
                  )
                ],
              ))),
    );
  }
}
