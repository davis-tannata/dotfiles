if status is-interactive
    /opt/homebrew/bin/brew shellenv | source
end

# --- NVM (via bass; mirrors old zsh `nvm.sh` sourcing) ---
set -gx NVM_DIR "$HOME/.nvm"
if status is-interactive
    bass source "$NVM_DIR/nvm.sh" --no-use ';' nvm use default --silent
end
function nvm
    bass source "$NVM_DIR/nvm.sh" --no-use ';' nvm $argv
end

# --- SDKMAN (via bass; THIS MUST STAY NEAR THE END LIKE THE OLD ZSHRC) ---
set -gx SDKMAN_DIR "$HOME/.sdkman"
if status is-interactive
    bass source "$SDKMAN_DIR/bin/sdkman-init.sh"
end
function sdk
    bass source "$SDKMAN_DIR/bin/sdkman-init.sh" ';' sdk $argv
end

# --- pyenv ---
set -gx PYENV_ROOT "$HOME/.pyenv"
fish_add_path $PYENV_ROOT/bin
if status is-interactive
    pyenv init - fish | source
end

# --- RVM ---
fish_add_path $HOME/.rvm/bin

# --- misc PATH ---
fish_add_path $HOME/development/flutter/bin
fish_add_path $HOME/.gem/bin
fish_add_path $HOME/.pub-cache/bin
fish_add_path $HOME/.fvm_flutter/bin

# scripts referenced by name (e.g. tmux-sessionizer) elsewhere in dotfiles
fish_add_path $HOME/.local/scripts

if status is-interactive
    alias flutter "fvm flutter"
    alias dart "fvm dart"

    # Ctrl+F at the shell prompt launches tmux-sessionizer (mirrors old zsh `bindkey -s '^f' ...`)
    function __tmux_sessionizer
        tmux-sessionizer
        commandline -f repaint
    end
    bind \cf __tmux_sessionizer

    # rename tmux window to the last command run (e.g. nvim, flutter run, claude)
    if set -q TMUX
        function __tmux_rename_window --on-event fish_preexec
            tmux rename-window -- (string sub -l 20 -- $argv[1])
        end
    end
end
