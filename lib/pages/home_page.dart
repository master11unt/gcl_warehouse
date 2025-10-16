import 'package:flutter/material.dart';
import 'package:gcl_warehouse/pages/index.dart';
import 'package:gcl_warehouse/pages/inventory_page.dart';
// import 'package:gcl_warehouse/widgets/stuffing/stuffing_table.dart';
import '../widgets/home/index.dart';

class HomeGCLPage extends StatefulWidget {
  @override
  _HomeGCLPageState createState() => _HomeGCLPageState();
}

class _HomeGCLPageState extends State<HomeGCLPage> {

  void _handleMenuTap(String route) {
    switch (route) {
      case '/list_cargo_in':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InventoryPage(),
          ),
        );
        break;
      // case '/inventory':
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => InventoryPage(),
      //     ),
      //   );
      //   break;
      // case '/list_cargo_out':
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => InventoryPage(),
      //     ),
      //   );
      //   break;
      case '/stuffing':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StuffingPage(),
          ),
        );
        break;
      // case '/stuffing_result':
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => StuffingPage(),
      //     ),
      //   );
      //   break;
      case '/rack':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WarehouseLayoutPage(),
          ),
        );
        break;
      case '/report':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WarehouseReportPage(),
          ),
        );
        break;
      case '/user':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserPage(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CommonAppBar(),
      drawer: CustomDrawer(currentPage: "home"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WelcomeCard(),
                SizedBox(height: 16),
                
                MenuSection(onMenuTap: _handleMenuTap),
                SizedBox(height: 16),
                
                SummaryCards(),
                SizedBox(height: 8),
                
                CargoPieChart(),
                SizedBox(height: 16),
                
                StuffingCards(),
                SizedBox(height: 16),
                
                TodayStuffings(),
                SizedBox(height: 16),
                
                WarehouseStatusBarChart(),
                SizedBox(height: 16),
                
                WarehouseCapacity(),
                SizedBox(height: 16),
                
                GuideSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
