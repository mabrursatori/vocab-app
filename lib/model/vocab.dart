import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'vocab.g.dart';

enum Type {
  pronoun,
  adjective,
  noun,
  conjunction,
  adverb,
  verb,
  interjection,
  preposition
}

@HiveType(typeId: 1)
// ignore: must_be_immutable
class Vocab extends Equatable {
  @HiveField(0)
  String english;
  @HiveField(1)
  String indonesia;
  @HiveField(2)
  String englishExample;
  @HiveField(3)
  String indoExample;
  @HiveField(4)
  String type;
  bool isExpanded = false;

  Vocab(
      {required this.english,
      required this.indonesia,
      required this.englishExample,
      required this.indoExample,
      required this.type});

  @override
  // TODO: implement props
  List<Object?> get props => [english, indonesia];
}
