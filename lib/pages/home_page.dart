import 'package:flutter/material.dart';
import '../widgets/home/index.dart';

class HomeGCLPage extends StatefulWidget {
  @override
  _HomeGCLPageState createState() => _HomeGCLPageState();
}

class _HomeGCLPageState extends State<HomeGCLPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CommonAppBar(),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WelcomeCard(),
                SizedBox(height: 16),
                
                MenuSection(),
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
