# Split PDF (Finder)

Split PDFs into individual pages — directly from Finder.

![macOS 13+](https://img.shields.io/badge/macOS-13%2B-blue)
![Swift 5](https://img.shields.io/badge/Swift-5-orange)
![License MIT](https://img.shields.io/badge/License-MIT-green)
![No Tracking](https://img.shields.io/badge/Tracking-None-brightgreen)

---

## Features

- **Zero UI** — No windows, no menus. Works entirely from Finder.
- **Finder-native** — Right-click any PDF, select "Split into Pages."
- **Offline-first** — No network access. No uploads. No telemetry.
- **Predictable output** — Pages saved in a subfolder with consistent naming.

---

## Installation

1. Drag `Split PDF (Finder).app` to Applications
2. Double-click once to register the Finder service
3. Enable the service:
   - **System Settings → Keyboard → Keyboard Shortcuts → Services**
   - Find "Split into Pages" under Files and Folders
   - Check the box

---

## Quick Start

1. Right-click any PDF in Finder
2. Select **Split into Pages**
3. Done — individual pages appear in `{filename} Pages/`

**Example:**

```
Report.pdf
└── Report Pages/
    ├── Report_Page_1.pdf
    ├── Report_Page_2.pdf
    └── Report_Page_3.pdf
```

---

## Development

Requires Xcode 15+ and macOS 13+.

```bash
# Clone and build
git clone https://github.com/wilmoore/splitpdf.git
cd splitpdf/SplitPDF
open SplitPDF.xcodeproj
```

Build with ⌘B. The app uses XcodeGen for project generation.

---

## License

MIT
