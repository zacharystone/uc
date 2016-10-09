
#/bin/bash

latest_version=$(git tag -l | head -n 1)
git archive ${latest_version} --prefix uc/ | bzip2 > uc-${latest_version}.tar.bz2