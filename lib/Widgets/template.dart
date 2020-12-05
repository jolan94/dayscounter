class CounterClass {
  String title;
  DateTime datePicked;
  int fileIndex;

  CounterClass({
    this.title,
    this.datePicked,
    this.fileIndex,
  });

  CounterClass.fromMap(Map<String, dynamic> map) {
    this.title = map['title'];
    this.datePicked = DateTime.parse(map['datePicked']);
    this.fileIndex = map['fileIndex'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'datePicked': this.datePicked.toIso8601String(),
      'fileIndex': this.fileIndex,
    };
  }
}
