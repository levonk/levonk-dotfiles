---
trigger: manual
---

Prefix all responses with 🤖. You are an expert engineer specializing in well architected software. Keep project details confidential. No sharing or training on secure data.

# Ignore File Structure and Patterns

This document explains the structure and purpose of the ignore files in this project, designed to be AI-friendly and help with maintenance and understanding of the ignore patterns.

## File Types and Their Purposes

### 1. `.ignorefile` Files
These are the primary files containing the actual ignore patterns that will be used by various tools. They follow standard `.gitignore` format and are organized by category.

### 2. `.ignorefile.md` Files
These are documentation files that describe the purpose and contents of the corresponding `.ignorefile`. They include:
- Purpose of the ignore patterns
- Source files included
- Last generated timestamp
- Any special considerations

## Core Ignore Files

### `ai.ignorefile` & `ai.ignorefile.md`
- **Purpose**: Patterns for AI-generated files and directories
- **Example**: `/generated-code/`
- **Used by**: AI tools like Codeium, Cursor, etc.

### `dev.ignorefile` & `dev.ignorefile.md`
- **Purpose**: Development-specific files that should be excluded from production builds
- **Includes**:
  - Credentials and secrets
  - Local development configurations
  - Platform-specific files (macOS, Windows)
  - Build artifacts
- **Used by**: Build tools, package managers

### `garbage.ignorefile` & `garbage.ignorefile.md`
- **Purpose**: System files, temporary files, and other non-essential files
- **Includes**:
  - OS-specific files (`.DS_Store`, `Thumbs.db`)
  - Editor/IDE files
  - Temporary files
  - Build outputs
- **Used by**: Version control, build systems

### `security.ignorefile` & `security.ignorefile.md`
- **Purpose**: Sensitive files that should never be committed
- **Includes**:
  - Credentials and API keys
  - Local overrides
  - Sensitive configuration files
  - Backup files with sensitive data
- **Used by**: Pre-commit hooks, security scanners

## Pattern Syntax

- `#` - Comment
- `*` - Wildcard (matches any characters)
- `?` - Matches any single character
- `[]` - Character ranges
- `!` - Negation (include pattern)
- `/` - Directory separator
- `**` - Recursive directory matching

## Best Practices for Maintenance

1. **Keep patterns specific** - Avoid overly broad patterns
2. **Use comments** - Document non-obvious patterns
3. **Organize logically** - Group related patterns together
4. **Test changes** - Verify patterns work as expected
5. **Update documentation** - Keep `.md` files in sync with pattern files

## How to Add New Patterns

1. Identify the appropriate category for your pattern
2. Add the pattern to the relevant `.ignorefile`
3. Update the corresponding `.ignorefile.md` if needed
4. Test the pattern locally
5. Commit both the pattern and documentation changes

## Common Pitfalls

- Overlapping patterns between files
- Overly broad patterns that might exclude needed files
- Forgetting to update documentation when patterns change
- Platform-specific patterns that might not work across all operating systems
