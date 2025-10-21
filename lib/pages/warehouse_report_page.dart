import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/common/common_app_bar.dart';
import '../widgets/common/custom_drawer.dart';

class WarehouseReportPage extends StatefulWidget {
  @override
  _WarehouseReportPageState createState() => _WarehouseReportPageState();
}

class _WarehouseReportPageState extends State<WarehouseReportPage> {
  bool _showCenterContent = false;
  int _hoveredSectionIndex = 0;
  bool _isFilterExpanded = false;
  String _selectedOwner = 'all';
  String _selectedPeriode = 'all';

  // Filter options data
  final List<String> _ownerOptions = [
    'all',
    'GCL-JAKARTA',
    'GCL-BANDUNG',
    'GCL-CIKARANG',
    'OSLINE-JAKARTA',
    'OSLINE-BANDUNG',
    'BPLINE',
    'WINFAST',
    'HNS',
    'XUNLAITONG',
    'GAP LOGISTICS',
    'DANLIRIS',
    'SMAS LOGISTIC',
    'ULTRA PRIMA',
  ];

  final List<String> _periodeOptions = [
    'all',
    'today',
    'this-week',
    'this-month',
    'this-year',
    'yesterday',
    'last-week',
    'last-month',
    'last-year',
  ];

  Widget _buildSvgIcon({
    required String assetPath,
    Color? color,
    double size = 24,
    BoxFit fit = BoxFit.contain,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        assetPath,
        colorFilter:
            color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        fit: fit,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: CommonAppBar(),
      drawer: CustomDrawer(currentPage: "report"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderSection(),
                    const SizedBox(height: 20),

                    _buildTotalCargoSection(),
                    const SizedBox(height: 20),

                    _buildDetailQuantityCargo(),
                    const SizedBox(height: 20),

                    _buildDetailStatusCargo(),
                    const SizedBox(height: 20),

                    _buildValueCargo(),
                    const SizedBox(height: 20),

                    _buildCargoFlowChart(),
                    const SizedBox(height: 20),

                    _buildTopShipper(),
                    const SizedBox(height: 20),

                    _buildStuffingSection(),
                    const SizedBox(height: 20),

                    _buildTopDestination(),
                    const SizedBox(height: 20),

                    _buildDetailDestination(),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              _buildPerformanceSection(),
              const SizedBox(height: 20),

              _buildOptionsSection(),
              const SizedBox(height: 20),

              _buildRulesSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Row(
          children: [
            Container(
              width: 8,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Report Warehouse',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Note :',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'These statistics are generated based on user-inputted data and calculated using specific parameters.',
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Filter button
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isFilterExpanded = !_isFilterExpanded;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _buildSvgIcon(
                            assetPath: 'assets/icons/filter_outline.svg',
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Filter',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      _buildSvgIcon(
                        assetPath:
                            _isFilterExpanded
                                ? 'assets/icons/chevron_up.svg'
                                : 'assets/icons/arrow_down.svg',
                        color: Colors.white,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),

              if (_isFilterExpanded)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Divider line
                      Container(
                        height: 1,
                        margin: const EdgeInsets.only(bottom: 20),
                        color: const Color(0xFF6B7280),
                      ),

                      // Owner section
                      const Text(
                        'Owner',
                        style: TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),

                      SizedBox(
                        height: 50,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                _ownerOptions
                                    .map(
                                      (owner) => Padding(
                                        padding: const EdgeInsets.only(
                                          right: 8,
                                        ),
                                        child: _buildFilterChip(
                                          owner,
                                          _selectedOwner == owner,
                                          () => setState(
                                            () => _selectedOwner = owner,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Periode section
                      const Text(
                        'Periode',
                        style: TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),

                      SizedBox(
                        height: 50,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                _periodeOptions
                                    .map(
                                      (periode) => Padding(
                                        padding: const EdgeInsets.only(
                                          right: 8,
                                        ),
                                        child: _buildFilterChip(
                                          periode,
                                          _selectedPeriode == periode,
                                          () => setState(
                                            () => _selectedPeriode = periode,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTotalCargoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'Cargo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: _buildStatCardWithBackground('Total Cargo', '6410'),
            ),
            const SizedBox(width: 16),
            Expanded(child: _buildStatCardWithBackground('Damaged Cargo', '1')),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCardWithBackground(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailQuantityCargo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'Detail Quantity Cargo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double chartSize = constraints.maxWidth < 400 ? 140 : 200;
              double centerRadius = constraints.maxWidth < 400 ? 40 : 60;
              double radius = constraints.maxWidth < 400 ? 35 : 50;
              double spacing = constraints.maxWidth < 400 ? 16 : 30;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: chartSize,
                    height: chartSize,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback: (
                                FlTouchEvent event,
                                pieTouchResponse,
                              ) {
                                if (pieTouchResponse != null &&
                                    pieTouchResponse.touchedSection != null) {
                                  setState(() {
                                    _showCenterContent = true;
                                    _hoveredSectionIndex =
                                        pieTouchResponse
                                            .touchedSection!
                                            .touchedSectionIndex;
                                  });
                                } else if (event is FlPointerExitEvent) {
                                  setState(() {
                                    _showCenterContent = false;
                                  });
                                }
                              },
                            ),
                            sections: [
                              PieChartSectionData(
                                value: 95.8,
                                color: const Color(0xFF1E3888),
                                title: '',
                                radius: radius,
                              ),
                              PieChartSectionData(
                                value: 4.1,
                                color: const Color(0xFFEC4899),
                                title: '',
                                radius: radius,
                              ),
                              PieChartSectionData(
                                value: 0.1,
                                color: const Color(0xFFFBBF24),
                                title: '',
                                radius: radius,
                              ),
                            ],
                            centerSpaceRadius: centerRadius,
                            sectionsSpace: 1,
                          ),
                        ),
                        if (_showCenterContent)
                          Builder(
                            builder: (context) {
                              final sectionData = _getSectionData(
                                _hoveredSectionIndex,
                              );
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0F172A),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      sectionData['title'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              2,
                                            ),
                                          ),
                                          child: _buildSvgIcon(
                                            assetPath: sectionData['iconPath'],
                                            color: Colors.white,
                                            size: 8,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          sectionData['value'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),

                  SizedBox(width: spacing),

                  // Legend
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLegendItemDetailed(
                          'Match',
                          '6061',
                          const Color(0xFF1E3888),
                        ),
                        const SizedBox(height: 16),
                        _buildLegendItemDetailed(
                          'Over',
                          '262',
                          const Color(0xFFEC4899),
                        ),
                        const SizedBox(height: 16),
                        _buildLegendItemDetailed(
                          'Short',
                          '0',
                          const Color(0xFFFBBF24),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Map<String, dynamic> _getSectionData(int index) {
    switch (index) {
      case 0:
        return {
          'title': 'Match',
          'value': '6.061',
          'iconPath': 'assets/icons/check.svg',
          'color': const Color(0xFF1E3888),
        };
      case 1:
        return {
          'title': 'Over',
          'value': '262',
          'iconPath': 'assets/icons/arrow_up.svg',
          'color': const Color(0xFFEC4899),
        };
      case 2:
        return {
          'title': 'Short',
          'value': '0',
          'iconPath': 'assets/icons/arrow_down.svg',
          'color': const Color(0xFFFBBF24),
        };
      default:
        return {
          'title': 'Match',
          'value': '6.061',
          'iconPath': 'assets/icons/check.svg',
          'color': const Color(0xFF1E3888),
        };
    }
  }

  Widget _buildLegendItemDetailed(String label, String value, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF374151),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF111827),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailStatusCargo() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'Detail Status Cargo',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Bar Chart
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1000,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.3),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value == 0)
                          return const Text(
                            '0',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF6B7280),
                            ),
                          );
                        if (value == 2000)
                          return const Text(
                            '2,000',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF6B7280),
                            ),
                          );
                        if (value == 4000)
                          return const Text(
                            '4,000',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF6B7280),
                            ),
                          );
                        if (value == 6000)
                          return const Text(
                            '6,000',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF6B7280),
                            ),
                          );
                        return const Text('');
                      },
                      reservedSize: 40,
                      interval: 2000,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const titles = [
                          '',
                          'Received',
                          'Stuffing',
                          'Delivered',
                          'Exited',
                          'Coloaded',
                          'Canceled',
                        ];
                        if (value.toInt() < titles.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Transform.rotate(
                              angle: -0.3,
                              child: Text(
                                titles[value.toInt()],
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: 394,
                        color: const Color(0xFF1E3888),
                        width: 25,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        toY: 184,
                        color: const Color(0xFFFBBF24),
                        width: 25,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(
                        toY: 5832,
                        color: const Color(0xFF10B981),
                        width: 25,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 4,
                    barRods: [
                      BarChartRodData(
                        toY: 0,
                        color: const Color(0xFFEC4899),
                        width: 25,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 5,
                    barRods: [
                      BarChartRodData(
                        toY: 0,
                        color: const Color(0xFF6B7280),
                        width: 25,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 6,
                    barRods: [
                      BarChartRodData(
                        toY: 0,
                        color: const Color(0xFFEF4444),
                        width: 25,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ],
                  ),
                ],
                maxY: 6000,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Legend - 3
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildStatusLegendWithValue(
                      'Received',
                      '394',
                      const Color(0xFF3B82F6),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatusLegendWithValue(
                      'Stuffing',
                      '184',
                      const Color(0xFFFBBF24),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildStatusLegendWithValue(
                      'Delivered',
                      '5832',
                      const Color(0xFF10B981),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatusLegendWithValue(
                      'Exited',
                      '0',
                      const Color(0xFFEC4899),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildStatusLegendWithValue(
                      'Coloaded',
                      '0',
                      const Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatusLegendWithValue(
                      'Canceled',
                      '0',
                      const Color(0xFFEF4444),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildValueCargo() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'Values',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            'Counted Document',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF374151),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '6410',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            'Incomplete Document',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF374151),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '6410',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            'Total Value Cargo',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF374151),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),

          // Table
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                // Header row
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFF6B7280),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Currency',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Value',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Text(
                          'USD',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF374151),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '2000',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF374151),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCargoFlowChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'Cargo Flow in a Year',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E3888),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Volume',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF1E3888),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Transaction',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF10B981),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Line Chart
          SizedBox(
            height: 250,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 2000,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.3),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value == 0)
                          return const Text(
                            '0',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF6B7280),
                            ),
                          );
                        if (value == 2000)
                          return const Text(
                            '2,000',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF6B7280),
                            ),
                          );
                        if (value == 4000)
                          return const Text(
                            '4,000',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF6B7280),
                            ),
                          );
                        if (value == 6000)
                          return const Text(
                            '6,000',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF6B7280),
                            ),
                          );
                        return const Text('');
                      },
                      reservedSize: 40,
                      interval: 2000,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 35,
                      getTitlesWidget: (value, meta) {
                        const months = [
                          '',
                          'Jan',
                          'Mar',
                          'May',
                          'Jul',
                          'Sep',
                          'Nov',
                        ];
                        if (value.toInt() < months.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Transform.rotate(
                              angle: -0.2,
                              child: Text(
                                months[value.toInt()],
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minY: 0,
                maxY: 6000,
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(1, 500), // January
                      FlSpot(2, 3800), // March
                      FlSpot(3, 3500), // May
                      FlSpot(4, 4200), // July
                      FlSpot(5, 3600), // September
                      FlSpot(6, 4000), // November
                    ],
                    isCurved: true,
                    color: const Color(0xFF1E3888),
                    barWidth: 3,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter:
                          (spot, percent, barData, index) => FlDotCirclePainter(
                            radius: 4,
                            color: const Color(0xFF1E3888),
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          ),
                    ),
                    belowBarData: BarAreaData(show: false),
                  ),
                  LineChartBarData(
                    spots: const [
                      FlSpot(1, 200), // January
                      FlSpot(2, 800), // March
                      FlSpot(3, 750), // May
                      FlSpot(4, 900), // July
                      FlSpot(5, 820), // September
                      FlSpot(6, 850), // November
                    ],
                    isCurved: true,
                    color: const Color(0xFF10B981),
                    barWidth: 3,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter:
                          (spot, percent, barData, index) => FlDotCirclePainter(
                            radius: 4,
                            color: const Color(0xFF10B981),
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          ),
                    ),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopShipper() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'Top Shipper',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: const Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Text(
                    'No',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E3888),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E3888),
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    'Total Booking',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E3888),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 180,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildShipperRowNew('1', 'GIVAUDAN INDONESIA, PT.', '639'),
                  _buildShipperRowNew('2', 'MANE INDONESIA, PT', '484'),
                  _buildShipperRowNew('3', 'LX PANTOS INDONESIA, PT', '382'),
                  _buildShipperRowNew('4', 'WINFASTSHIPPING', '196'),
                  _buildShipperRowNew('5', 'SAMSUNG SDS GLOBAL SCL', '189'),
                  _buildShipperRowNew('6', 'FIRMENICH AROMATICS', '175'),
                  _buildShipperRowNew('7', 'INTERNATIONAL FLAVORS', '165'),
                  _buildShipperRowNew('8', 'SYMRISE INDONESIA', '142'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Center(
            child: Column(
              children: [
                const Text(
                  'Total Shipper',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '694',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStuffingSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'Stuffing',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),

          Column(
            children: [
              // First row - Two cards
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildStuffingCardNew('Stuffing Plan', '387'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: _buildStuffingCardNew('Ongoing Stuffing Plan', '10'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Second row - One card centered
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildStuffingCardNew(
                      'Cleared Stuffing Plan',
                      '968',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(flex: 1, child: Container()),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStuffingCardNew(String title, String value) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF374151),
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopDestination() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'Most Destination',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),

          Container(
            height: 200,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDestinationItemNew('HO CHI MINH CITY'),
                  _buildDestinationItemNew('HAIPHONG'),
                  _buildDestinationItemNew('LAEM CHABANG'),
                  _buildDestinationItemNew('PORT KELANG'),
                  _buildDestinationItemNew('HONG KONG'),
                  _buildDestinationItemNew('SINGAPORE'),
                  _buildDestinationItemNew('MANILA'),
                  _buildDestinationItemNew('JAKARTA'),
                  _buildDestinationItemNew('SURABAYA'),
                  _buildDestinationItemNew('BANGKOK'),
                  _buildDestinationItemNew('KAOHSIUNG'),
                  _buildDestinationItemNew('BUSAN'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Total Destination
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E7EB)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(0, 4),
                  spreadRadius: 1,
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Total Destination',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '215',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailDestination() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'Detail Destination',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Bar Chart
          SizedBox(
            height: 300,
            child: BarChart(
              BarChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1000,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.3),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value == 0)
                          return const Text(
                            '0',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF6B7280),
                            ),
                          );
                        if (value == 1000)
                          return const Text(
                            '1,000',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF6B7280),
                            ),
                          );
                        if (value == 2000)
                          return const Text(
                            '2,000',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF6B7280),
                            ),
                          );
                        if (value == 3000)
                          return const Text(
                            '3,000',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF6B7280),
                            ),
                          );
                        return const Text('');
                      },
                      reservedSize: 40,
                      interval: 1000,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: (value, meta) {
                        const destinations = [
                          '',
                          'TOKYO',
                          'FLORIDA',
                          'AQABA',
                          'PUERTO CORTES',
                        ];
                        if (value.toInt() < destinations.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Transform.rotate(
                              angle: -0.3,
                              child: Text(
                                destinations[value.toInt()],
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: 3200,
                        color: const Color(0xFFFBBF24),
                        width: 8,
                      ),
                      BarChartRodData(
                        toY: 1800,
                        color: const Color(0xFF1E3888),
                        width: 8,
                      ),
                      BarChartRodData(
                        toY: 900,
                        color: const Color(0xFFFBBF24),
                        width: 8,
                      ),
                      BarChartRodData(
                        toY: 400,
                        color: const Color(0xFF1E3888),
                        width: 8,
                      ),
                      BarChartRodData(
                        toY: 1400,
                        color: const Color(0xFFFBBF24),
                        width: 8,
                      ),
                      BarChartRodData(
                        toY: 600,
                        color: const Color(0xFF1E3888),
                        width: 8,
                      ),
                      BarChartRodData(
                        toY: 300,
                        color: const Color(0xFFFBBF24),
                        width: 8,
                      ),
                      BarChartRodData(
                        toY: 800,
                        color: const Color(0xFF1E3888),
                        width: 8,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        toY: 600,
                        color: const Color(0xFFFBBF24),
                        width: 8,
                      ),
                      BarChartRodData(
                        toY: 400,
                        color: const Color(0xFF1E3888),
                        width: 8,
                      ),
                      BarChartRodData(
                        toY: 200,
                        color: const Color(0xFFFBBF24),
                        width: 8,
                      ),
                      BarChartRodData(
                        toY: 100,
                        color: const Color(0xFF1E3888),
                        width: 8,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(
                        toY: 600,
                        color: const Color(0xFFFBBF24),
                        width: 8,
                      ),
                      BarChartRodData(
                        toY: 300,
                        color: const Color(0xFF1E3888),
                        width: 8,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 4,
                    barRods: [
                      BarChartRodData(
                        toY: 200,
                        color: const Color(0xFFFBBF24),
                        width: 8,
                      ),
                    ],
                  ),
                ],
                maxY: 3500,
                groupsSpace: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceSection() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 280,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Index Performance',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Circular Progress
                LayoutBuilder(
                  builder: (context, constraints) {
                    double maxCircle = 180;
                    double minCircle = 100;
                    double circleSize = (constraints.maxWidth * 0.7).clamp(minCircle, maxCircle);
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: circleSize,
                          height: circleSize,
                          child: CircularProgressIndicator(
                            value: 1.0,
                            strokeWidth: 12,
                            backgroundColor: Colors.grey[200],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF10B981),
                            ),
                          ),
                        ),
                        const Column(
                          children: [
                            Text(
                              '100 %',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF10B981),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 16),
                const Text(
                  'Excellent',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF10B981),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 16),

        // Capacity Card
        Expanded(
          child: Container(
            height: 280,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 6,
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Capacity',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151),
                    ),
                  ),
                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                        width: 2,
                      ),
                    ),
                    child: const Text(
                      '59.378036%',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'GCLMarunda',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Capacity Info
                  const Text(
                    'Capacity',
                    style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
                  ),
                  const Text(
                    '1484.4509',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3888),
                    ),
                  ),
                  const Text(
                    'cbm',
                    style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Max Capacity',
                    style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
                  ),
                  const Text(
                    '2500',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF374151),
                    ),
                  ),
                  const Text(
                    'cbm',
                    style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionsSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Option Card
        Expanded(
          child: Container(
            height: 320,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 6,
                ),
              ],
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Option',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 16),

        // Download Card
        Expanded(
          child: Container(
            height: 320,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Download',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildDownloadButton('Cargo In\nData'),
                        const SizedBox(height: 10),
                        _buildDownloadButton('Stock\nInventory\nData'),
                        const SizedBox(height: 10),
                        _buildDownloadButton('Cargo Out\nData'),
                        const SizedBox(height: 10),
                        _buildDownloadButton('Stuffing\nResult Data'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRulesSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rules',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Based On : GTW/SOP/JKT/122331',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadButton(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF374151),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: const Color(0xFF6B7280),
              borderRadius: BorderRadius.circular(4),
            ),
            child: _buildSvgIcon(
              assetPath: 'assets/icons/download.svg',
              color: Colors.white,
              size: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusLegendWithValue(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShipperRowNew(String no, String name, String total) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(
              no,
              style: const TextStyle(fontSize: 12, color: Color(0xFF374151)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: const TextStyle(fontSize: 12, color: Color(0xFF374151)),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              total,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF374151),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationItemNew(String destination) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        destination,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF1E3888),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildFilterChip(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.white,
            width: 1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? const Color(0xFF374151) : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}