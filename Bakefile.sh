#!/usr/bin/env -S ./bake
# vim: set ft=bash

ROOT="$PWD"

task.buildpkg() {
  [[ -n "$1" ]] || bake.die "Specify at least one package to build"

  bake.assert_cmd abuild
  while read -r pkg; do
    [[ -d "./packages/$pkg" ]] || {
      bake.warn "'$pkg' is not a package, skipped..."
      continue
    }
    pushd "./packages/$pkg"
    abuild -cr -P "$ROOT/repo" -s . || bake.die "Could not build '$pkg' package"
    ls -a
    popd
  done <<<"$*"
}
