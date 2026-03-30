#!/bin/bash
cd /mnt/d/GitHub/cydia
dpkg-scanpackages -m debs /dev/null > Packages
bzip2 -c Packages > Packages.bz2
apt-ftparchive release . > Release
git add .
git commit -m "Update repo"
git push
echo "Done!"