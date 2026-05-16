# DaVinci Resolve macOS Workflow & Folder Structure

## Purpose

A professional Resolve workflow should separate project assets, Resolve system files, backups, and exports. This document uses `~/Movies/yt/` as your personal project root while keeping the structure applicable to both regular videos and shorts.

## Goals

- Keep projects local and organized
- Separate Resolve cache/backups from project media
- Make archiving simple and reliable
- Preserve original media and exported project backups
- Support both short-form and long-form video workflows

---

# Recommended Folder Structure

## Global Structure

```text
/Users/<your-user>/Movies/
├── Resolve/
│   ├── Cache/
│   ├── Backups/
│   ├── ProjectLibrary/
│   └── Assets/
└── yt/
    ├── 001-project-title/
    ├── 002-project-title/
    └── shorts/
        └── 001-short-title/
```

Notes:

- `yt/` is your project root and works for both full videos and shorts
- Keep projects in `yt/` while they are active, then archive complete project folders to NAS
- `shorts/` is optional if you prefer a dedicated short-form folder

---

# Resolve Storage Locations

## Resolve/Cache

```text
/Users/<your-user>/Movies/Resolve/Cache/
```

Purpose:

- Render cache
- Optimized media
- Proxy files
- Fusion cache
- Temporary Resolve-generated files

Best practice:

- Keep this on the fastest internal SSD available
- Safe to delete when a project is finished or to reclaim space

---

## Resolve/Backups

```text
/Users/<your-user>/Movies/Resolve/Backups/
```

Purpose:

- Automatic Resolve project backups
- Live Save snapshots

Recommended settings:

- Enable Live Save
- Save backups every 10 minutes
- Keep hourly and daily snapshots if disk space allows

---

## Resolve/ProjectLibrary

```text
/Users/<your-user>/Movies/Resolve/ProjectLibrary/
```

Purpose:

- Dedicated Resolve project database location

Why this helps:

- Keeps the Resolve database separate from hidden defaults
- Makes migrating, backing up, and restoring projects easier
- Keeps project metadata transparent and portable

---

## Resolve/Assets

```text
/Users/<your-user>/Movies/Resolve/Assets/
```

Purpose:

Shared assets that apply across multiple projects.

Example subfolders:

```text
Assets/
├── Music/
├── SFX/
├── LUTs/
├── Overlays/
├── LowerThirds/
└── Transitions/
```

Guidelines:

- Use this folder for reusable elements only
- Do not duplicate these assets inside every project
- Keep project-specific media inside each project folder

---

# Project Folder Structure

## Example project layout

```text
/Users/<your-user>/Movies/yt/001-project-title/
├── 01_Footage/
├── 02_Audio/
├── 03_Graphics/
├── 05_Project/
├── 06_Renders/
└── 07_Proxies/
```

Notes:

- Use consistent numbering to keep folders ordered
- Keep all source and project files within the project folder
- Archive the whole folder together when a project is finished

---

## 01_Footage

Contains original camera footage and source media.

Important:

- Never rename files after importing into Resolve
- Keep original camera filenames intact
- Organize using folders and Resolve bins, not by renaming media

---

## 02_Audio

Project-specific audio files, including:

- Voiceovers
- Recorded interviews
- Temporary music
- Sound design

---

## 03_Graphics

Project-specific graphics and visual assets, such as:

- PNG overlays
- Titles and lower thirds
- Captions and subtitles
- Thumbnails
- Motion graphics exports

---

## 05_Project

Exported Resolve project files live here.

Example:

```text
05_Project/
├── project-v01.drp
├── project-v02.drp
└── project-final.drp
```

Professional rules:

- Export `.drp` files frequently during editing
- `.drp` files are critical backups but do not contain media
- Use versioned filenames for safe rollbacks

---

## 06_Renders

Contains final and review exports.

Example:

```text
06_Renders/
├── Review/
│   └── project-v03.mp4
└── Final/
    └── project-final.mp4
```

Notes:

- Separate review and final renders
- Keep old review versions until the final is approved

---

## 07_Proxies

Optional proxy media.

When to use:

- Large camera files on slower systems
- Complex timelines where optimized playback helps

When not to use:

- Modern Macs often do not require manual proxies for short-form work

---

# Resolve Preferences

## Media Storage / Cache Location

In DaVinci Resolve:

```text
DaVinci Resolve → Preferences → Media Storage
```

Add:

```text
/Users/<your-user>/Movies/Resolve/Cache/
```

Then move it to the top of the list.

This ensures Resolve stores:

- Cache files
- Optimized media
- Render cache
- Proxy media

inside the dedicated cache folder.

---

# Editing Backup Workflow

## During Editing

Regularly export project backups:

```text
File → Export Project
```

Save `.drp` files to:

```text
05_Project/
```

Use versioned filenames such as:

```text
project-v01.drp
project-v02.drp
project-final.drp
```

Why this matters:

- Protects against corrupted project files
- Makes it easy to revert to a previous edit
- Keeps a clean audit trail of project progress

---

# Archiving Workflow

## When a project is finished

Move the complete project folder to NAS or long-term archive.

This preserves:

- Original footage
- Project files
- Final renders
- Graphics
- Audio

Why archive the whole folder:

- Keeps the project portable
- Makes relinking and restoring easier later
- Reduces confusion when projects are revisited

---

# Professional Rules

## Safe to delete

- Cache files
- Render cache
- Optimized media
- Proxy files

These can be regenerated from the original project.

---

## Never delete casually

- Original footage
- `.drp` project files
- Final renders

These are your source assets and deliverables.

---

# Recommended Editing Habits

## Use versioned exports

Examples:

```text
project-v01.mp4
project-v02.mp4
project-final.mp4
```

Avoid overwriting old versions whenever possible.

---

## Use versioned `.drp` saves

Examples:

```text
project-v01.drp
project-v02.drp
project-final.drp
```

This protects against:

- Corrupted projects
- Bad edits
- Accidental deletions

---

## Keep projects local

Best practice:

- Projects on local SSD while active
- Cache on the fastest SSD available
- Finished projects archived to NAS

---

# Current Recommended Setup

## Internal SSD

Use for:

- Resolve cache
- Active projects
- Current renders

---

## NAS

Use for:

- Finished projects
- Long-term archive
- Secondary backups

---

# Summary

This workflow delivers:

- Consistent project organization
- Clear separation between source media and Resolve system files
- Safer backups and archives
- Easier relinking and migration
- A generic structure that works for shorts and regular videos

