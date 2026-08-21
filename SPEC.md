# Specyfikacja dystrybucji "Lubuntu Clone"

Krótki opis:
- Bazowana na: Ubuntu LTS (domyślnie 20.04/22.04 focal/jammy — wybór w `build.sh`)
- Środowisko: LXQt (lekki, podobny do Lubuntu)
- Instalator: Calamares (konfigurowalny)
- Branding: własny (użytkownik potwierdzi grafiki i nazwy)

Główne założenia:
- Lekka i responsywna dystrybucja dla starych i nowszych komputerów.
- Domyślne aplikacje: przeglądarka, menedżer plików, narzędzia sieciowe, terminal.
- Obsługa instalatora z partycjonowaniem, tworzeniem użytkownika, instalacją bootloadera.

Pakiety kluczowe:
- LXQt, lxqt-panel, pcmanfm-qt/pcmanfm, lightdm, network-manager, sudo, ssh

Branding:
- Używamy własnych grafik i nazw: `lubuntu-clone` (tymczasowa robocza nazwa)
- Umieść swoje logo w `config/branding/logo.png` i pliki tematów w `config/branding/`.

Wymagania do budowy:
- System z zainstalowanymi: `live-build`, `debootstrap`, `squashfs-tools`, `xorriso`, `qemu` (opcjonalnie)
- Uprawnienia sudo dla polecenia `lb build` oraz instalacji pakietów.

Testowanie:
- Testuj w VM (qemu/virtualbox).

Notatka prawna:
- Nie kopiuj chronionych zasobów Lubuntu bez zgody. Upewnij się, że grafiki, nazwy i materiały są Twojego autorstwa lub mają odpowiednią licencję.
