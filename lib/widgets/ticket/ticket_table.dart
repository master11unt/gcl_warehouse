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
    final headerStyle = const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14);

    // Use custom widths if provided, otherwise use intrinsic sizing
    if (columnWidths != null && columnWidths!.length == columns.length) {
      final double totalWidth = columnWidths!.fold(0, (sum, w) => sum + w);
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: totalWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Container(
                    width: totalWidth,
                    decoration: const BoxDecoration(color: Color(0xFF1F2937)),
                    child: Row(
                      children: [
                        for (int i = 0; i < columns.length; i++)
                          SizedBox(
                            width: columnWidths![i],
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: i < columns.length - 1
                                    ? const Border(right: BorderSide(color: Color(0xFF9CA3AF), width: 1))
                                    : null,
                              ),
                              child: Text(columns[i], style: headerStyle, textAlign: TextAlign.center),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (isLoading)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (rows.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(emptyMessage, style: const TextStyle(color: Color(0xFF6B7280), fontSize: 14)),
                    )
                  else ...[
                    for (int r = 0; r < rows.length; r++) ...[
                      if (r > 0) const Divider(height: 1, color: Color(0xFFE5E7EB)),
                      GestureDetector(
                        onTap: () => onRowTap?.call(rows[r]),
                        child: Container(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                            child: Row(
                              children: [
                                for (int i = 0; i < columns.length; i++)
                                  SizedBox(
                                    width: columnWidths![i],
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      alignment: Alignment.center,
                                      child: Text(
                                        i < rows[r].length ? rows[r][i] : '',
                                        style: const TextStyle(fontSize: 13, color: Color(0xFF111827)),
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
          _buildBottomSection(),
        ],
      );
    } else {
      // Fallback to intrinsic sizing
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Container(
                    decoration: const BoxDecoration(color: Color(0xFF1F2937)),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          for (int i = 0; i < columns.length; i++)
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: i < columns.length - 1
                                      ? const Border(right: BorderSide(color: Color(0xFF9CA3AF), width: 1))
                                      : null,
                                ),
                                child: Text(columns[i], style: headerStyle, textAlign: TextAlign.center),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (isLoading)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (rows.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(emptyMessage, style: const TextStyle(color: Color(0xFF6B7280), fontSize: 14)),
                    )
                  else ...[
                    for (int r = 0; r < rows.length; r++) ...[
                      if (r > 0) const Divider(height: 1, color: Color(0xFFE5E7EB)),
                      GestureDetector(
                        onTap: () => onRowTap?.call(rows[r]),
                        child: Container(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                            child: Row(
                              children: [
                                for (int i = 0; i < columns.length; i++)
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      alignment: Alignment.center,
                                      child: Text(
                                        i < rows[r].length ? rows[r][i] : '',
                                        style: const TextStyle(fontSize: 13, color: Color(0xFF111827)),
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
          _buildBottomSection(),
        ],
      );
    }
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
    return SingleChildScrollView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _NavButton(
            label: 'Prev',
            icon: Icons.arrow_back,
            enabled: widget.currentPage > 1,
            onTap: () => widget.onPageChange?.call(widget.currentPage - 1),
          ),
          const SizedBox(width: 8),
          ...[for (int i = 0; i < pages.length; i++) ...[
            _PageChip(
              key: _pageKeys.putIfAbsent(pages[i], () => GlobalKey()),
              page: pages[i],
              active: pages[i] == widget.currentPage,
              onTap: () => widget.onPageChange?.call(pages[i]),
            ),
            if (i < pages.length - 1)
              if (pages[i + 1] - pages[i] > 1)
                const Padding(padding: EdgeInsets.symmetric(horizontal: 6), child: Text('...', style: TextStyle(color: Color(0xFF6B7280))))
              else
                const SizedBox(width: 6),
          ]],
          const SizedBox(width: 8),
          _NavButton(
            label: 'Next',
            icon: Icons.arrow_forward,
            enabled: widget.currentPage < widget.totalPages,
            onTap: () => widget.onPageChange?.call(widget.currentPage + 1),
          ),
        ],
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
    final color = enabled ? const Color(0xFF6B7280) : const Color(0xFFCBD5E1);
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: color, fontSize: 14)),
        ],
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF2563EB) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          '$page',
          style: TextStyle(
            color: active ? Colors.white : const Color(0xFF1F2937),
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
