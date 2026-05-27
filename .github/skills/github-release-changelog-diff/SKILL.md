---
name: github-release-changelog-diff
description: "Extract and diff component changelogs from GitHub release tag descriptions between two monthly releases. Use when: comparing individual component release notes, diffing GitHub release tag bodies, aggregating changes across intermediate versions, listing what was added or removed in RPS, MPS, RPC-Go, Console, Sample-Web-UI, UI Toolkit, go-wsman-messages between releases."
argument-hint: "[component(s)] from '[Month Year] Release' to '[Month Year] Release'"
---

# GitHub Release Changelog Diff

Retrieves changelog content from **individual GitHub release tag descriptions** (the body written on each repo's Releases page) and diffs them across two monthly release milestones.

> **Difference from `/changelog-diff`**: That skill reads the consolidated changelog from cloud-deployment *issue bodies*. This skill reads the *per-tag release description* on each component repo (e.g., `github.com/device-management-toolkit/rps/releases/tag/v2.34.0`), which may contain richer notes, PR links, and intermediate version details not reflected in the issue body.

## When to Use

- Get the verbatim release notes as written on each component's GitHub Releases page
- Aggregate changes across intermediate versions (e.g., v2.32.x, v2.33.x between v2.31.3 and v2.34.2)
- Diff what was added/removed across a date range for one or more components
- The cloud-deployment issue body is missing detail or not yet published

## Input

| Parameter | Required | Description |
|-----------|----------|-------------|
| From release | Yes | Base monthly release label, e.g. `2026 January Release` |
| To release | Yes | Target monthly release label, e.g. `2026 March Release` |
| Components | No | Comma-separated list, e.g. `RPS, MPS`. Omit for all. |

**Release naming format:** `[Month Year] Release` (e.g., `2026 January Release`, `2026 March Release`)

## Component Repository Map

| Component | `### ` Heading (exact) | GitHub Repo | Release URL Pattern |
|-----------|------------------------|-------------|---------------------|
| RPS | `### RPS` | `device-management-toolkit/rps` | `/releases/tag/v{version}` |
| MPS | `### MPS` | `device-management-toolkit/mps` | `/releases/tag/v{version}` |
| RPC-Go | `### RPC Go` | `device-management-toolkit/rpc-go` | `/releases/tag/v{version}` |
| Sample-Web-UI | `### Sample Web UI` | `device-management-toolkit/sample-web-ui` | `/releases/tag/v{version}` |
| UI Toolkit | `### UI Toolkit` | `device-management-toolkit/ui-toolkit` | `/releases/tag/v{version}` |
| UI Toolkit Angular | `### UI Toolkit Angular` | `device-management-toolkit/ui-toolkit-angular` | `/releases/tag/v{version}` |
| UI Toolkit React | `### UI Toolkit React` | `device-management-toolkit/ui-toolkit-react` | `/releases/tag/v{version}` |
| Console | `### Console` | `device-management-toolkit/console` | `/releases/tag/v{version}` |
| go-wsman-messages | `### Go WSMAN Messages` | `device-management-toolkit/go-wsman-messages` | `/releases/tag/v{version}` |
| wsman-messages | `### WSMAN Messages` | `device-management-toolkit/wsman-messages` | `/releases/tag/v{version}` |
| mps-router | `### MPS Router` | `device-management-toolkit/mps-router` | `/releases/tag/v{version}` |

## Procedure

### Step 1 — Resolve Version Boundaries

1. Fetch the cloud-deployment release issues page:  
   `https://github.com/device-management-toolkit/cloud-deployment/issues`
2. Find the issue whose title matches the **From release** label (e.g., `2026 January Release`).
3. Find the issue whose title matches the **To release** label (e.g., `2026 March Release`).
4. From each issue body, extract the component version listed under each component section.
5. Record the **From version** and **To version** for each requested component.

**If version mapping is already known**, skip this step and proceed directly with the provided versions.

### Step 2 — Enumerate Intermediate Versions

For each component, determine all release tags between the From version and To version (exclusive of From, inclusive of To):

**Option A — GitHub Releases list** (preferred):  
Fetch `https://github.com/device-management-toolkit/{repo}/releases` and identify all tags between the two boundary versions in descending order.

**Option B — CHANGELOG.md** (fallback if releases list is paginated or truncated):  
Fetch `https://raw.githubusercontent.com/device-management-toolkit/{repo}/main/CHANGELOG.md`  
Extract all version headers (`## [X.Y.Z]`) between the From and To versions.

If the version range spans only one release tag (e.g., patch bump), enumerate just that tag.

### Step 3 — Fetch Each Release Tag Description

For each intermediate version identified in Step 2:

1. Construct the URL: `https://github.com/device-management-toolkit/{repo}/releases/tag/v{version}`
2. Fetch the page and extract the **release body** (the written description / changelog section).
3. If the release body is empty or missing, fall back to the CHANGELOG.md entry for that version.
4. Record which version each entry belongs to.

**Tip:** If fetching many intermediate versions, prefer the CHANGELOG.md approach in Step 2 Option B to retrieve all entries in a single fetch.

### Step 4 — Aggregate and Normalize Entries

Combine all extracted entries across intermediate versions for each component:

1. Group entries by type: **Features**, **Bug Fixes**, **Performance**, **Build**, **Refactor**, **Breaking Changes**.
2. Deduplicate: if the same fix appears in multiple tags (e.g., backport), include it once.
3. Strip dependency-only build entries (e.g., `bump X from Y to Z`) unless the user asks to include them.
4. Preserve the original wording, PR/issue numbers, and commit hashes.

### Step 5 — Diff Against From Version

Identify what is **New** (in To but not in From):

- An entry is "new" if it does not appear in the **From version's** release tag description.
- Use PR/issue numbers as stable identifiers. If absent, use the commit hash. If both absent, use fuzzy text match (>85% similarity = same entry).

Identify what is **Removed** (in From but not in To):

- An entry is "removed" if it appeared in the From release but has no equivalent in any intermediate version up to To.
- Typically rare; most diffs produce only "Added" entries.

### Step 6 — Generate Narrative Sections

From the aggregated changelog entries, produce the three narrative sections that appear **above** the Changelog in release-notes.md. All content must be derived directly from the changelog entries collected in Steps 3–5. Do not invent details not present in the changelog.

Output these as a separate ```` ```markdown ```` code fence labeled **"Narrative Sections"**, presented before the Changelog code fence.

**`## 🚀 What's New?`**
- Include significant new **Features** — breaking changes, entirely new capabilities, or major workflow additions
- Format: `### Component: Descriptive Title` subheading followed by 1–3 sentences expanding on what the feature does and why it matters
- Base all wording on the commit/PR message text; do not add information not present in the changelog
- If no Features qualify as major, omit this section

**`## 🧩 Enhancements & Improvements`**
- Include smaller features, performance improvements, and non-breaking improvements
- Same format: `### Component: Descriptive Title` + short paragraph
- If a Feature was already included in What's New, do not repeat it here
- If no entries qualify, omit this section

**`## 🔧 Fixes & Maintenance`**
- Include all Bug Fixes as a bulleted list: `- Component [fix description in plain prose]`
- If most/all versions across a component were deps-only, add one bullet: `- Minor dependency updates and general maintenance across toolkit components`
- Do not list individual dependency bump commits

**Categorisation rules:**
| Changelog type | Section |
|---|---|
| Breaking change or entirely new capability | What's New |
| Smaller feature, performance improvement | Enhancements & Improvements |
| Bug fix | Fixes & Maintenance |
| Deps-only / build / CI | Fixes & Maintenance (single combined bullet) |

### Step 7 — Print Release Summary (outside code fence)

Before the paste-ready output, print a brief summary **outside** the code fence. This is for the user's information only and must NOT appear inside the `````markdown````` block.

Format:

```
**RPS** (v2.31.3 → v2.34.2): 9 releases (v2.31.4, v2.32.0, v2.32.1, v2.32.2, v2.33.0, v2.33.1, v2.34.0, v2.34.1, v2.34.2) · 2 deps-only — no body (v2.31.4, v2.34.2)
**MPS** (v2.26.0 → v2.26.4): 4 releases (v2.26.1, v2.26.2, v2.26.3, v2.26.4) · 2 deps-only — no body (v2.26.2, v2.26.4)
```

Rules for the summary:
- One line per component.
- Show the From → To version boundary.
- List **all** intermediate versions in ascending order (including deps-only).
- Separately note which versions had no changelog body (deps-only).
- Do **not** include this summary inside the `````markdown````` code fence.

### Step 8 — Format Output

Copy the release tag body **verbatim** for each intermediate version, grouped by component. Follow this exact structure (matching the Changelog section in release-notes.md):

```
### {Component}

#### [{version}]({compare_url}) ({date})

{verbatim release tag body — Bug Fixes, Features, etc., exactly as written on the GitHub release page}

#### [{version}]({compare_url}) ({date})

{verbatim release tag body}
```

Rules:
- Use `### {Component}` as the top-level heading (no version range in the heading). The exact heading text **must** match the `### ` Heading column in the Component Repository Map — do not use the repo name, hyphenated form, or lowercase variant (e.g. use `### Go WSMAN Messages`, not `### go-wsman-messages`; use `### RPC Go`, not `### RPC-Go`; use `### Sample Web UI`, not `### Sample-Web-UI`).
- Use `#### [version](compare_url) (date)` for each individual release tag — the compare URL links to the diff between the previous tag and this one, exactly as shown in the release body.
- Copy the release tag body **word for word** — do not paraphrase, summarize, or reformat entries.
- **Exception — subsection labels**: If the release tag body contains `### Features`, `### Bug Fixes`, `### Performance Improvements`, `### Breaking Changes`, or any other `###`-prefixed subsection label, **strip the `###` prefix** and render it as plain text (e.g., `Features`, `Bug Fixes`). The only `###` headings in the output are component names; the only `####` headings are version entries. All other content (bullets, links, commit hashes) is copied verbatim.
- Order versions **newest first** (descending) within each component section — this matches the existing release-notes.md pattern.
- If a version's release tag body is empty (deps-only), still include its `####` heading (with compare URL and date) but leave the body empty — do not add any placeholder text.
- If release body is unavailable, note `Release notes unavailable — falling back to CHANGELOG.md` directly under the `####` heading and use the CHANGELOG.md entry instead.
- Do **not** add `---` horizontal rule separators between components or between versions. Components are separated only by their `### Component` heading.
- **Wrap the entire output in a ```` ```markdown ```` code fence.** This prevents VS Code chat from rendering the markdown, so the raw syntax (`###`, `####`, `*`, `[text](url)`) is visible and can be copied directly into the .md file.
- The output must be ready to paste directly into the `## :material-update:{ .icon-log } Changelog` section of release-notes.md with no reformatting needed.

## Output Example

The output has **two** separate ```` ```markdown ```` code fences — first the Narrative Sections, then the Changelog.

**Narrative Sections fence** (paste into the top of the release-notes.md):

````markdown
## 🚀 What's New?

### RPS: E2E TLS Connection Between AMT and RPS

RPS now supports an end-to-end TLS connection between AMT and RPS during provisioning. This improves security for environments that require encrypted communication throughout the activation workflow.

### Console: Redirection over CIRA

Console now enables KVM, SOL, and IDER redirection over CIRA connections, allowing remote management for devices that are only reachable via CIRA.

## 🧩 Enhancements & Improvements

### go-wsman-messages: Tags Support in Config

The config structure now supports tags, enabling finer-grained categorization and filtering of device configurations.

## 🔧 Fixes & Maintenance

- RPS fix for ACM activation failure when device FQDN has more segments than the stored domain suffix
- RPS fix to tighten CIRA config name validation and prevent 500 errors on invalid names
- MPS fix to remove tenantId filter from clearInstanceStatus
- Console fix to resolve Memory Summary showing no data in Hardware Information
- Console fix for KVM browser websocket not closing immediately on AMT disconnect
- Minor dependency updates and general maintenance across toolkit components
````

**Changelog fence** (paste into the Changelog section of release-notes.md):

````markdown
### RPS

#### [2.34.1](https://github.com/device-management-toolkit/rps/compare/v2.34.0...v2.34.1) (2026-04-09)

Bug Fixes

* return clear error for unsupported ECDSA/EC provisioning certificates ([#2604](https://github.com/device-management-toolkit/rps/issues/2604)) ([35d4840](https://github.com/device-management-toolkit/rps/commit/35d484017b1b8428e53eef3c550a75da2a843298)), closes [#2505](https://github.com/device-management-toolkit/rps/issues/2505)

#### [2.34.0](https://github.com/device-management-toolkit/rps/compare/v2.33.1...v2.34.0) (2026-04-02)

Features

* adds support for E2E TLS connection between AMT and RPS ([#2598](https://github.com/device-management-toolkit/rps/issues/2598)) ([73baf43](https://github.com/device-management-toolkit/rps/commit/73baf4318b23b8ed1d9ad2e5749b5fcce5bc9346))

#### [2.33.1](https://github.com/device-management-toolkit/rps/compare/v2.33.0...v2.33.1) (2026-03-30)

Bug Fixes

* tighten CIRA config name validation to prevent 500 errors ([#2635](https://github.com/device-management-toolkit/rps/issues/2635)) ([3ebeae6](https://github.com/device-management-toolkit/rps/commit/3ebeae64f304a15e5c94788c7e221bd3132bc73d)), closes [#2599](https://github.com/device-management-toolkit/rps/issues/2599)

#### [2.33.0](https://github.com/device-management-toolkit/rps/compare/v2.32.2...v2.33.0) (2026-03-30)

Features

* validate root certificate exists in provisioning cert ([#2627](https://github.com/device-management-toolkit/rps/issues/2627)) ([62315a7](https://github.com/device-management-toolkit/rps/commit/62315a76ac3d8a15e8fbc37ea06a6616c5bc8573))

#### [2.32.2](https://github.com/device-management-toolkit/rps/compare/v2.32.1...v2.32.2) (2026-03-24)

Bug Fixes

* ACM activation fails when device FQDN has more segments than stored domain suffix ([#2622](https://github.com/device-management-toolkit/rps/issues/2622)) ([e360876](https://github.com/device-management-toolkit/rps/commit/e360876bc9db288cb9288ab632029350cc09ffb2))

#### [2.32.1](https://github.com/device-management-toolkit/rps/compare/v2.32.0...v2.32.1) (2026-03-23)

Bug Fixes

* derive sharedStaticIP from DHCPEnabled in profile export ([#2618](https://github.com/device-management-toolkit/rps/issues/2618)) ([e86a250](https://github.com/device-management-toolkit/rps/commit/e86a250cb1e42243a047bc4549a987ade60ecba5))

#### [2.32.0](https://github.com/device-management-toolkit/rps/compare/v2.31.4...v2.32.0) (2026-03-18)

Features

* adds support for E2E TLS connection between AMT and RPS ([0a60ff3](https://github.com/device-management-toolkit/rps/commit/0a60ff3cf4242ba6bef6bf3e413210588b9eaabf))


### MPS

#### [2.26.3](https://github.com/device-management-toolkit/mps/compare/v2.26.2...v2.26.3) (2026-03-24)

Bug Fixes

* remove tenantId filter from clearInstanceStatus ([#2404](https://github.com/device-management-toolkit/mps/issues/2404)) ([5084072](https://github.com/device-management-toolkit/mps/commit/508407208fc788d13e564e1649f1c574edfce9cc))

#### [2.26.1](https://github.com/device-management-toolkit/mps/compare/v2.26.0...v2.26.1) (2026-03-02)

Bug Fixes

* prevent redirect session crash during device validation ([#2359](https://github.com/device-management-toolkit/mps/issues/2359)) ([3aa2c0c](https://github.com/device-management-toolkit/mps/commit/3aa2c0cfc8ada76405eb14ff4fbcf39cf57475b6))
````

## Behavior Rules

- **Produce two output blocks**: a Narrative Sections ```` ```markdown ```` fence first, then the Changelog ```` ```markdown ```` fence.
- **Narrative sections derive from changelog only** — do not add information not present in the release tag bodies.
- **Always use release tag descriptions as the primary source**; fall back to CHANGELOG.md only when a tag has no body.
- **Copy verbatim** — reproduce the exact text, bullet style (`*`), link format, and commit hash format from the release page.
- **Aggregate all intermediate versions** — if the user requests v2.31.3 → v2.34.2, include all tags from v2.31.4 through v2.34.2 in order.
- **Include all intermediate versions** — even deps-only releases get a `####` heading with no body.
- **If both releases have the same version** for a component, omit that component from the output entirely.
- **Component order** — always output components in this sequence, using the **exact `### ` heading** from the Component Repository Map: `RPS`, `MPS`, `RPC Go`, `Sample Web UI`, `UI Toolkit`, `UI Toolkit Angular`, `UI Toolkit React`, `Console`, `Go WSMAN Messages`, `WSMAN Messages`, `MPS Router`. Omit any component with no version change.
- **Always state the data source** if falling back to CHANGELOG.md: add a note directly under the affected `####` heading.

## Example Invocations

```
/github-release-changelog-diff RPS from "2026 January Release" to "2026 March Release"
```

```
/github-release-changelog-diff RPS, MPS, Console from "2025 November Release" to "2026 January Release"
```

```
/github-release-changelog-diff from "2026 January Release" to "2026 March Release"
```
*(omitting component = diff all components)*
