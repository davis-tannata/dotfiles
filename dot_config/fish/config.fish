if status is-interactive
    # === Homebrew ===
    /opt/homebrew/bin/brew shellenv | source

    # === Environment ===
    set -gx EDITOR "nvim"
    set -gx VISUAL "nvim"

    # === Consolidated PATH ===
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/.local/scripts
    fish_add_path $HOME/development/flutter/bin
    fish_add_path $HOME/.gem/bin
    fish_add_path $HOME/.pub-cache/bin
    fish_add_path $HOME/.fvm_flutter/bin
    fish_add_path $HOME/.rvm/bin

    # === NVM (via bass) ===
    set -gx NVM_DIR "$HOME/.nvm"
    bass source "$NVM_DIR/nvm.sh" --no-use ';' nvm use default --silent
    function nvm
        bass source "$NVM_DIR/nvm.sh" --no-use ';' nvm $argv
    end

    # === SDKMAN (via bass) ===
    set -gx SDKMAN_DIR "$HOME/.sdkman"
    bass source "$SDKMAN_DIR/bin/sdkman-init.sh"
    function sdk
        bass source "$SDKMAN_DIR/bin/sdkman-init.sh" ';' sdk $argv
    end

    # === Pyenv ===
    set -gx PYENV_ROOT "$HOME/.pyenv"
    fish_add_path $PYENV_ROOT/bin
    pyenv init - fish | source

    # === Local environment file ===
    test -f $HOME/.local/bin/env && source $HOME/.local/bin/env

    # === Aliases ===
    alias flutter "fvm flutter"
    alias dart "fvm dart"

    # === Keybindings ===
    function __tmux_sessionizer
        tmux-sessionizer
        commandline -f repaint
    end
    bind \cf __tmux_sessionizer

    # === TMUX window renaming ===
    if set -q TMUX
        function __tmux_rename_window --on-event fish_preexec
            tmux rename-window -- (string sub -l 20 -- $argv[1])
        end
    end
end
