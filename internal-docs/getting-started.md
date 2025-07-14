# Getting Started: Managing Your Dotfiles with chezmoi

This guide walks you through the first steps to take control of your dotfiles using chezmoi and the Docker-based tooling provided in this repository.

---

## 1. Build the Docker Image

```bash
bin/chezmoi-docker --build
```

---

## 2. Initialize chezmoi in Your Repository

### A. Start Fresh
If you have no existing chezmoi config:
```bash
bin/chezmoi-docker init --source /dotfiles
```
This sets up chezmoi to use your local repository as the source.

### B. Import Existing Dotfiles
For each file you want to manage, run:
```bash
bin/chezmoi-docker add ~/.bashrc
bin/chezmoi-docker add ~/.zshrc
bin/chezmoi-docker add ~/.gitconfig
# ...add any other files you want to control
```
This copies the file into the chezmoi-managed directory structure in your repo.

---

## 3. Review and Commit Changes

Check what chezmoi will manage:
```bash
bin/chezmoi-docker status
bin/chezmoi-docker diff
```
Commit the changes to your Git repository:
```bash
git add .
git commit -m "Add initial dotfiles to chezmoi"
git push
```

---

## 4. Apply Dotfiles to Your System

```bash
bin/chezmoi-docker apply
```
This will copy the managed files from your repo to your home directory.

---

## 5. Test in a Clean Environment (Optional)

You can use the test container to verify your dotfiles:
```bash
docker-compose -f docker/docker-compose.test.yml up -d
docker-compose -f docker/docker-compose.test.yml exec test bash
chezmoi init --source /dotfiles
chezmoi apply -v
```

---

## 6. Ongoing Management

- Add or update files as needed with `bin/chezmoi-docker add <file>`.
- Edit templates, scripts, or configuration as desired.
- Use `bin/chezmoi-docker diff` and `bin/chezmoi-docker apply` to propagate updates.

---

## Security & Best Practices

- Never store secrets (SSH keys, passwords) in plaintext in your repo.
- Use chezmoi’s encryption features for secrets (`chezmoi secret`).
- Regularly commit and push your changes for backup/versioning.
- Test changes in the test container before applying to your real system.

---

For advanced usage, cross-platform tips, and security, see the other docs in `internal-docs/`.
