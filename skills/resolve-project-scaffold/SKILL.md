---
name: resolve-project-scaffold
description: "Use when you want to scaffold a new DaVinci Resolve project folder structure under ~/Movies/yt/."
---

This skill helps create a new Resolve project directory tree following the workflow in `docs/davinci_resolve_macos_workflow_documentation.md`.

Use when:
- the user wants a new project scaffold for Resolve
- the user wants the folder structure based on `~/Movies/yt/`
- the user wants consistent project setup for both shorts and regular videos

What to do:
1. Ask for the project identifier or title in the form `NNN-project-name`.
2. Ask whether the project is a normal video or a short-form project.
3. Build the folder path:
   - normal video: `~/Movies/yt/<project-name>/`
   - short-form project: `~/Movies/yt/shorts/<project-name>/`
4. Create the recommended subfolders:
   - `01_Footage/`
   - `02_Audio/`
   - `03_Graphics/`
   - `05_Project/`
   - `06_Renders/`
   - `07_Proxies/`
5. Present the directory tree and a ready-to-run command such as:
   ```bash
   mkdir -p ~/Movies/yt/<project-name>/{01_Footage,02_Audio,03_Graphics,05_Project,06_Renders,07_Proxies}
   ```

Quality criteria:
- Use the `yt/` root consistently
- Keep the folder names and numbering consistent with the documented workflow
- Avoid extra folders not part of the standard structure
- Offer the option to create the project under `shorts/` when applicable

If the user asks for a brief summary, provide:
- the chosen root path
- the subfolder list
- the reason each folder exists, in one sentence per folder
