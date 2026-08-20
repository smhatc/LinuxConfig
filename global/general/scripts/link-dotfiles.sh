# Symlinking repo dotfiles to system's "~/" and "~/.config" directories
echo -e "${process_icon} Symlinking repo dotfiles to system's \"~/\" and \"~/.config\" directories...\n"

# Ensure dotfiles aren't ignored
shopt -s dotglob nullglob

# Reusable function for both ~/ and ~/.config runs
link_dotfiles() {
    local repo_config_dotfiles=$1
    local system_config_dir=$2

    mkdir -p "$system_config_dir"

    for src_path in "$repo_config_dotfiles"/*; do
        local app_name="$(basename "$src_path")"
        local dst_path="${system_config_dir}/${app_name}"
        local abs_src_path="$(realpath "$src_path")"

        # Back up existing real files just in case
        if [[ -e "$dst_path" && ! -L "$dst_path" ]]; then
            echo "${process_icon} Backing up existing ${dst_path} to ${dst_path}.bak..."
            mv "$dst_path" "${dst_path}.bak"
        fi

        ln -sfn "$abs_src_path" "$dst_path"
        echo "${success_icon} Linked \"${app_name}\"."
    done
}

# "~/" dotfiles
link_dotfiles "./global/general/configurations/home" "${HOME}"

# "~/.config" dotfiles
link_dotfiles "./global/general/configurations/.config" "${HOME}/.config"

# Prevent unintended behavior in the rest of setup.sh
shopt -u dotglob nullglob

echo -e "\n${success_icon} Finished symlinking repo dotfiles to system's \"~/\" and \"~/.config\" directories."
