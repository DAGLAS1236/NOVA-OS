#!/usr/bin/env bash
set -euo pipefail

# Rozszerzony skrypt budujący obraz live/iso oparty na live-build.
# Wymagane: sudo, debootstrap, live-build (lb), squashfs-tools, xorriso

WORKDIR=$(cd "$(dirname "$0")" && pwd)
LB_DIR="$WORKDIR/live-build"
CONFIG_DIR="$WORKDIR/config"
PACKAGE_LIST="$CONFIG_DIR/package-lists/lubuntu-clone.list.chroot"

echo "Rozpoczynam budowę obrazu..."
mkdir -p "$LB_DIR"

if ! command -v lb >/dev/null 2>&1; then
	echo "live-build (lb) nie znaleziony. Zainstaluj pakiet 'live-build' i spróbuj ponownie." >&2
	exit 1
fi

if [ ! -f "$PACKAGE_LIST" ]; then
	echo "Lista pakietów nie znaleziona: $PACKAGE_LIST"
	echo "Uruchamiam skrypt przygotowujący listę pakietów..."
	"$WORKDIR/scripts/prepare_live_build.sh"
fi

echo "Konfiguruję live-build (lb)..."
cd "$LB_DIR"

# Usuń poprzedni stan, aby stare pakiety nie mieszały się z nową bazą systemu.
sudo lb clean --purge >/dev/null 2>&1 || true

# Skopiuj konfiguracje projektu do katalogu live-build/config
rm -rf config
mkdir -p config
cp -r "$CONFIG_DIR/"* config/ || true

# Upewnij się, że lista pakietów jest tam, gdzie lb jej oczekuje
mkdir -p config/package-lists
cp -f "$PACKAGE_LIST" config/package-lists/lubuntu-clone.list.chroot

# Nadaj prawa wykonywania hookom i skryptom przygotowanym do chroot
find config -type f -name "*.sh" -exec chmod +x {} + || true
find config -type f -name "*.chroot" -exec chmod +x {} + || true

# Prosty lb config; rozbuduj według potrzeb w katalogu config/
lb config \
	--archive-areas "main restricted universe multiverse" \
	--distribution jammy \
	--binary-images iso-hybrid \
	--apt-indices false \
	--bootappend-live "boot=live components"

echo "Uruchamiam lb build (to może potrwać)..."
sudo lb build

ISO_PATH="$LB_DIR/live-image-amd64.hybrid.iso"
if [ -f "$ISO_PATH" ]; then
	echo "Gotowe. ISO: $ISO_PATH"
	echo "Możesz przetestować w QEMU: ./build.sh --test"
else
	echo "Budowa zakończona, ale nie znaleziono oczekiwanego ISO. Sprawdź wyjście lb." >&2
fi

if [ "${1-}" = "--test" ]; then
	if command -v qemu-system-x86_64 >/dev/null 2>&1; then
		echo "Uruchamiam ISO w QEMU..."
		qemu-system-x86_64 -m 2048 -cdrom "$ISO_PATH" -boot d
	else
		echo "qemu-system-x86_64 nie jest zainstalowane; pomiń test lub zainstaluj qemu." >&2
	fi
fi

echo "Build script finished."
