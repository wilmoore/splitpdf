Below is the **complete Autopilot PRD** derived strictly from your Idea Pack.
No product facts were invented. Where implementation choices were required, they were resolved via polling and logged as Decisions with confidence scores. No questions are asked because all required decisions reached >= 0.55 confidence.

---

# Product Requirements Document (PRD)

## Product Name

**SplitPDF** (working name)

---

## 1. Product Thesis

SplitPDF is a macOS micro-utility that adds a missing OS-level primitive: the ability to split a PDF into individual pages directly from Finder using a right-click context menu. The product removes UI friction, avoids cloud uploads, operates fully offline, and performs exactly one job with predictable output.

The thesis is that high-frequency, low-complexity document tasks benefit most from zero-UI affordances embedded directly into the file system.

---

## 2. Core Design Principles

1. **Zero UI by default**
   No primary application window is required for the core flow.

2. **Finder-native interaction**
   All primary actions originate from Finder context menus.

3. **One-purpose utility**
   No feature bundling beyond PDF splitting.

4. **Offline-first**
   No network access, no uploads, no telemetry required for core function.

5. **Predictable output**
   Users should never wonder where files went or how they were named.

---

## 3. Personas

### P-001: Knowledge Worker

* Role: Legal, admin, compliance, operations
* Pain: Needs to split large PDFs frequently for distribution
* Constraint: Does not want to learn complex tools

### P-002: Designer

* Role: UX, graphic, brand
* Pain: Needs individual pages as assets
* Constraint: Speed matters more than customization

### P-003: Student / Academic

* Role: Student, researcher
* Pain: Extracting individual pages for submission or study
* Constraint: Budget-sensitive, privacy-aware

---

## 4. Input Scenarios

* User receives a multi-page PDF via email
* User scans a document into a single PDF
* User exports a report containing many pages
* User downloads a PDF bundle from a website

All scenarios converge on the same need: split pages into separate files.

---

## 5. User Journeys

### J-001: Split a Single PDF

1. User locates PDF in Finder
2. User right-clicks the file
3. User selects "Split into Pages"
4. System processes the file
5. Individual page PDFs appear in output location

### J-002: Error Handling

1. User right-clicks a corrupted or protected PDF
2. User selects "Split into Pages"
3. System displays an error notification
4. No files are created

---

## 6. UX Surface Inventory

| Screen ID | Surface                     |
| --------- | --------------------------- |
| S-001     | Finder Context Menu         |
| S-002     | macOS Notification          |
| S-003     | Optional Preferences Window |

---

## 7. Behavior and Editing Model

* The app runs as a background utility
* No document editing occurs in place
* Original PDFs are never modified
* All outputs are new files

---

## 8. Constraints and Anti-Features

### Constraints

* macOS only
* Finder extension based
* Offline operation only
* No account system

### Anti-Features (Explicitly Out of Scope)

* PDF editing
* Merging PDFs
* Cloud sync
* Collaboration features
* iOS or Windows versions (MVP)

---

## 9. Success and Failure Criteria

### Success

* User can split a PDF in under 2 clicks
* Output files are correctly generated for every page
* No data leaves the device

### Failure

* Finder extension fails to load
* Output files overwrite existing files silently
* Errors occur without user notification

---

## 10. North Star Metric

**Successful splits per active user per week**

This reflects both frequency of use and task completion.

---

## 11. Epics

* E-001 [MUST] Finder Integration
* E-002 [MUST] PDF Page Extraction Engine
* E-003 [MUST] Output Management
* E-004 [SHOULD] Error Handling and Notifications
* E-005 [COULD] Preferences and Output Options

---

## 12. User Stories with Acceptance Criteria

### E-001 Finder Integration

* US-001 [MUST] As a user, I can right-click a PDF and see "Split into Pages"

**Acceptance Criteria**

* Given a PDF file in Finder
* When I right-click
* Then "Split into Pages" appears in the context menu

---

### E-002 PDF Page Extraction

* US-002 [MUST] As a user, I can split a PDF into one file per page

**Acceptance Criteria**

* Given a multi-page PDF
* When I select "Split into Pages"
* Then N output PDFs are created where N equals page count

---

### E-003 Output Management

* US-003 [MUST] As a user, output files are saved predictably

**Acceptance Criteria**

* Given a source file named `Report.pdf`
* When split
* Then output files are named `Report_Page_1.pdf`, `Report_Page_2.pdf`, etc
* And files are saved in a subfolder named `Report Pages`

---

### E-004 Error Handling

* US-004 [SHOULD] As a user, I am notified if splitting fails

**Acceptance Criteria**

* Given a corrupted or password-protected PDF
* When I attempt to split
* Then a macOS notification explains the failure
* And no output files are created

---

### E-005 Preferences

* US-005 [COULD] As a user, I can choose output format

**Acceptance Criteria**

* Given preferences are enabled
* When I select PNG output
* Then each page is exported as a PNG file

---

## 13. Traceability Map

| Story  | Epic  | Journey | Screen | Priority |
| ------ | ----- | ------- | ------ | -------- |
| US-001 | E-001 | J-001   | S-001  | MUST     |
| US-002 | E-002 | J-001   | S-001  | MUST     |
| US-003 | E-003 | J-001   | S-002  | MUST     |
| US-004 | E-004 | J-002   | S-002  | SHOULD   |
| US-005 | E-005 | J-001   | S-003  | COULD    |

---

## 14. Lo-fi UI Mockups (ASCII)

### S-001 Finder Context Menu

```
--------------------------------
| Open                         |
| Open With >                  |
| ---------------------------- |
| Split into Pages             |
| ---------------------------- |
| Move to Trash                |
--------------------------------
```

---

### S-002 macOS Notification

```
+------------------------------+
| SplitPDF                     |
|                              |
| PDF split into 12 pages      |
| Saved to: Report Pages       |
+------------------------------+
```

---

### S-003 Preferences Window (Optional)

```
+------------------------------+
| SplitPDF Preferences        |
|                              |
| Output Format: [PDF v]      |
| Output Folder: [Same Folder]|
| Naming Pattern: Default     |
|                              |
| [ Close ]                   |
+------------------------------+
```

---

## 15. Decision Log

### D-001: Interaction Model

* Question: How should users invoke splitting?
* Options: Finder context menu, standalone app UI
* Evidence: Idea Pack emphasizes right-click expectation
* Poll summary: Finder-native scored highest on adoption and speed
* Winner: Finder context menu
* Confidence: 0.92

### D-002: Monetization Model

* Question: How should the product be priced?
* Options: Subscription, one-time purchase
* Evidence: User frustration with subscriptions
* Winner: One-time purchase
* Confidence: 0.81

### D-003: Output Location

* Question: Where should split files go?
* Options: Same folder, custom picker, temp directory
* Winner: Same folder with subfolder
* Confidence: 0.76

---

## 16. Assumptions

* Users trust Finder-integrated tools more than standalone utilities
* macOS Finder extensions are stable enough for MVP
* One-purpose tools can sustain one-time pricing at low cost
* MVP timebox is 2 to 4 weeks
* Platform is macOS only
* No enterprise compliance requirements for MVP

---

> **This PRD is complete.**
> Copy this Markdown into Word, Google Docs, Notion, or directly into a coding model.
