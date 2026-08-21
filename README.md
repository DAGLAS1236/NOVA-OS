# Nova OS

Projekt: dystrybucja Linux oparta na Ubuntu, lekka i zoptymalizowana. Branding: `Nova OS`.

Pliki i katalogi:
- `scripts/` – skrypty budowy obrazu
- `config/` – konfiguracje live-build i instalatora (Calamares), zasoby brandingu w `config/branding`
- `build.sh` – główny skrypt budujący

Uwaga prawna: nie kopiuj zasobów z oryginalnego Lubuntu (logo, grafiki, nazwy zastrzeżone). Jeśli chcesz dokładnie sklonować wygląd, potwierdź że posiadasz prawa/licencje lub zgadzasz się na zmiany brandingowe.

Kolejne kroki:
1. Dostosuj `config/` (pakiety, środowisko)
2. Uruchom `./build.sh` na maszynie z dostępem do narzędzi `debootstrap`/`live-build`
3. Przetestuj ISO w VM (qemu/virtualbox)
