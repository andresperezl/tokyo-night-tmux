#!/usr/bin/env bash

SHOW_KUBECTX=$(tmux show-option -gv @tokyo-night-tmux_show_kctx)
if [ "$SHOW_KUBECTX" == "0" ]; then
  exit 0
fi

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/../lib/coreutils-compat.sh"
source "$CURRENT_DIR/themes.sh"

KUBECTX=$(kubectl config current-context)
if [ -z "$KUBECTX" ]; then
    echo ""
    exit 0
fi

KUBENAMESPACE=$(kubectl config view --minify --flatten -o jsonpath="{.contexts[?(@.name==\"${KUBECTX}\")].context.namespace}")
fg=${THEME[green]}
[[ $KUBECTX == *prd* ]] && fg=${THEME[red]}
[[ $KUBECTX == *stg* ]] && fg=${THEME[yellow]}

echo "$RESET▒ #[fg=$fg,bg=${THEME[background]}] 󱃾 ${KUBECTX}/${KUBENAMESPACE} $RESET"

