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

run mkdir -p lib/mjs lib/cjs
echo '{
    "type": "commonjs",
    "main": "./index.js",
    "module": "./index.js"
}' >lib/cjs/package.json

echo '{
    "type": "module",
    "main": "./index.js",
    "module": "./index.js"
}' >lib/mjs/package.json

set tscArgs -b tsconfig.json $argv --preserveWatchOutput

echo "Building with args: $tscArgs"
run ttsc $tscArgs

echo "$PWD/lib successfully built"
