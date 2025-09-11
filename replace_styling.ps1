# PowerShell script to replace styling patterns
$filePath = "c:\Users\Lenovo\Documents\projek\gcl_warehouse\lib\pages\warehouse_report_page.dart"
$content = Get-Content $filePath -Raw

# Replace pattern: color: Colors.white, + borderRadius + boxShadow with new pattern
$oldPattern = @"
      decoration: BoxDecoration\(
        color: Colors\.white,
        borderRadius: BorderRadius\.circular\(12\),
        boxShadow: \[
          BoxShadow\(
            color: Colors\.grey\.withOpacity\(0\.1\),
            spreadRadius: 1,
            blurRadius: [46],
            offset: Offset\(0, [23]\),
          \),
        \],
      \),
"@

$newPattern = @"
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
"@

$content = $content -replace $oldPattern, $newPattern
Set-Content $filePath $content
