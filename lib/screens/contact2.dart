
import 'package:contacts2/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:contacts2/provider/auth_provider.dart';
import 'package:provider/provider.dart';



class Contact {
  String name;
  String contact;
  Contact({required this.name, required this.contact});
}
class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  List<Contact> contacts = List.empty(growable: true);

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("FlutterPhone Auth"),
        actions: [
          IconButton(
            onPressed: () {
              ap.userSignOut().then(
                    (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomeScreen(),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              key: const ValueKey('Name'),
              controller: nameController,
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Color(0xFF6F35A5),
                  ),
                  hintText: 'Contact Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(29),
                      ))),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: contactController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.phone_in_talk_rounded,
                    color: Color(0xFF6F35A5),
                  ),
                  hintText: 'Contact Number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(29),
                      ))),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      //
                      String name = nameController.text.trim();
                      String contact = contactController.text.trim();
                      if (name.isNotEmpty && contact.isNotEmpty) {
                        setState(() {
                          nameController.text = '';
                          contactController.text = '';
                          contacts.add(Contact(name: name, contact: contact));
                        });
                      }
                      //
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), // adjust the padding as desired
                      minimumSize: const Size(100, 48), // adjust the minimum size as desired
                    ),
                    child: const Text('Save')),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      //
                      String name = nameController.text.trim();
                      String contact = contactController.text.trim();
                      if (name.isNotEmpty && contact.isNotEmpty) {
                        setState(() {
                          nameController.text = '';
                          contactController.text = '';
                          contacts[selectedIndex].name = name;
                          contacts[selectedIndex].contact = contact;
                          selectedIndex = -1;
                        });
                      }
                      //
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), // adjust the padding as desired
                      minimumSize: const Size(100, 48), // adjust the minimum size as desired
                    ),
                    child: const Text('Update')),
              ],
            ),
            const SizedBox(height: 20),
           // if (contacts.length<10)

            ListTile(
              leading:CircleAvatar(
                backgroundColor: Colors.purple,
                backgroundImage: NetworkImage(ap.userModel.profilePic),
                radius: 40,
              ),
             title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //const SizedBox(height: 30),
                    Text(  style: const TextStyle(fontWeight: FontWeight.bold),
                        ap.userModel.name),
                    Text(ap.userModel.phoneNumber,
                      textAlign: TextAlign.left,),
                    Text(ap.userModel.email),
                    Text(ap.userModel.bio),
                  ],

               ),
        ),
              Expanded(

                child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) => getRow(index),
                ),
              ),
            ]
        ),

      ),
    );

  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
          index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
          child: Text(
            contacts[index].name[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(contacts[index].contact),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    //
                    nameController.text = contacts[index].name;
                    contactController.text = contacts[index].contact;
                    setState(() {
                      selectedIndex = index;
                    });
                    //
                  },
                  child: const Icon(Icons.edit)),
              InkWell(
                  onTap: (() {
                    //
                    setState(() {
                      contacts.removeAt(index);
                    });
                    //
                  }),
                  child: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}