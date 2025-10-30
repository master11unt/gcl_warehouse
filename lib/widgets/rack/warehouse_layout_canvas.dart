import 'package:flutter/material.dart';

class WarehouseLayoutCanvas extends StatelessWidget {
  const WarehouseLayoutCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _layoutCanvasHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: _layoutCanvasWidth,
          height: _layoutCanvasHeight,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
              ),
              ..._buildAccurateWarehouseLayout(context),
            ],
          ),
        ),
      ),
    );
  }

  static List<Widget> _buildAccurateWarehouseLayout(BuildContext context) {
    final List<Widget> sections = [];

    sections.add(
      _buildRackWidget(
        context,
        'Temporary Location Side Floor A\n9',
        left: 20,
        top: 120,
        width: 70,
        height: 300,
        color: Colors.blue[300]!,
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Rack Line 9\n0',
        left: 90,
        top: 60,
        width: 65,
        height: 300,
        color: const Color(0xFFFFC107),
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Temporary Location Side Floor B\n32',
        left: 20,
        top: 500,
        width: 70,
        height: 420,
        color: Colors.blue[300]!,
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Rack Line 3\n24',
        left: 90,
        top: 600,
        width: 65,
        height: 220,
        color: const Color(0xFFFFC107),
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Quarantine Area\n35',
        left: 90 ,
        top: 820,
        width: 65,
        height: 100,
        color: Colors.green[400]!,
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Rack Line 2\n88',
        left: 155,
        top: 870,
        width: 80,
        height: 50,
        color: const Color(0xFFFFC107),
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Temporary Location Front Floor\n270',
        left: 90,
        top: 920,
        width: 410,
        height: 60,
        color: Colors.pink[300]!,
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Temporary Location Floor 3\n174',
        left: 180,
        top: 550,
        width: 100,
        height: 200,
        color: Colors.pink[300]!,
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Rack Line 5\n8',
        left: 280,
        top: 550,
        width: 120,
        height: 50,
        color: const Color(0xFFFFC107),
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Temporary Location Floor 5\n16',
        left: 280,
        top: 600,
        width: 120,
        height: 50,
        color: Colors.pink[300]!,
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Rack Line 4\n14',
        left: 280,
        top: 650,
        width: 120,
        height: 50,
        color: const Color(0xFFFFC107),
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Temporary Location Floor 4\n489',
        left: 280,
        top: 700,
        width: 120,
        height: 50,
        color: Colors.pink[300]!,
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Temporary Location Floor 6\n39',
        left: 180,
        top: 360,
        width: 100,
        height: 130,
        color: Colors.pink[300]!,
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Rack Line 6\n7',
        left: 280,
        top: 430,
        width: 120,
        height: 60,
        color: const Color(0xFFFFC107),
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Rack Line 7\n0',
        left: 200,
        top: 210,
        width: 155,
        height: 50,
        color: const Color(0xFFFFC107),
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Rack Line 8\n2',
        left: 200,
        top: 110,
        width: 155 ,
        height: 50,
        color: const Color(0xFFFFC107),
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Temporary Location Floor 7\n0',
        left: 200,
        top: 160,
        width: 155,
        height: 50,
        color: Colors.pink[300]!,
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Temporary Location Floor 10\n35',
        left: 155,
        top: 60,
        width: 345,
        height: 50,
        color: Colors.pink[300]!,
        customBorder: const Border(
          left: BorderSide(color: Colors.grey, width: 2),
          right: BorderSide(color: Colors.grey, width: 2),
          bottom: BorderSide(color: Colors.grey, width: 2),
        ),
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Rack Line 10\n1',
        left: 155,
        top: 10,
        width: 200,
        height: 50,
        color: const Color(0xFFFFC107),
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        '',
        left: 355,
        top: 10,
        width: 145,
        height: 50,
        color: Colors.pink[300]!,
        customBorder: const Border(
          top: BorderSide(color: Colors.grey, width: 2),
          left: BorderSide(color: Colors.grey, width: 2),
          right: BorderSide(color: Colors.grey, width: 2),
        ),
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Loading Area\n0',
        left: 500,
        top: -130,
        width: 100,
        height: 140,
        color: Colors.orange[400]!,
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Back Door',
        left: 500,
        top: 10,
        width: 100,
        height: 100,
        color: Colors.grey[100]!,
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Rack Line 1\n30',
        left: 550,
        top: 210,
        width: 50,
        height: 440,
        color: const Color(0xFFFFC107),
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Front Door',
        left: 500,
        top: 920,
        width: 100,
        height: 60,
        color: Colors.grey[600]!,
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Pedestrian Door',
        left: 280,
        top: 900,
        width: 100,
        height: 20,
        color: Colors.grey[600]!,
      ),
    );

    sections.add(
      _buildRackWidget(
        context,
        'Side Door',
        left: 20,
        top: 420,
        width: 70,
        height: 80,
        color: Colors.grey[600]!,
      ),
    );

    return sections;
  }

  static Widget _buildRackWidget(
    BuildContext context,
    String label, {
    required double left,
    required double top,
    required double width,
    required double height,
    required Color color,
    Border? customBorder,
  }) {
    final parts = label.split('\n');
    final rackName = parts[0];
    final rackNumber = parts.length > 1 ? parts[1] : '';

    final isDoor = rackName.toLowerCase().contains('door');
    final isRackLine = rackName.toLowerCase().contains('rack line');
    final isTempLocation = rackName.toLowerCase().contains('temp');
    final isQuarantine = rackName.toLowerCase().contains('quarantine');
    final isLoading = rackName.toLowerCase().contains('loading');

    return Positioned(
      left: left,
      top: top + _layoutTopOffset,
      child: GestureDetector(
        onTap: () {
          _showRackDetails(context, label);
        },
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            border: customBorder ?? Border.all(
              color: isDoor ? Colors.black54 : Colors.grey[400]!,
              width: isDoor ? 1 : 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: _buildRackContent(rackName, rackNumber, width, height, color,
                isRackLine, isTempLocation, isDoor, isQuarantine, isLoading),
          ),
        ),
      ),
    );
  }

  static Widget _buildRackContent(
      String rackName,
      String rackNumber,
      double width,
      double height,
      Color bgColor,
      bool isRackLine,
      bool isTempLocation,
      bool isDoor,
      bool isQuarantine,
      bool isLoading) {
    final textColor = _getTextColor(bgColor);
    final fontSize = _getFontSize(width, height);

    if (isDoor) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(height < 30 ? 1 : 2),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              rackName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                shadows: textColor == Colors.white
                    ? [
                        Shadow(
                          offset: const Offset(1, 1),
                          blurRadius: 3,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ]
                    : [
                        Shadow(
                          offset: const Offset(1, 1),
                          blurRadius: 2,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ],
              ),
            ),
          ),
        ),
      );
    }

    if (isRackLine) {
      return Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (height > 40) ...[
              Flexible(
                child: Text(
                  rackName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    shadows: textColor == Colors.white
                        ? [
                            Shadow(
                              offset: const Offset(1, 1),
                              blurRadius: 2,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ]
                        : null,
                  ),
                  maxLines: 2,
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 2),
            ],
            if (rackNumber.isNotEmpty)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                      color: Colors.black.withOpacity(0.2), width: 1),
                ),
                child: Text(
                  rackNumber,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize + 1,
                  ),
                ),
              ),
          ],
        ),
      );
    }

    if (isTempLocation || isQuarantine || isLoading) {
      return Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                rackName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                  shadows: textColor == Colors.white
                      ? [
                          Shadow(
                            offset: const Offset(1, 1),
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ]
                      : null,
                ),
                maxLines: height > 80 ? 4 : 3,
                // overflow: TextOverflow.ellipsis,
              ),
            ),
            if (rackNumber.isNotEmpty) ...[
              const SizedBox(height: 3),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: bgColor.withOpacity(0.7), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Text(
                  rackNumber,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize + 1,
                  ),
                ),
              ),
            ],
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              rackName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                shadows: textColor == Colors.white
                    ? [
                        Shadow(
                          offset: const Offset(1, 1),
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ]
                    : null,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (rackNumber.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              rackNumber,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize + 1,
                shadows: textColor == Colors.white
                    ? [
                        Shadow(
                          offset: const Offset(1, 1),
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ]
                    : null,
              ),
            ),
          ],
        ],
      ),
    );
  }

  static Color _getTextColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    if (luminance > 0.6) return Colors.black87;
    if (luminance > 0.4) return Colors.black87;
    return Colors.white;
  }

  static double _getFontSize(double width, double height) {
    final minDimension = width < height ? width : height;
    final area = width * height;

    if (minDimension < 30) return 7;
    if (minDimension < 50) return 8;
    if (minDimension < 70) return 9;
    if (minDimension < 90) return 10;
    if (minDimension < 120) return 11;
    if (minDimension < 150) return 12;

    if (area > 20000) return 14;
    if (area > 15000) return 13;

    return 12;
  }

  static void _showRackDetails(BuildContext context, String label) {
    final parts = label.split('\n');
    final rackName = parts[0];
    final rackNumber = parts.length > 1 ? parts[1] : '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Rack Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Location: $rackName'),
              if (rackNumber.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text('Items: $rackNumber'),
              ],
              const SizedBox(height: 8),
              const Text('Status: Available'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('View Details'),
            ),
          ],
        );
      },
    );
  }

  static const double layoutCanvasWidth = 620;
  static const double layoutCanvasHeight = 1200;
  static const double _layoutTopOffset = 150;

  static const double _layoutCanvasWidth = layoutCanvasWidth;
  static const double _layoutCanvasHeight = layoutCanvasHeight;
}
