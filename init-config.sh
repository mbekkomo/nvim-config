#!/usr/bin/env bash

tee() {
    exec "tee" "$@" >/dev/null
}

prog="$0"

if [[ -n "$NVIMLUA" && -n "$NVIMAFTERLUA" ]]; then
    echo -e "you already setup nvim config!\n"
    echo "variable values:"
    echo "\$NVIMDIR = $NVIMDIR"
    echo "\$NVIMLUA = $NVIMLUA"
    echo "\$NVIMAFTERLUA = $NVIMAFTERLUA"
    exit
fi

SHELL="${SHELL##*/}"

nvimpath="$(dirname "$(realpath "$prog")")"
case "$SHELL" in
    sh|bash|zsh)
        code="$(cat << EOF

# start nvim config
export NVIMDIR="$nvimpath"
export NVIMLUA="$nvimpath/lua"
export NVIMAFTERLUA="$nvimpath/after_lua"
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
set -gx NVIMDIR "$nvimpath"
set -gx NVIMLUA "$nvimpath/lua"
set -gx NVIMAFTERLUA "$nvimpath/after_lua"
# end nvim config
EOF
)"
        echo "$code" | tee -a "$HOME/.config/fish/config.fish"
    ;;
    *)
        echo -e "unsupported shell: $SHELL\n"
        echo -e "to setup nvim config manually, set this environment variable below\n"
        echo "-------------------------------"
        echo "    VARIABLE    |    VALUE"
        echo "-------------------------------"
        echo " \$NVIMDIR       | \"$nvimpath\""
        echo " \$NVIMLUA       | \"$nvimpath/lua\""
        echo " \$NVIMAFTERLUA  | \"$nvimpath/after_lua\""
        echo "-------------------------------"
        exit 1
esac

echo "successfully config nvim"
echo "run \`exec $SHELL\` and open nvim to see changes"
