# DaVinci Resolve macOS Workflow & Folder Structure

## Purpose
A professional Resolve workflow separates project media, Resolve system files, backups, and exports. This document uses `~/Movies/yt/` as your project root and works for both short-form and regular videos.

## Goals
- Keep projects local and organized while active
- Separate Resolve cache, backups, and shared assets from project media
- Make archiving simple and reliable
- Preserve original media and exported project backups
- Support both short-form and long-form workflows

## Global folder structure
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
- `yt/` is the project root for active work
- Archive finished projects to NAS as complete folders
- `shorts/` is optional if you want a dedicated short-form area

## Resolve storage locations
### Resolve/Cache
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
- Use the fastest internal SSD available
- Safe to delete after a project is finished or to reclaim space

### Resolve/Backups
```text
/Users/<your-user>/Movies/Resolve/Backups/
```
Purpose:
- Automatic Resolve backups
- Live Save snapshots
Recommended settings:
- Enable Live Save
- Save backups every 10 minutes
- Keep hourly and daily snapshots if disk space allows

### Resolve/ProjectLibrary
```text
/Users/<your-user>/Movies/Resolve/ProjectLibrary/
```
Purpose:
- Dedicated Resolve project database location
Benefits:
- Keeps the database separate from hidden defaults
- Simplifies migration and backup
- Makes metadata portable

### Resolve/Assets
```text
/Users/<your-user>/Movies/Resolve/Assets/
```
Purpose:
- Store reusable assets shared across projects
Example:
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
- Use this folder for shared assets only
- Do not duplicate shared assets inside every project
- Keep project-specific media inside each project folder

## Project folder structure
### Example layout
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
- Use numbered folders to keep order consistent
- Keep source media, project files, and exports together
- Archive the entire project folder when finished

### 01_Footage
Original camera footage and source media.
- Never rename files after importing into Resolve
- Keep original camera filenames intact
- Organize using folders and Resolve bins, not by renaming media

### 02_Audio
Project-specific audio, such as:
- Voiceovers
- Recorded interviews
- Temporary music
- Sound design

### 03_Graphics
Project-specific graphics, including:
- PNG overlays
- Titles and lower thirds
- Captions and subtitles
- Thumbnails
- Motion graphics exports

### 05_Project
Exported Resolve project files.
Example:
```text
05_Project/
├── project-v01.drp
├── project-v02.drp
└── project-final.drp
```
Guidelines:
- Export `.drp` files frequently during editing
- `.drp` files are critical backups but do not contain media
- Use versioned filenames for safe rollbacks

### 06_Renders
Final and review exports.
Example:
```text
06_Renders/
├── Review/
│   └── project-v03.mp4
└── Final/
    └── project-final.mp4
```
Guidelines:
- Separate review and final outputs
- Keep review versions until final approval

### 07_Proxies
Optional proxy media.
When to use:
- Large camera files on slower systems
- Complex timelines where optimized playback helps
When not to use:
- Modern Macs often do not require manual proxies for short-form work

## Resolve preferences
### Media Storage / Cache Location
In DaVinci Resolve:
```text
DaVinci Resolve → Preferences → Media Storage
```
Add:
```text
/Users/<your-user>/Movies/Resolve/Cache/
```
Move it to the top of the list.
This ensures Resolve stores cache, optimized media, render cache, and proxy media inside the dedicated cache folder.

## Backup workflow
### During editing
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
Why:
- Protects against corrupted project files
- Makes it easy to revert to a previous edit
- Keeps a clear audit trail of project progress

## Archiving workflow
### When a project is finished
Move the complete project folder to NAS or long-term archive.
This preserves:
- Original footage
- Project files
- Final renders
- Graphics
- Audio
Why archive the whole folder:
- Keeps the project portable
- Makes relinking easier later
- Reduces confusion when revisiting projects

## Professional rules
### Safe to delete
- Cache files
- Render cache
- Optimized media
- Proxy files
These can be regenerated from the original project.

### Never delete casually
- Original footage
- `.drp` project files
- Final renders
These are your source assets and deliverables.

## Recommended editing habits
### Versioned exports
Examples:
```text
project-v01.mp4
project-v02.mp4
project-final.mp4
```
Avoid overwriting old versions.

### Versioned `.drp` saves
Examples:
```text
project-v01.drp
project-v02.drp
project-final.drp
```
This protects against corrupted projects, bad edits, and accidental deletions.

### Keep projects local
- Projects on local SSD while active
- Cache on the fastest SSD available
- Finished projects archived to NAS

## Current recommended setup
### Internal SSD
Use for Resolve cache, active projects, and current renders.

### NAS
Use for finished projects, long-term archive, and secondary backups.

## Summary
This workflow delivers:
- Consistent project organization
- Clear separation between source media and Resolve system files
- Safer backups and archives
- Easier relinking and migration
- A generic structure that works for shorts and regular videos

