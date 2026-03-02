# Additional Agent Instructions for ADO Visualization Workspace

**Last Updated:** February 10, 2026
**Purpose:** Guide agents on workspace structure, conventions, and best practices

---

## 🔴 CRITICAL: Read HANDOFF.md First

**Before starting any work, agents MUST read [README.md](../README.md) to understand:**

- Where the previous agent left off
- Current project status and completed sessions
- Outstanding tasks and known issues
- Project history and context
- Recent changes and decisions made

This ensures continuity and prevents duplicate work or conflicting changes.

---

## Workspace Overview

This workspace is dedicated to **Azure DevOps (ADO) visualization and reporting** for Microsoft's Xbox Commerce/XPC Planning team, specifically focusing on FY26Q4 Planning scenarios.

### Key Project Details

- **Organization:** microsoft
- **Project:** Xbox
- **Project ID:** 45ab0489-2e2f-4f17-989e-c9307056b278
- **API Version:** 7.0
- **Focus Area:** FY26Q4 Planning queries across TeamEng and Business Area dimensions

---

## Folder Structure

### 📁 Root Directory

- **`.env`** - Contains Azure DevOps Personal Access Token (PAT). **NEVER commit this file.**
- **`.gitignore`** - Configured to exclude `.env` and sensitive files
- **`.vscode/`** - VS Code workspace settings and MCP configuration
- **`.github/`** - GitHub workflow configurations and agent instructions

### 📁 `/Docs`

Contains all project documentation:

- **`HANDOFF.md`** - Comprehensive agent handoff document with project history, query inventory, and learnings
- **`QUERIES.md`** - Quick reference for all 39 queries (TeamEng, Biz Area, and FY26Q4 Planning root-level queries)
- **`AZURE_DEVOPS_API_REFERENCE.md`** - API endpoints, WIQL query examples, and analysis patterns
- **`AZURE_DEVOPS_MCP_SETUP.md`** - Setup guide for Model Context Protocol server
- **`SCENARIO_VISUALIZATION_QUERIES.md`** - Extended visualization examples (currently empty)

### 📁 `/Reports`

**Purpose:** Store generated reports, visualizations, and analysis outputs.

**Usage:**

- All generated reports (JSON, CSV, HTML, images) should be saved here
- Use descriptive filenames with timestamps: `report_name_YYYY-MM-DD.ext`
- Organize into subfolders if generating multiple report types

**Examples:**

```
Reports/
  ├── capacity_analysis_2026-02-10.json
  ├── carryover_report_2026-02-10.csv
  └── charts/
      └── team_distribution_2026-02-10.png
```

### 📁 `/scripts`

**Purpose:** Store JSON data files, query results, and automation scripts.

**Current Contents:**

- `shared_queries_structure.json` - Raw folder structure from ADO Queries API
- `teameng_queries_full.json` - Full query definitions for TeamEng queries

**Usage:**

- Place raw API responses here for reference
- Store reusable data transformation scripts
- Name scripts descriptively: `fetch_query_results.py`, `transform_scenarios.js`

---

## Query Structure Reference

### Total Queries: 39

1. **FY26Q4 Planning (Root Level) - 14 queries**
   - Status-based views: All, Ranked, Committed, Started, Completed
   - Risk views: At Risk, Delivery Risk, Deferred
   - Planning views: Needs AAA Stack Rank (multiple variants), Proposed, Pending Planning Decision
   - Folder ID: `ef884cb8-f929-4081-994d-ac97b1da3c49`

2. **TeamEng Queries - 14 queries**
   - Individual team queries (Mebaa, Shobhit, Kyle, Sagar, Gersh, James, Neha, Ankita, Oscar, Lauren, Roy, Sachin, Ramya)
   - Clean-up query
   - Folder ID: `9cc20222-b235-4b4f-987c-3134a237c410`

3. **Biz Area Queries - 11 queries**
   - Business area focused views (NextGen Transactions, Product Activation, Seller Growth, 3P Streaming, 3P Subscriptions, Marketplace, Mobile, etc.)
   - Folder ID: `27596132-b2ed-4c32-ba98-9ee86bc4a6b2`

**Common Query Pattern:**

- **Work Item Type:** Scenario
- **State Filter:** `State <> 'Cut'`
- **Tags:** Team/Area name + 'FY26Q4'
- **Sort Order:** Priority, CustomString03

