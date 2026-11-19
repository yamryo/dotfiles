# auto_updates=true の Cask は各アプリ自身に更新させる
export HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS=1

brew() {
  # 引数なしの `brew upgrade` のときだけ事前チェック
  if [[ "$1" == "upgrade" && $# -eq 1 ]]; then
    local -a installed_casks
    local outdated_self

    installed_casks=("${(@f)$(command brew list --cask)}")

    if (( ${#installed_casks[@]} )); then
      outdated_self="$(
        command brew info --cask --json=v2 "${installed_casks[@]}" |
          jq -r '
            .casks[]
            | select(.auto_updates == true)
            | (.bundle_short_version // "?") as $app
            | (.version | tostring) as $brew
            | select(
                $app == "?"
                or
                (($app | sub("(\\.0)+$"; "")) !=
                 ($brew | sub("(\\.0)+$"; "")))
              )
            | "\(.token): app=\($app)  brew=\($brew)"
          '
      )"
    fi

    echo
    echo "==> Self-updating casks needing attention"
    echo

    if [[ -n "$outdated_self" ]]; then
      print -r -- "$outdated_self"
    else
      echo "All self-updating casks are up-to-date."
    fi

    echo
    read "REPLY?Press Enter to continue with brew upgrade..."
    echo
  fi

  command brew "$@"
}
