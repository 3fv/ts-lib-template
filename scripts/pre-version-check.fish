#!/usr/bin/env fish


function die
  echo "$argv[1]"
  exit 255
end

function run
  set cmd $argv
  eval "$cmd"; or die "An error occurred while executing: $cmd"
end


if not git diff --quiet
  die "uncommited changed, commit and retry"
end