---

## Authentication & API Access

### Environment Variables

```bash
source .env  # Loads AZURE_DEVOPS_PAT
```

### API Endpoint Structure

```bash
# Execute a query
curl -s -u ":$AZURE_DEVOPS_PAT" \
  "https://dev.azure.com/microsoft/45ab0489-2e2f-4f17-989e-c9307056b278/_apis/wit/wiql/${QUERY_ID}?api-version=7.0"

# Browse query folders (max depth=2)
curl -s -u ":$AZURE_DEVOPS_PAT" \
  "https://dev.azure.com/microsoft/45ab0489-2e2f-4f17-989e-c9307056b278/_apis/wit/queries/${FOLDER_ID}?api-version=7.0&\$depth=2"

# Get work items in batch
curl -s -u ":$AZURE_DEVOPS_PAT" \
  "https://dev.azure.com/microsoft/45ab0489-2e2f-4f17-989e-c9307056b278/_apis/wit/workitems?ids=${IDS}&api-version=7.0&\$expand=all"
```

### MCP Server Access

The workspace has Azure DevOps MCP tools configured. Activate them when needed:

- Work item management tools
- Query execution tools
- Branch and pull request management tools

---

## Agent Workflow Guidelines

### When Generating Reports

1. **Execute queries** using API or MCP tools
2. **Process data** using appropriate analysis patterns (see `AZURE_DEVOPS_API_REFERENCE.md`)
3. **Save outputs** to `/Reports` folder with descriptive names
4. **Update documentation** if creating new analysis patterns

### When Working with Queries

1. **Reference** `QUERIES.md` for quick query ID lookup
2. **Check** `HANDOFF.md` for context on query patterns and folder navigation
3. **Save raw API responses** to `/scripts` for reproducibility
4. **Test queries** with small result sets before full execution

### When Creating New Documentation

1. **Place documentation** in `/Docs` folder
2. **Use markdown format** for consistency
3. **Link to related docs** using relative paths
4. **Update this file** if adding new folder structures

### When Using Scripts

1. **Check** `/scripts` for existing data files before re-fetching
2. **Save new data files** to `/scripts` with descriptive names
3. **Include timestamps** in filenames for data versioning

### File Manipulation Best Practices

**🔴 CRITICAL: Use Python for File Operations**

The terminal can lock up or hang when using shell commands for file manipulation (especially with `printf`, `echo`, multi-line writes, or large file operations). **Always prefer Python for file operations.**

**✅ Preferred Approach - Use VS Code Edit Tools:**

- **`replace_string_in_file`** - Edit existing files
- **`multi_replace_string_in_file`** - Multiple edits efficiently

**✅ Alternative - Use Python in Terminal:**

```python
# Create/write files
python3 -c "
with open('file.txt', 'w') as f:
    f.write('content here')
"

# Append to files
python3 -c "
with open('file.txt', 'a') as f:
    f.write('more content\n')
"

# Read and transform
python3 -c "
import json
data = json.load(open('input.json'))
# process data
json.dump(data, open('output.json', 'w'), indent=2)
"
```

**❌ Avoid - Shell Commands:**

```bash
# These can cause terminal lockups
printf '%s\n' 'line1' 'line2' > file.txt
echo "content" >> file.txt
cat <<EOF > file.txt  # Especially heredocs
```

**When to Use Shell Commands:**

- Simple operations: `mkdir`, `cd`, `ls`, `mv`, `rm`
- Package management: `pip install`, `npm install`
- Git operations: `git add`, `git commit`, `git push`
- Running executables: `python3 script.py`, `pytest`

---

## Key Findings & Learnings

### API Limitations

- **Query folder depth:** Limited to `$depth=2` (max). Must navigate iteratively for deep structures.
- **Query execution:** Two-step process: (1) Execute query for IDs, (2) Fetch work item details
- **Rate limiting:** Be mindful of API call volume for large datasets

### Data Patterns

- **Cost estimation:** 0.25 = 1 quarter of effort in custom fields
- **Carryover identification:** Items tagged with both FY26Q3 and FY26Q4
- **Tag conventions:** Team/Area name + Quarter (e.g., "TeamSagar" + "FY26Q4")

### Common Analysis Types

See `AZURE_DEVOPS_API_REFERENCE.md` for detailed WIQL queries:

