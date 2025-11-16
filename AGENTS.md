# AGENTS.md

## Build/Lint/Test Commands

- **Lint**: `shellcheck src/**/*.sh` (runs on all shell scripts)
- **Test**: No formal test suite - manual testing by loading theme in tmux
- **Install theme**: Add `set -g @plugin 'fabioluciano/tmux-tokyo-night'` to `.tmux.conf` and run `prefix + I`

## Code Style Guidelines

### Shell Script Conventions
- Use `#!/usr/bin/env bash` shebang
- Set `set -euxo pipefail` for strict error handling
- Use `local` for function variables
- Quote all variables: `"$VAR"` not `$VAR`
- Use `$(command)` for command substitution, not backticks

### Naming Conventions
- Functions: `snake_case` with descriptive names (e.g., `generate_left_side_string`)
- Variables: `snake_case` for local vars, `UPPER_SNAKE_CASE` for exported/config vars
- Plugin variables: `plugin_<name>_<property>` pattern (e.g., `plugin_datetime_icon`)
- Palette: Use associative array `PALLETE[key]` format

### File Organization
- Main theme logic in `src/theme.sh`
- Utilities in `src/utils.sh`
- Color palettes in `src/palletes/*.sh`
- Individual plugins in `src/plugin/*.sh`
- Each plugin script must export its configuration variables

### Error Handling
- Always check if plugin files exist before sourcing
- Use `get_tmux_option()` with default values for all configuration
- Handle tmux version compatibility gracefully
- Use `&>/dev/null` for optional tmux features

### Import Pattern
```bash
# shellcheck source=src/utils.sh
. "$CURRENT_DIR/utils.sh"
```

### Plugin Structure
- Define configuration variables using `get_tmux_option()`
- Implement `load_plugin()` function that outputs content
- Export all configuration variables at script end
- Use consistent color variable naming with palette references