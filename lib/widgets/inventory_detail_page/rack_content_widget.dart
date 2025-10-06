import 'package:flutter/material.dart';

class RackContentWidget extends StatelessWidget {
  final String rackName;
  final String rackNumber;
  final double width;
  final double height;
  final Color bgColor;
  final Color textColor;
  final double fontSize;
  final bool isRackLine;
  final bool isTempLocation;
  final bool isDoor;
  final bool isQuarantine;
  final bool isLoading;
  const RackContentWidget({
    Key? key,
    required this.rackName,
    required this.rackNumber,
    required this.width,
    required this.height,
    required this.bgColor,
    required this.textColor,
    required this.fontSize,
    required this.isRackLine,
    required this.isTempLocation,
    required this.isDoor,
    required this.isQuarantine,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isDoor) {
      return Center(
        child: Container(
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
      return Container(
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
                ),
              ),
            ],
          ],
        ),
      );
    }
    // ...implement other cases (isTempLocation, isQuarantine, isLoading, default)
    return Container();
  }
}
