import 'package:flutter/material.dart';
import 'package:gcl_warehouse/widgets/common/svg_icon.dart';

class GuideSection extends StatelessWidget {
  const GuideSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgIcon(
              assetPath: 'assets/icons/guide.svg',
              color: Colors.black,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              "Guide",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: ExpansionTile(
              tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              childrenPadding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              title: Text(
                "Standard Operational Receiving Cargo",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF0F172A),
                ),
              ),
              trailing: SvgIcon(
                assetPath: 'assets/icons/arrow_down.svg',
                color: Color(0xFF6B7280),
                size: 10,
              ),
              children: [
              Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  color: Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: InteractiveViewer(
                    panEnabled: true,
                    scaleEnabled: true,
                    minScale: 0.5,
                    maxScale: 3.0,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_tree_outlined,
                            size: 48,
                            color: Color(0xFF2346A0),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Standard Operational Receiving Cargo",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF232F6A),
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            "Flowchart Diagram",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.open_in_full,
                      size: 16,
                      color: Color(0xFF2346A0),
                    ),
                    label: Text(
                      "View Full Diagram",
                      style: TextStyle(
                        color: Color(0xFF2346A0),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          ),
        ),
      ],
    );
  }
}
