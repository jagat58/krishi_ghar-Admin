import 'package:flutter/material.dart';
import 'package:krishak_admin/Pages/CustomerDetails/CustomerDetail.dart';
import 'package:krishak_admin/Pages/Orders_details_screen.dart';
import 'package:krishak_admin/Pages/ProduxtPage.dart/ProductPage.dart';
import 'package:krishak_admin/Pages/Transactions/Transcation.dart';

import '../weidgets/drore.dart';
import 'news/upload_news.dart';


class AdminHomepage extends StatefulWidget {
  @override
  _AdminHomepageState createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {

  

  @override
  Widget build(BuildContext context) {
    Color appBarColor =
        MediaQuery.of(context).size.width > 600 ? Colors.blue : Colors.black;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Admin Homepage',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: DrawerWidget(),
      body: Container(
        padding: EdgeInsets.all(9.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 20.0,
          children: <Widget>[
            _buildListItemContainer(context, 'Products', Icons.shopping_cart),
            _buildListItemContainer(context, 'Customer Detail', Icons.person),
            _buildListItemContainer(context, 'Orders details', Icons.list_alt),
            _buildListItemContainer(context, 'News', Icons.newspaper), // Corrected item name
            _buildListItemContainer(
                context, 'Sell request', Icons.question_answer),
            _buildListItemContainer(
                context, 'Transactions', Icons.compare_arrows),
          ],
        ),
      ),
    );
  }

  Widget _buildListItemContainer(
      BuildContext context, String text, IconData iconData) {
    return GestureDetector(
      onTap: () {
        _navigateToPage(context, text);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: Colors.white,
              size: 50.0,
            ),
            SizedBox(height: 8.0),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, String text) {
    switch (text) {
      case 'Products':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProductPage()),
        );
        break;
      case 'Customer Detail':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CustomerDetails()),
        );
        break;
      case 'Orders details':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => OrdersDetailScreen()),
        );
        break;
      case 'News':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => NewaUpdate()), // Corrected class name
        );
        break;

      case 'Transactions':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TransactionScreen()),
        );
        break;
      case 'Sell request':
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (_) => Salerequest()),
        // );
        break;

      case 'Home':
      case 'Profile':
      case 'Settings':
      case 'Notifications':
        // Do nothing for bottom navigation items
        break;
      default:
        break;
    }
  }
}


