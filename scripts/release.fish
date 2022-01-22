#!/usr/bin/env fish


function die
  echo "$argv[1]"
  exit 255
end

function run
  set cmd $argv
  eval "$cmd"; or die "An error occurred while executing: $cmd"
end


set rootDir (dirname (realpath (status dirname)))

run $rootDir/scripts/pre-version-check.fish


set NPM_VERSION $argv[1]

if test -z "$NPM_VERSION"
  echo "package version must be provided"
  exit 255
end



echo "Pushing --all"
run git push --all

echo "Pushing --tags"
run git push --tags

echo "Publishing > NPM"
run yarn publish . --from-package --non-interactive --tag $NPM_VERSION --registry=http://registry.npmjs.org

git push --all

echo "Successfully released version $NPM_VERSION!"