1. Capacity Distribution Analysis
2. Quarter-to-Quarter Carryover Analysis
3. Slip Reason Analysis
4. Cost Estimate vs Actual Analysis
5. Investment Category Distribution
6. Funding Status Overview

---

## File Organization Best Practices

### Naming Conventions

- **Reports:** `{type}_{description}_YYYY-MM-DD.{ext}`
- **Scripts:** `{verb}_{object}_{description}.{ext}`
- **Data files:** `{source}_{type}_{timestamp}.json`

### Version Control

- **Always add** documentation updates to git
- **Never commit** `.env` or files containing PATs/secrets
- **Use descriptive commit messages** that reference the work item or feature

### Documentation Maintenance

**🔴 CRITICAL: Update HANDOFF.md After Major Tasks**

Agents MUST update `Docs/HANDOFF.md` when completing significant work to ensure continuity for future agents. This is essential for maintaining project history and context.

**Update HANDOFF.md when:**

- ✅ Adding new queries or modifying query structure
- ✅ Creating new automation scripts or tools
- ✅ Implementing new features or capabilities
- ✅ Discovering important API limitations or workarounds
- ✅ Completing major analysis or reporting tasks
- ✅ Making architectural or structural changes
- ✅ Fixing critical bugs or resolving issues
- ✅ Adding new documentation files

**What to document:**

- Brief description of what was completed
- New files created or modified
- Important learnings or gotchas
- Commands or workflows for using new features
- Any breaking changes or deprecations

**Other Documentation Updates:**

- **Update QUERIES.md** when new queries are added to ADO
- **Keep this file current** when workspace structure changes
- **Update README.md** when adding user-facing features

---

## Automation Tools & Workflows

### Core Automation Scripts

Located in `/scripts/`:

1. **fetch_all_queries.py** - Executes all 39 queries and saves results to Reports/
   - Usage: `python3 fetch_all_queries.py`
   - Output: `Reports/all_queries_<timestamp>.json`
   - Includes error handling and progress reporting

2. **validate_queries.sh** - Tests connectivity to all 39 query IDs
   - Usage: `./validate_queries.sh`
   - Returns: HTTP status codes for each query
   - Useful for diagnosing PAT or network issues

3. **check_pat_expiry.sh** - Validates PAT authentication status
   - Usage: `./check_pat_expiry.sh`
   - Tests: Single query as connectivity check
   - Provides troubleshooting guidance for failures

4. **generate_team_report.py** - Analyzes team workload distribution
   - Usage: `python3 generate_team_report.py`
   - Requires: Latest query results from fetch_all_queries.py
   - Output: Console report with team rankings and statistics

### Data Management Utilities

5. **cache_manager.py** - TTL-based query result caching
   - Commands:
     - `stats` - Show cache statistics
     - `clear-expired` - Remove expired entries
     - `clear-all` - Clear entire cache
   - Cache location: `Reports/.cache/`

6. **ado_transforms.py** - Data transformation utilities
   - Commands:
     - `to-csv <input.json> <output.csv>` - Convert to CSV
     - `metrics <input.json>` - Calculate team metrics
     - `flat-json <input.json> <output.json>` - Flatten structure
   - Supports: Field extraction, aggregation, filtering

7. **compare.py** - Team/query comparison and trend analysis
   - Commands:
     - `teams` - Compare workload across all teams
     - `trends` - Show workload changes over time
     - `queries Q1 Q2` - Compare two specific queries
   - Features: Outlier detection, percentage calculations, ranking

### Query Templates

Located in `/scripts/query_templates/`:

- **team_scenarios.wiql** - Filter scenarios by team and quarter
- **priority_filter.wiql** - Filter by priority level
- **custom_query.py** - Execute WIQL with parameter substitution
  - Usage: `python3 custom_query.py template.wiql PARAM=value`
  - Example: `python3 custom_query.py team_scenarios.wiql TEAM_NAME=Mebaa QUARTER=FY26Q4`

### Interactive Dashboard

- **Location:** `Reports/dashboard.html`
- **Features:**
  - Real-time statistics (Total, Completed, In Progress, At Risk)
  - Team workload bar chart
  - Status breakdown doughnut chart
  - Priority distribution pie chart
  - Business area focus chart
- **Auto-refresh:** Every 5 minutes
- **Data source:** Latest `all_queries_*.json` file

### VS Code Tasks

Press `Cmd+Shift+P` → "Tasks: Run Task":

