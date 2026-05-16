# DaVinci Resolve macOS Workflow & Folder Structure

## Goals

This workflow is designed for:

- Video editing in Davinci Resolve
- Clean long-term project organization
- Easy NAS archiving
- Reliable backups
- Professional-style Resolve workflow

---

# Recommended Folder Structure

## Global Structure

```text
/Users/my-user/Movies/
├── Resolve/
│   ├── Cache/
│   ├── Backups/
│   ├── ProjectLibrary/
│   └── Assets/
│
└── yt/
    ├── 001-video-title/
    └── shorts/
        └── 001-shorts-title/
```

---

# Resolve Folder Purposes

## Resolve/Cache

```text
/Users/my-user/Movies/Resolve/Cache/
```

Purpose:

- Render cache
- Optimized media
- Proxy files
- Fusion cache
- Temporary Resolve-generated files

Notes:

- Safe to delete later if needed
- Best placed on fastest SSD available

---

## Resolve/Backups

```text
/Users/my-user/Movies/Resolve/Backups/
```

Purpose:

- Automatic Resolve backups
- Live Save snapshots

Recommended settings:

- Enable Live Save
- Backup every 10 minutes
- Keep hourly and daily backups

---

## Resolve/ProjectLibrary

```text
/Users/my-user/Movies/Resolve/ProjectLibrary/
```

Purpose:

- Dedicated Resolve project database location

Notes:

- Optional initially
- Recommended later for cleaner project management
- Easier to back up and migrate than default hidden macOS paths

---

## Resolve/Assets

```text
/Users/my-user/Movies/Resolve/Assets/
```

Purpose:

Reusable assets shared across multiple projects.

Example structure:

```text
Assets/
├── Music/
├── SFX/
├── LUTs/
├── Overlays/
├── LowerThirds/
├── Memes/
└── Transitions/
```

Notes:

- Do not duplicate reusable assets per project
- Keep project-specific assets inside the project folder

---

# Per-Project Structure

Example project:

```text
/Users/my-user/Movies/yt/Active/001-video-title/
├── 01_Footage/
├── 02_Audio/
├── 03_Graphics/
├── 05_Project/
├── 06_Renders/
└── 07_Proxies/
```

---

## Folder Details

### 01_Footage

Original camera footage.

Important:

- Never rename files after importing into Resolve
- Keep original camera filenames
- Organize using folders and Resolve bins instead

---

### 02_Audio

Project-specific audio:

- Voiceovers
- Recorded audio
- Temporary music
- Sound design

---

### 03_Graphics

Project-specific graphics:

- PNG overlays
- Titles
- Captions
- Thumbnails
- Motion graphics

---

### 05_Project

Contains exported Resolve project files.

Example:

```text
05_Project/
├── short-v01.drp
├── short-v02.drp
└── short-final.drp
```

Important:

- `.drp` files are critical backups
- Export regularly during editing
- `.drp` files do NOT contain media

---

### 06_Renders

Contains rendered exports.

Example:

```text
06_Renders/
├── Review/
│   └── short-v03.mp4
│
└── Final/
    └── short-final.mp4
```

---

### 07_Proxies

Optional manually generated proxies.

Notes:

- Often unnecessary for short-form editing on modern Macs
- Useful for large projects or slower systems

---

# Resolve Settings

## Media Storage / Cache Location

In DaVinci Resolve:

```text
DaVinci Resolve → Preferences → Media Storage
```

Add:

```text
/Users/my-user/Movies/Resolve/Cache/
```

Move it to the TOP of the list.

This tells Resolve to place:

- Cache files
- Optimized media
- Render cache
- Proxy media

inside the dedicated cache folder.

---

# Backup Workflow

## During Editing

Regularly:

```text
File → Export Project
```

Save `.drp` files into:

```text
05_Project/
```

Use versioned filenames:

```text
short-v01.drp
short-v02.drp
short-final.drp
```

---

# Archiving Workflow

## When Project Is Finished

Move the entire project folder to NAS.

This preserves:

- Original footage
- Project files
- Final renders
- Graphics
- Audio

in one portable structure.

---

# Important Professional Rules

## Safe To Delete

- Cache files
- Render cache
- Optimized media
- Proxy files

These can always be regenerated.

---

## Never Delete Casually

- Original footage
- `.drp` project files
- Final renders

These are the real source assets.

---

# Recommended Editing Habits

## Use Versioned Exports

Example:

```text
short-v01.mp4
short-v02.mp4
short-final.mp4
```

Avoid overwriting old versions.

---

## Use Versioned `.drp` Saves

Example:

```text
short-v01.drp
short-v02.drp
short-final.drp
```

Protects against:

- Corrupted projects
- Bad edits
- Accidental deletions

---

## Keep Active Projects Local

Best workflow:

- Active projects on local SSD
- Cache on fastest SSD
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
- Backup storage

---

# Summary

This workflow gives:

- Professional project organization
- Easier backups
- Safer archives
- Cleaner Resolve setup
- Better long-term scalability
- Faster troubleshooting and media relinking

