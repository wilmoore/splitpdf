# 001. Use Services Menu Instead of Finder Sync Extension

Date: 2026-01-07

## Status

Accepted

## Context

The initial implementation used a Finder Sync Extension (`FIFinderSync`) to add a "Split into Pages" context menu item for PDF files in Finder. This approach required:

1. Monitoring directories to register for context menu callbacks
2. Setting `FIFinderSyncController.default().directoryURLs` to specify watched directories
3. To show the menu for PDFs anywhere, we monitored `/` (the entire filesystem)

This caused system instability - applications would fail to launch and queue up until the extension was disabled.

## Decision

Switch to macOS Services menu integration using `NSServices` in the app's Info.plist.

The Services approach:
- Registers the app as a service provider via `NSServices` plist entry
- Implements a service handler method in `AppDelegate` (`splitPDF:userData:error:`)
- Filters for PDF files using `NSSendFileTypes: ["com.adobe.pdf"]`
- Appears in right-click context menu under the service name

## Consequences

### Positive

- **No background monitoring** - service only runs when explicitly invoked
- **System stability** - no impact on other applications
- **Simpler architecture** - no separate extension target needed
- **Lower resource usage** - no persistent process watching directories

### Negative

- **Menu location** - appears at bottom of context menu or in Services submenu (varies by macOS version)
- **Discovery** - slightly less prominent than a top-level context menu item
- **Manual enablement** - users may need to enable in System Settings → Keyboard → Shortcuts → Services

## Alternatives Considered

### Finder Sync Extension (Original Approach)
- **Rejected because:** Caused system instability when monitoring all directories. The API is designed for sync apps (Dropbox, Google Drive) that need to badge files, not for simple context menu actions.

### Quick Action Extension
- **Rejected because:** Did not register properly with pluginkit; appears under "Quick Actions" submenu which is one level deeper.

### Automator Quick Action
- **Rejected because:** User explicitly requested a native solution without Automator.

## Related

- Planning: `.plan/.done/mvp-splitpdf/`
- Original PRD: `.plan/specs/spec-001-splitpdf-prd.md`
