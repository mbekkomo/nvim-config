#!/usr/bin/env bash

tee() {
    exec "tee" "$@" >/dev/null
}

prog="$0"

if [[ -n "$NVIMLUA" && -n "$NVIMAFTERLUA" ]]; then
    exit
fi

SHELL="${SHELL##/}"
case "$SHELL" in
    sh|bash|zsh)
        code="$(cat << EOF

# start nvim config
export NVIMLUA="$(realpath "$prog")/lua"
export NVIMAFTERLUA="$(realpath "$prog")/after_lua"
# end nvim config
EOF
)"
        if [[ "$SHELL" = sh ]]; then
            echo "$code" | tee -a "$HOME/.profile"
        elif [[ "$SHELL" = bash ]]; then
            echo "$code" | tee -a "$HOME/.bashrc"
        elif [[ "$SHELL" = zsh ]]; then
            echo "$code" | tee -a "$HOME/.zshrc"
        fi
    ;;
    *fish)
        code="$(cat << EOF

# start nvim config
set -gx NVIMLUA "$(realpath "$prog")/lua"
set -gx NVIMAFTERLUA "$(realpath "$prog")/after_lua"
# end nvim config
EOF
)"
        echo "$code" | tee -a "$HOME/.config/fish/config.fish"
    ;;
esac

echo "successfully config nvim"
echo 'run `exec $SHELL` and open nvim to see changes'
