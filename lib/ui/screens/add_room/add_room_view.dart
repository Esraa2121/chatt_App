import 'package:chat/models/room_category_model.dart';
import 'package:chat/ui/screens/add_room/add_room_navigator.dart';
import 'package:chat/ui/screens/add_room/add_room_view_model.dart';
import 'package:chat/ui/screens/base.dart';
import 'package:flutter/material.dart';

class AddRoomView extends StatefulWidget {
  static String routeName = 'Add New Room';

  @override
  State<AddRoomView> createState() => _AddRoomViewState();
}

class _AddRoomViewState extends BaseView<AddRoomView, AddRoomViewModel>
    implements AddRoomNavigator {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  var title = TextEditingController();

  var description = TextEditingController();
  var categories = RoomCategory.getCategories();
  late RoomCategory selectedCategory;

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
    selectedCategory = categories.first;
  }

  @override
  AddRoomViewModel initViewModel() {
    return AddRoomViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage('assets/bg.png'), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Chat',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          iconTheme: const IconThemeData(
            color: Colors.white,
            size: 32,
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Card(
              elevation: 33,
              margin: const EdgeInsets.all(35),
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Create New Room',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Container(
                      padding: const EdgeInsets.all(30),
                      child: Image.asset(
                        'assets/group.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    TextFormField(
                      validator: (text) {
                        if (text!.trim() == '') {
                          return "Please Enter Room Title";
                        }
                        return null;
                      },
                      controller: title,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        color: Color.fromRGBO(36, 39, 43, 1.0),
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                      ),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Please Enter Room Title',
                        hintStyle: const TextStyle(
                            color: Color.fromRGBO(121, 121, 121, 1.0),
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                        focusColor: Colors.cyan,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        labelText: 'Title',
                        labelStyle: const TextStyle(
                            color: Color.fromRGBO(121, 121, 121, 1.0),
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: DropdownButton<RoomCategory>(
                        value: selectedCategory,
                        items: categories
                            .map((cat) => DropdownMenuItem<RoomCategory>(
                                value: cat,
                                child: Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(5),
                                        child: Image.asset(cat.image)),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      cat.name,
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                    TextFormField(
                      validator: (text) {
                        if (text!.trim() == '') {
                          return "Please Enter Room Description";
                        }
                        return null;
                      },
                      controller: description,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        color: Color.fromRGBO(36, 39, 43, 1.0),
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                      ),
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: 'Please Enter Room Description',
                        hintStyle: const TextStyle(
                            color: Color.fromRGBO(121, 121, 121, 1.0),
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                        focusColor: Colors.cyan,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        labelText: 'Description',
                        labelStyle: const TextStyle(
                            color: Color.fromRGBO(121, 121, 121, 1.0),
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.fromLTRB(70, 10, 70, 10))),
                      onPressed: () {
                        ValidateForm();
                      },
                      child: const Text('Create',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void ValidateForm() async {
    if (formkey.currentState!.validate()) {
      viewModel.CreateRoom(title.text, description.text, selectedCategory.id);
    }
  }

  @override
  void roomCreated() {
    Navigator.pop(context);
  }
}
