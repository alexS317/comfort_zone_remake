import 'package:comfort_zone_remake/screens/add_affirmation.dart';
import 'package:comfort_zone_remake/screens/add_character.dart';
import 'package:comfort_zone_remake/screens/affirmation_gallery.dart';
import 'package:comfort_zone_remake/screens/character_gallery.dart';

import 'package:flutter/material.dart';

// Tabs to switch between character gallery and affirmation list
class GalleryTabsScreen extends StatefulWidget {
  const GalleryTabsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GalleryTabsScreenState();
}

class _GalleryTabsScreenState extends State<GalleryTabsScreen> {
  int _selectedTabIndex = 0;

  void _selectTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  // Open add screen to add a new entry
  void _openAddScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          if (_selectedTabIndex == 0) {
            return const AddCharacterScreen();
          } else {
            return const AddAffirmationScreen();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget activeTab = const CharacterGalleryScreen();
    var activeTabTitle = 'Character Gallery';

    if (_selectedTabIndex == 1) {
      activeTab = const AffirmationGalleryScreen();
      activeTabTitle = 'Affirmations';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeTabTitle),
      ),
      body: activeTab,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectTab,
        currentIndex: _selectedTabIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_none),
            label: 'Characters',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_format),
            label: 'Affirmations',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openAddScreen(context);
        },
        shape: const CircleBorder(
          side: BorderSide.none,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
