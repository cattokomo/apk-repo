#!/usr/bin/env bash

task.buildpkg() {
  [[ -n "$1" ]] || bake.die "Specify at least one package to build"

  bake.assert_cmd abuild
  while read -r pkg; do
    [[ -d "./packages/$pkg" ]] || {
      bake.warn "'$pkg' is not a package, skipped..."
      continue
    }
    pushd "./packages/$pkg"
    abuild -cr || bake.die "Could not build '$pkg' package"
    ls -a
    popd
  done <<<"$*"
}
