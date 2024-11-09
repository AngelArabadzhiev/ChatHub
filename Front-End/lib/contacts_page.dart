import 'package:Chat_App/utils/brand_colors.dart';
import 'package:flutter/material.dart';
import 'package:Chat_App/utils/spaces.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 24, 40, 1.0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Contacts", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
            color: Colors.white,
          ),
        ],
      ),
      body: Column(
        children: [
          verticalSpacing(50),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SearchBar(
              backgroundColor: WidgetStateProperty.all(BrandColors.background),
              leading: Icon(Icons.search, color: Color.fromRGBO(173, 181, 189, 1.0)),
            ),
          ),
          verticalSpacing(25),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Contact ${index + 1}',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Details for contact ${index + 1}',
                    style: TextStyle(color: Colors.grey),
                  ),
                  leading: ClipRRect(borderRadius: BorderRadius.circular(50),child: Image.asset('assets/images/alien.png', )),
                  onTap: () {
                    // Handle tap on list item
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                tooltip: 'Open navigation menu',
                icon: const Icon(Icons.people),
                onPressed: () {},
              ),
              IconButton(
                tooltip: 'Search',
                icon: const Icon(Icons.message),
                onPressed: () {},
              ),
              IconButton(
                tooltip: 'Favorite',
                icon: const Icon(Icons.more_horiz_outlined),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );

  }
}
