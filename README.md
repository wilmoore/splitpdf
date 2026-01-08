# SplitPDF

A macOS micro-utility that adds a Finder context menu action to split PDF files into individual pages.

## Features

- **Zero UI**: No main window required - operates entirely from Finder
- **Finder-native**: Right-click any PDF to see "Split into Pages"
- **Offline-first**: No network access, no uploads, no telemetry
- **Predictable output**: Files saved in a subfolder with consistent naming

## Usage

1. Right-click any PDF file in Finder
2. Select "Split into Pages"
3. Individual page PDFs appear in a subfolder named `{filename} Pages`

## Output Format

Given a source file named `Report.pdf`:
- Output folder: `Report Pages/`
- Page files: `Report_Page_1.pdf`, `Report_Page_2.pdf`, etc.

## Requirements

- macOS 13.0 or later
- Finder extension must be enabled in System Settings

## Building

Open `SplitPDF/SplitPDF.xcodeproj` in Xcode and build the project.

## Enabling the Extension

After installing:
1. Open System Settings
2. Go to Privacy & Security > Extensions > Finder Extensions
3. Enable "SplitPDF Extension"

## License

MIT
