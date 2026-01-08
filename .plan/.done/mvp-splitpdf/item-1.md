# Item #1: Finder Integration

## Epic Details
E-001: Finder Integration epic. User authentication with Finder context menu integration for PDF operations. All primary actions originate from Finder context menus.

## Implementation Approach

For macOS Finder integration, we need:
1. A main macOS app (container app)
2. A Finder Sync Extension that adds context menu items for PDF files

### Architecture

```
SplitPDF/
├── SplitPDF/                    # Main app target
│   ├── SplitPDFApp.swift        # Main app entry point
│   ├── AppDelegate.swift        # App lifecycle
│   └── Info.plist               # App configuration
├── SplitPDFExtension/           # Finder Sync Extension target
│   ├── FinderSync.swift         # Finder extension implementation
│   └── Info.plist               # Extension configuration
└── SplitPDF.xcodeproj/          # Xcode project
```

### Key Components

1. **Finder Sync Extension**: Implements `FIFinderSync` to add "Split into Pages" menu item
2. **Main App**: Container app that hosts the extension
3. **Shared Code**: PDF splitting logic shared between targets

## Status
In Progress
