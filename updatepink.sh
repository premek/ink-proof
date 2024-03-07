#!/bin/env sh
if [ -z "$1" ]; then echo "No argument supplied"; exit; fi

COMMIT="$1"
ZIP="\     'https://github.com/premek/pink/archive/$COMMIT.zip',"
SHA="\     '$(wget --quiet -O - https://github.com/premek/pink/archive/$COMMIT.zip|sha1sum | awk '{print $1}')',"
MSG="update pink, $(./proof.py pink_compiler pink_runtime)"

sed -i -e "/pink.zip/{n;c$ZIP" -e "}" install_deps.py
sed -i -e "/pink.zip/{n;n;c$SHA" -e "}" install_deps.py

git diff
echo continue?
read x
git add install_deps.py
git commit -m "$MSG"
git show HEAD --no-patch
echo push?
read x
git push
