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
                                        fontSize: cellIndex == 0 ? 14 : 12,
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
  
  List<int> _getVisiblePages() {
    List<int> pages = [];
    int total = widget.totalPages;
    int current = widget.currentPage;
    
    if (total <= 3) {
      // Show all pages if total is 3 or less
      for (int i = 1; i <= total; i++) {
        pages.add(i);
      }
    } else {
      // Show only 3 pages maximum to prevent overflow
      int start = current - 1;
      int end = current + 1;
      
      // Adjust window to stay within bounds
      if (start < 1) {
        start = 1;
        end = 3;
      }
      if (end > total) {
        end = total;
        start = total - 2;
      }
      
      // Add first page if not in range
      if (start > 1) {
        pages.add(1);
        if (start > 2) {
          pages.add(-1); // dots
        }
      }
      
      // Add visible pages (max 3)
      for (int i = start; i <= end; i++) {
        pages.add(i);
      }
      
      // Add last page if not in range
      if (end < total) {
        if (end < total - 1) {
          pages.add(-1); // dots
        }
        pages.add(total);
      }
    }
    
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    final pages = _getVisiblePages();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            // Prev Button
            _SimpleNavButton(
              label: 'Prev',
              enabled: widget.currentPage > 1,
              isPrev: true,
              onTap: () => widget.onPageChange?.call(widget.currentPage - 1),
            ),
            
            const SizedBox(width: 4),
            
            // Page Numbers
            ...pages.map((page) {
              if (page == -1) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    '...',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7280),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }
              
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: _SimplePageButton(
                  page: page,
                  active: page == widget.currentPage,
                  onTap: () => widget.onPageChange?.call(page),
                ),
              );
            }),
            
            const SizedBox(width: 4),
            
            // Next Button
            _SimpleNavButton(
              label: 'Next',
              enabled: widget.currentPage < widget.totalPages,
              isPrev: false,
              onTap: () => widget.onPageChange?.call(widget.currentPage + 1),
            ),
          ],
      ),
    );
  }
}

class _SimpleNavButton extends StatelessWidget {
  final String label;
  final bool enabled;
  final VoidCallback? onTap;
  final bool isPrev;

  const _SimpleNavButton({
    required this.label, 
    required this.enabled, 
    required this.isPrev,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isPrev) ...[
            Icon(
              Icons.chevron_left,
              size: 14,
              color: enabled ? const Color(0xFF3B82F6) : const Color(0xFFD1D5DB),
            ),
            const SizedBox(width: 2),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: enabled ? const Color(0xFF3B82F6) : const Color(0xFFD1D5DB),
              fontWeight: FontWeight.w500,
            ),
          ),
          if (!isPrev) ...[
            const SizedBox(width: 2),
            Icon(
              Icons.chevron_right,
              size: 14,
              color: enabled ? const Color(0xFF3B82F6) : const Color(0xFFD1D5DB),
            ),
          ],
        ],
      ),
    );
  }
}

class _SimplePageButton extends StatelessWidget {
  final int page;
  final bool active;
  final VoidCallback? onTap;

  const _SimplePageButton({required this.page, required this.active, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: active ? const Color(0xFF3B82F6) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Center(
          child: Text(
            '$page',
            style: TextStyle(
              fontSize: 12,
              color: active ? const Color(0xFF3B82F6) : const Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
