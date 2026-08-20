# This file is read each time a login shell is started
# All interactive shells will read ".bashrc" instead

# Source "/etc/profile" only once if not already sourced to initialize global environment settings
[[ -z "$PROFILEREAD" ]] && source /etc/profile || true

