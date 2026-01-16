# Split PDF (Finder) - Makefile
# Usage: make <target>
# See 'make help' for available targets

# Repository info
REPO_OWNER := wilmoore
REPO_NAME := splitpdf
REPO_URL := https://github.com/$(REPO_OWNER)/$(REPO_NAME)
SITE_URL := https://$(REPO_OWNER).github.io/$(REPO_NAME)/

# Browser open command (auto-detect OS)
OPEN_CMD := $(shell \
	if [ "$$(uname)" = "Darwin" ]; then echo "open"; \
	elif [ -n "$$WSL_DISTRO_NAME" ]; then echo 'cmd.exe /c start ""'; \
	else echo "xdg-open"; fi)

# ─────────────────────────────────────────────────────────────
# Site targets
# ─────────────────────────────────────────────────────────────

.PHONY: site
site: ## Open the live landing page
	$(OPEN_CMD) "$(SITE_URL)"

.PHONY: site-dev
site-dev: ## Start site development server
	cd site && npm run dev

.PHONY: site-build
site-build: ## Build the site for production
	cd site && npm run build

.PHONY: site-preview
site-preview: ## Preview production build locally
	cd site && npm run preview

.PHONY: site-install
site-install: ## Install site dependencies
	cd site && npm install

# ─────────────────────────────────────────────────────────────
# GitHub targets
# ─────────────────────────────────────────────────────────────

.PHONY: repo
repo: ## Open GitHub repository
	$(OPEN_CMD) "$(REPO_URL)"

.PHONY: releases
releases: ## Open GitHub releases page
	$(OPEN_CMD) "$(REPO_URL)/releases"

.PHONY: issues
issues: ## Open GitHub issues
	$(OPEN_CMD) "$(REPO_URL)/issues"

.PHONY: actions
actions: ## Open GitHub Actions
	$(OPEN_CMD) "$(REPO_URL)/actions"

.PHONY: pages
pages: ## Open GitHub Pages settings
	$(OPEN_CMD) "$(REPO_URL)/settings/pages"

.PHONY: settings
settings: ## Open repository settings
	$(OPEN_CMD) "$(REPO_URL)/settings"

# ─────────────────────────────────────────────────────────────
# Xcode / App targets
# ─────────────────────────────────────────────────────────────

.PHONY: xcode
xcode: ## Open Xcode project
	open SplitPDF/SplitPDF.xcodeproj

.PHONY: xcode-gen
xcode-gen: ## Regenerate Xcode project from project.yml
	cd SplitPDF && xcodegen generate

.PHONY: build
build: ## Build the macOS app (Release)
	cd SplitPDF && xcodebuild -project SplitPDF.xcodeproj -scheme SplitPDF -configuration Release build

.PHONY: archive
archive: ## Archive the app for distribution
	./dist/build-release.sh

# ─────────────────────────────────────────────────────────────
# Utility targets
# ─────────────────────────────────────────────────────────────

.PHONY: clean
clean: ## Clean build artifacts
	rm -rf site/dist
	cd SplitPDF && xcodebuild clean 2>/dev/null || true

.PHONY: status
status: ## Show git status
	@git status -sb

.PHONY: log
log: ## Show recent commits
	@git log --oneline -10

# ─────────────────────────────────────────────────────────────
# Domain setup (when ready)
# ─────────────────────────────────────────────────────────────

.PHONY: domain-enable
domain-enable: ## Enable custom domain (after DNS setup)
	mv site/public/CNAME.disabled site/public/CNAME
	@echo "CNAME enabled. Commit and push to activate."

.PHONY: domain-disable
domain-disable: ## Disable custom domain
	mv site/public/CNAME site/public/CNAME.disabled
	@echo "CNAME disabled. Commit and push to deactivate."

# ─────────────────────────────────────────────────────────────
# Help
# ─────────────────────────────────────────────────────────────

.PHONY: help
help: ## Show this help message
	@echo "Usage: make <target>"
	@echo ""
	@echo "Site:"
	@awk 'BEGIN {FS = ":.*##"} /^site[a-zA-Z_-]*:.*##/ { printf "  %-18s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
	@echo ""
	@echo "GitHub:"
	@awk 'BEGIN {FS = ":.*##"} /^(repo|releases|issues|actions|pages|settings):.*##/ { printf "  %-18s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
	@echo ""
	@echo "App:"
	@awk 'BEGIN {FS = ":.*##"} /^(xcode|build|archive)[a-zA-Z_-]*:.*##/ { printf "  %-18s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
	@echo ""
	@echo "Utility:"
	@awk 'BEGIN {FS = ":.*##"} /^(clean|status|log|domain)[a-zA-Z_-]*:.*##/ { printf "  %-18s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help
