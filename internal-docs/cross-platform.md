# Managing Dotfiles Across Multiple Operating Systems with chezmoi

Chezmoi makes it easy to manage your dotfiles for Windows, Linux, and macOS from a single repository. Here’s how to do it securely and robustly:

---

## 1. Leverage chezmoi’s OS-Specific Templates

Chezmoi uses the Go template engine, which allows you to conditionally include/exclude content or files based on the OS.

### A. OS-Specific Files
- Add a file for a specific OS by appending `.tmpl` and an OS qualifier:
  - `dot_bashrc.tmpl` (common for all)
  - `dot_bashrc.tmpl.windows` (Windows only)
  - `dot_bashrc.tmpl.darwin` (macOS only)
  - `dot_bashrc.tmpl.linux` (Linux only)

**Example:**
```
dot_bashrc.tmpl
dot_bashrc.tmpl.darwin
dot_bashrc.tmpl.linux
dot_bashrc.tmpl.windows
```
Chezmoi will apply the correct file for each OS.

### B. OS-Specific Content in Templates
Within a `.tmpl` file, use Go templating:

```gotemplate
{{ if eq .chezmoi.os "linux" }}
# Linux-specific config
{{ end }}
{{ if eq .chezmoi.os "windows" }}
# Windows-specific config
{{ end }}
{{ if eq .chezmoi.os "darwin" }}
# macOS-specific config
{{ end }}
```

---

## 2. Directory and File Naming Conventions

- Prefix files with `dot_` for dotfiles (e.g., `dot_bashrc` for `.bashrc`).
- Use `private_` for files that should be encrypted (e.g., `private_ssh/id_rsa`).
- Use `.tmpl` for any file that should be processed as a template.

---

## 3. Testing on Each OS

- Use the Docker test container for Linux.
- For Windows: Run chezmoi natively (or in WSL), using the same repo.
- For macOS: Run chezmoi natively or in a VM/container.

---

## 4. Example: Managing .bashrc for All OSs
- `dot_bashrc.tmpl` (shared)
- `dot_bashrc.tmpl.linux` (Linux-specific)
- `dot_bashrc.tmpl.darwin` (macOS-specific)
- `dot_bashrc.tmpl.windows` (Windows-specific)

Chezmoi will automatically pick the right file for the target OS.

---

## 5. Advanced: Hostname/User/Arch Specificity
You can also target by hostname, username, or architecture:
- `dot_bashrc.tmpl.hostname-myhost`
- `dot_bashrc.tmpl.username-levonk`
- `dot_bashrc.tmpl.arch-amd64`

---

## 6. Security & Compliance
- Never put secrets in plaintext—use `chezmoi secret`.
- Use `.chezmoiignore` to exclude files from certain hosts or OSs.
- Test your templates for all supported OSs in isolated environments (VM, container, WSL).

---

## 7. References
- [Chezmoi OS-specific Templates Documentation](https://www.chezmoi.io/user-guide/templates/#os-specific-templates)
- [Chezmoi Dotfile Naming Conventions](https://www.chezmoi.io/user-guide/dotfiles/)

---

**Tip:**
Would you like a practical example/template for a specific dotfile across multiple OSs? Let your team know which configs you want to see as a sample!
