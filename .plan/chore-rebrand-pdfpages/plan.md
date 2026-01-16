# Rebrand: Split PDF (Finder) → PDF Pages (Finder)

## Overview

Full rebrand from `splitpdf` to `pdfpages` with new domain `pdfpages.app`.

## Changes Required

### 1. Landing Page (`site/`)
- [ ] `index.html` - title, meta tags, og:url
- [ ] `src/components/Hero.jsx` - app name, tagline
- [ ] `src/components/WhatItDoes.jsx` - description
- [ ] `src/components/HowItWorks.jsx` - step descriptions
- [ ] `src/components/Features.jsx` - feature descriptions
- [ ] `src/components/Install.jsx` - download URLs
- [ ] `src/components/Footer.jsx` - app name, version
- [ ] `public/CNAME.disabled` → `pdfpages.app`
- [ ] `DOMAIN-SETUP.md` - update domain references
- [ ] `vite.config.js` - update base URL to `/pdfpages/`

### 2. Xcode Project (`SplitPDF/`)
- [ ] `project.yml` - bundle IDs: `com.pdfpages.*`
- [ ] `SplitPDF/Info.plist` - display name, service name
- [ ] `SplitPDF/SplitPDFApp.swift` - any hardcoded names
- [ ] `SplitPDF/AppDelegate.swift` - any hardcoded names
- [ ] `SplitPDF/PreferencesView.swift` - window title
- [ ] `Shared/PDFSplitter.swift` - notification titles
- [ ] Regenerate Xcode project with xcodegen

### 3. Root Files
- [ ] `README.md` - all references
- [ ] `Makefile` - repo URLs, site URL
- [ ] `.plan/specs/` - update product name references

### 4. GitHub
- [ ] Rename repo: `splitpdf` → `pdfpages`
- [ ] Update remote URL in local git config
- [ ] Update GitHub Pages settings

### 5. Local Directory
- [ ] Rename `~/src/splitpdf` → `~/src/pdfpages`

## Implementation Order

1. Update all files in the repo (landing page, Xcode, docs)
2. Commit changes
3. Rename GitHub repo
4. Update git remote
5. Push to new repo
6. Rename local directory
7. Verify site deployment

## Rollback Plan

If issues arise, GitHub repo can be renamed back to `splitpdf`.