- **Fetch All Queries** - Run fetch_all_queries.py
- **Validate All Queries** - Check query connectivity
- **Check PAT Status** - Validate authentication
- **Generate Team Report** - Team analysis
- **Execute Query by ID** - Run specific query (prompts for ID)

Configuration: `.vscode/tasks.json`

### GitHub Actions Workflows

Located in `.github/workflows/`:

1. **validate-docs.yml** - Runs on every push
   - Checks markdown links
   - Validates query count (39)
   - Ensures required docs exist

2. **check-pat.yml** - Runs weekly (Mondays 9am UTC)
   - Tests PAT connectivity
   - Creates GitHub issue if PAT fails
   - Requires `AZURE_DEVOPS_PAT` repository secret

### Setup Automation

- **setup.sh** - Initialize workspace automatically
  - Checks dependencies (curl, jq, python3, git)
  - Validates .env configuration
  - Creates .env template if missing
  - Tests API connectivity
  - Sets script permissions
  - Verifies folder structure

---

## Recommended Workflows

### Initial Setup Workflow

```bash
# 1. Run setup script
./setup.sh

# 2. Configure .env with your PAT
# 3. Validate connectivity
cd scripts && ./check_pat_expiry.sh

# 4. Fetch all queries
python3 fetch_all_queries.py

# 5. Generate initial report
python3 generate_team_report.py
```

### Regular Analysis Workflow

```bash
# Weekly data refresh
cd scripts
python3 fetch_all_queries.py

# View team comparison
python3 compare.py teams

# Track trends over time (requires multiple snapshots)
python3 compare.py trends

# Generate visual dashboard
open ../Reports/dashboard.html
```

### Custom Query Workflow

```bash
cd scripts/query_templates

# Option 1: Use existing template
python3 custom_query.py team_scenarios.wiql TEAM_NAME=Kyle QUARTER=FY26Q4

# Option 2: Create new WIQL template
# Edit .wiql file with placeholders {PARAM_NAME}
# Execute with custom_query.py
```

### Data Export Workflow

```bash
cd scripts

# Export to CSV for Excel/Power BI
python3 ado_transforms.py to-csv ../Reports/all_queries_latest.json ../Reports/export.csv

# Calculate detailed metrics
python3 ado_transforms.py metrics ../Reports/all_queries_latest.json > ../Reports/metrics.json
```

---

## Quick Start for New Agents

1. **Read** `HANDOFF.md` for project context and history
2. **Review** `QUERIES.md` to understand available queries
3. **Check** `AZURE_DEVOPS_API_REFERENCE.md` for API patterns
4. **Run** `./setup.sh` to validate environment
5. **Execute** `fetch_all_queries.py` for current data
6. **Explore** `dashboard.html` for visualizations
7. **Save outputs** to appropriate folders (`/Reports` or `/scripts`)
8. **🔴 CRITICAL: Update `HANDOFF.md`** after completing major tasks (see Documentation Maintenance section)

---

## Troubleshooting Guide

### PAT Issues

```bash
# Check PAT validity
./scripts/check_pat_expiry.sh

# If failed, regenerate PAT at:
# https://dev.azure.com/microsoft/_usersSettings/tokens
# Required scope: Work Items (Read)
```

### Script Execution Errors

```bash
# Fix permissions
chmod +x scripts/*.py scripts/*.sh setup.sh

# Install Python dependencies
pip3 install requests
```

### Query Failures

- Check query ID in QUERIES.md
- Verify in Azure DevOps directly
- Run validate_queries.sh for diagnostics

### Cache Issues

```bash
# View cache status
python3 cache_manager.py stats

# Clear expired entries
python3 cache_manager.py clear-expired

# Full reset
python3 cache_manager.py clear-all
```

---

## Support & References

- **Primary Contact:** See project documentation
- **Azure DevOps Instance:** https://dev.azure.com/microsoft/Xbox
- **Query Browser:** https://microsoft.visualstudio.com/Xbox/_queries/folder/
- **API Documentation:** https://learn.microsoft.com/en-us/rest/api/azure/devops/
- **GitHub Repository:** https://github.com/DaveVoyles/XPC-ADO-Chat-Agent-Interface

---

**Remember:** This workspace is designed for visualization and reporting with comprehensive automation. Always leverage existing scripts and save generated artifacts to maintain project continuity for future agents.
