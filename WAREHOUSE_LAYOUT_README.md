# GCL Warehouse Mobile Layout

## Overview
This mobile warehouse layout design transforms the original rack diagram into an interactive, mobile-friendly interface for warehouse management.

## Features

### 1. Interactive Warehouse Layout
- **Mobile-Optimized Design**: The layout adapts to mobile screens with scrollable and zoomable interface
- **Color-Coded Racks**: Different rack types are color-coded for easy identification
  - 🟧 Orange: Rack Lines (permanent storage)
  - 🟪 Pink: Temporary Locations (temporary storage)
  - 🟩 Green: Quarantine Area
  - 🔵 Blue: Side Door Areas

### 2. Real-time Inventory Display
- **Item Counts**: Each rack displays current item count
- **Status Indicators**: Visual indicators for rack capacity levels
- **Interactive Elements**: Tap on any rack to view detailed information

### 3. Advanced Filtering Options
- **Search Functionality**: Search for specific racks or locations
- **Filter by Type**: Filter by rack lines, temporary locations, or quarantine areas
- **Location-based Filtering**: Filter by specific warehouse location (Marunda)

### 4. Mobile Navigation
- **Tab Integration**: Accessible via the Inventory page as a new "Layout" tab
- **Dedicated Page**: Available through the side navigation menu under "Rack"
- **Quick Access**: Direct navigation from inventory lists to physical layout

## How to Use

### Access the Layout
1. **Via Inventory Page**: Go to Inventory → Layout tab
2. **Via Navigation Menu**: Open side menu → Click "Rack"

### Navigate the Layout
1. **Zoom and Pan**: Use pinch-to-zoom and drag to navigate the layout
2. **Tap Racks**: Tap on any colored rack section to view details
3. **Filter Results**: Use the Options panel to filter by different criteria

### Understanding the Layout
- **Rack Lines**: Numbered permanent storage areas (1-10)
- **Temporary Locations**: Flexible storage areas by floor
- **Quarantine Area**: Special storage for quarantined items
- **Not In Rack**: Items not yet assigned to physical locations

## Technical Implementation

### Files Structure
```
lib/
├── pages/
│   ├── warehouse_layout_page.dart    # Main layout page
│   └── inventory_page.dart           # Updated with layout tab
├── widgets/
│   └── warehouse/
│       └── warehouse_widgets.dart    # Reusable warehouse components
└── assets/
    └── images/
        └── rack_gcl.png             # Original layout reference
```

### Key Components
- `WarehouseLayoutPage`: Main interactive layout interface
- `WarehouseRackCard`: Individual rack display component
- `WarehouseStatsCard`: Statistics display component
- `MiniRackWidget`: Compact rack representation

### Responsive Design
- **Mobile-First**: Designed specifically for mobile devices
- **Scalable Layout**: Adapts to different screen sizes
- **Touch-Friendly**: Large touch targets and intuitive gestures

## Integration with Existing System
- **Consistent UI**: Follows the same design patterns as other pages
- **Navigation Integration**: Seamlessly integrated with existing navigation
- **Data Consistency**: Uses the same data structure as inventory system

## Future Enhancements
- **Real-time Updates**: Integration with live inventory data
- **Barcode Scanning**: Quick rack identification via QR codes
- **Path Finding**: Optimal route planning within warehouse
- **Capacity Planning**: Visual capacity indicators and alerts
- **Offline Mode**: Local caching for offline warehouse operations

## Color Coding Reference
| Color | Type | Description |
|-------|------|-------------|
| 🟧 Orange | Rack Lines | Permanent storage racks (Rack Line 1-10) |
| 🟪 Pink | Temporary | Temporary storage locations by floor |
| 🟩 Green | Quarantine | Quarantine area for special items |
| 🔵 Blue | Side Areas | Side door and access areas |
| ⚪ Gray | Not Assigned | Items not yet placed in racks |

This mobile design maintains all functionality of the original layout while providing an intuitive, touch-friendly interface optimized for warehouse staff using mobile devices.
