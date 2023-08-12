import 'package:flutter/material.dart';

class DrawerCommon extends StatefulWidget {
  @override
  _DrawerCommonState createState() => _DrawerCommonState();
}

class _DrawerCommonState extends State<DrawerCommon> {
  int selectedTab = 1;
   final List<Map<String, dynamic>> menuItems = [
    {'title': 'Dashboard', 'icon': Icons.dashboard},
    {'title': 'R & D', 'icon': Icons.device_hub_outlined},
    {'title': 'Design Studio', 'icon': Icons.file_open},
    {'title': 'Communications', 'icon': Icons.chat_bubble},
    {'title': 'Designs', 'icon': Icons.file_present},
    {'title': 'Design Approval', 'icon': Icons.edit_document},
    {'title': 'Techpacks', 'icon': Icons.insert_drive_file_rounded},
    {'title': 'Compliances', 'icon': Icons.badge_rounded},
    {'title': 'Vendors', 'icon': Icons.contacts},
    {'title': 'Library', 'icon': Icons.book_sharp},
    {'title': 'Vendor Detail', 'icon': Icons.contact_phone_rounded},
    {'title': 'Mailings', 'icon': Icons.mail},
    {'title': 'Document Vaults', 'icon': Icons.document_scanner_rounded},
    {'title': 'Sample Development', 'icon': Icons.school},
    {'title': 'Masters', 'icon': Icons.grid_4x4},
    
  ];

 @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 16.0,
      child: Column(
        children: [
          DrawerHeader(
            
            child:  Text(
              'Hi, User',

              style: TextStyle(
                fontSize: 24,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                var item = menuItems[index];
                return ListTile(
                  title: Text(
                    item['title'],
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  leading: Icon(item['icon']),
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to the corresponding screen or perform other actions
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}