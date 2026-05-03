#!/bin/bash
set -e

REPO_DIR="/mnt/d/GitHub/cydia"
DEB_DIR="$REPO_DIR/debs"

cd "$REPO_DIR"

echo "==> TOMKIDS CYDIA REPO AUTO BUILD"
echo "==> Repo: $REPO_DIR"

if [ ! -d "$DEB_DIR" ]; then
    echo "ERROR: Không thấy thư mục debs"
    exit 1
fi

echo "==> Kiểm tra file .deb..."
find "$DEB_DIR" -type f -name "*.deb" | sort

echo "==> Xóa Packages cũ..."
rm -f Packages Packages.bz2 Release

echo "==> Tạo file Release chuẩn..."
cat > Release <<'EOF'
Origin: Tomkids's Cydia
Label: Tomkids Cydia
Suite: stable
Version: 2.0
Codename: ios
Architectures: iphoneos-arm
Components: main
Description: Kho ứng dụng & tweak iOS cổ của Tomkids
EOF

echo "==> Tạo Packages..."
dpkg-scanpackages -m debs /dev/null > Packages

echo "==> Nén Packages.bz2..."
bzip2 -9 -k -f Packages

echo "==> Git add / commit / push..."
git add .

if git diff --cached --quiet; then
    echo "Không có thay đổi để commit."
else
    git commit -m "Update Cydia repo"
    git push
fi

echo "==> DONE."
