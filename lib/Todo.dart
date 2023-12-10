import 'firebase.dart';

class Todo {
  late int prio;
  late String item;
  late String id;
  static List<Todo> tolist = [];
  Todo();
  Todo.firebase(this.prio, this.item, this.id);
  Todo.add(this.prio, this.item) {
    var f = FBase();
    addinfirebase(f);
  }

  void addinfirebase(FBase f) async => await f.addcard(this);
  static readcards() async {
    var f = FBase();

    await f.readcards();
  }

  Future delete(String id) async {
    var f = FBase();
    await f.deletecards(id);
  }
}
