import 'package:flutter/material.dart';

class TicketTable extends StatelessWidget {
  final List<String> columns;
  final List<List<String>> rows;
  final List<double>? columnWidths;
  final bool isLoading;
  final String emptyMessage;
  // Pagination props
  final int currentPage; 
  final int totalPages;
  final int totalItems;
  final int pageSize;
  final ValueChanged<int>? onPageChange;
  final bool showPaginationBar;
  final Function(List<String>)? onRowTap;

  const TicketTable({
    Key? key,
    required this.columns,
    required this.rows,
    this.columnWidths,
    this.isLoading = false,
    this.emptyMessage = 'Showing Result',
    this.currentPage = 1,
    this.totalPages = 1,
    this.totalItems = 0,
    this.pageSize = 10,
    this.onPageChange,
    this.showPaginationBar = true,
    this.onRowTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerStyle = const TextStyle(
      color: Colors.white, 
      fontWeight: FontWeight.w600, 
      fontSize: 12
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Table Header
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF1F2937),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: columns.asMap().entries.map((entry) {
                          final index = entry.key;
                          final column = entry.value;
                          
                          return Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                              decoration: BoxDecoration(
                                border: index < columns.length - 1
                                    ? const Border(
                                        right: BorderSide(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                      )
                                    : null,
                              ),
                              child: Text(
                                column,
                                style: headerStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  
                  // Table Rows
                  if (isLoading)
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: const Center(child: CircularProgressIndicator()),
                    )
                  else if (rows.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        emptyMessage, 
                        style: const TextStyle(color: Color(0xFF6B7280), fontSize: 14)
                      ),
                    )
                  else
                    Column(
                      children: rows.asMap().entries.map((entry) {
                        final rowIndex = entry.key;
                        final rowData = entry.value;
                        final isLastRow = rowIndex == rows.length - 1;
                        
                        return GestureDetector(
                          onTap: () => onRowTap?.call(rowData),
                          child: Container(
                            decoration: BoxDecoration(
                              color: rowIndex % 2 == 0 ? Colors.white : const Color(0xFFF9FAFB),
                              border: isLastRow ? null : const Border(
                                bottom: BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              borderRadius: isLastRow ? const BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ) : null,
                            ),
                            child: Row(
                              children: columns.asMap().entries.map((cellEntry) {
                                final cellIndex = cellEntry.key;
                                final cellData = cellIndex < rowData.length ? rowData[cellIndex] : '';
                                
                                return Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                    decoration: BoxDecoration(
                                      border: cellIndex < columns.length - 1
                                          ? const Border(
                                              right: BorderSide(
                                                color: Colors.white,
                                                width: 1,
                                              ),
                                            )
                                          : null,
                                    ),
                                    child: Text(
                                      cellData,
                                      style: TextStyle(
                                        fontSize: cellIndex == 0 ? 14 : 12, // First column slightly larger
                                        fontWeight: cellIndex == 0 ? FontWeight.w700 : FontWeight.w400,
                                        color: cellIndex == 0 ? const Color(0xFF111827) : const Color(0xFF6B7280),
                                        height: 1.3,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.visible,
                                      softWrap: false,
                                      maxLines: 1,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          ),
        ),
        _buildBottomSection(),
      ],
    );
  }

  Widget _buildBottomSection() {
    return Column(
      children: [
        const SizedBox(height: 12),
        Center(
          child: Text(
            'Showing ${totalItems > 0 ? totalItems : rows.length} Result',
            style: const TextStyle(color: Color(0xFF6B7280), fontSize: 14),
          ),
        ),
        const SizedBox(height: 8),
        if (showPaginationBar)
          _PaginationBar(currentPage: currentPage, totalPages: totalPages, onPageChange: onPageChange),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _PaginationBar extends StatefulWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int>? onPageChange;

  const _PaginationBar({required this.currentPage, required this.totalPages, this.onPageChange});

  @override
  State<_PaginationBar> createState() => _PaginationBarState();
}

class _PaginationBarState extends State<_PaginationBar> {
  final ScrollController _controller = ScrollController();
  final Map<int, GlobalKey> _pageKeys = {};

  List<int> _visiblePages(int current, int total) {
    const window = 5;
    if (total <= window + 2) {
      return List<int>.generate(total, (i) => i + 1);
    }
    final start = (current - 2).clamp(2, total - window - 1);
    final end = (start + window).clamp(1, total - 1);
    final list = <int>[1, ...List<int>.generate(end - start + 1, (i) => start + i), total];
    return list;
  }

  @override
  void didUpdateWidget(covariant _PaginationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentPage != widget.currentPage) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToCurrent());
    }
  }

  void _scrollToCurrent() {
    final key = _pageKeys[widget.currentPage];
    final ctx = key?.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 250), alignment: 0.5, curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = _visiblePages(widget.currentPage, widget.totalPages);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SingleChildScrollView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        child: IntrinsicWidth(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Prev Button
              _NavButton(
                label: 'Prev',
                icon: Icons.arrow_back,
                enabled: widget.currentPage > 1,
                onTap: () => widget.onPageChange?.call(widget.currentPage - 1),
              ),
              
              const SizedBox(width: 12),
              
              // Page Numbers
              ...pages.asMap().entries.map((entry) {
                final i = entry.key;
                final page = entry.value;
                final widgets = <Widget>[
                  _PageChip(
                    key: _pageKeys.putIfAbsent(page, () => GlobalKey()),
                    page: page,
                    active: page == widget.currentPage,
                    onTap: () => widget.onPageChange?.call(page),
                  ),
                ];
                
                if (i < pages.length - 1) {
                  if (pages[i + 1] - page > 1) {
                    widgets.add(const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6), 
                      child: Text('...', style: TextStyle(color: Color(0xFF6B7280)))
                    ));
                  } else {
                    widgets.add(const SizedBox(width: 6));
                  }
                }
                
                return widgets;
              }).expand((widgets) => widgets),
              
              const SizedBox(width: 12),
              
              // Next Button
              _NavButton(
                label: 'Next',
                icon: Icons.arrow_forward,
                enabled: widget.currentPage < widget.totalPages,
                onTap: () => widget.onPageChange?.call(widget.currentPage + 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool enabled;
  final VoidCallback? onTap;

  const _NavButton({required this.label, required this.icon, required this.enabled, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label == 'Prev') ...[
              Icon(
                Icons.arrow_back_ios, 
                size: 12, 
                color: enabled ? Color(0xFF374151) : Color(0xFFD1D5DB)
              ),
              SizedBox(width: 4),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: enabled ? Color(0xFF374151) : Color(0xFFD1D5DB),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            if (label == 'Next') ...[
              SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_ios, 
                size: 12, 
                color: enabled ? Color(0xFF374151) : Color(0xFFD1D5DB)
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PageChip extends StatelessWidget {
  final int page;
  final bool active;
  final VoidCallback? onTap;

  const _PageChip({Key? key, required this.page, required this.active, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: active ? const Color(0xFF3B82F6) : const Color(0xFFE5E7EB),
              width: 2,
            ),
          ),
        ),
        child: Center(
          child: Text(
            '$page',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: active ? const Color(0xFF3B82F6) : const Color(0xFF6B7280),
            ),
          ),
        ),
      ),
    );
  }
}
