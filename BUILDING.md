# Building Nova OS (local)

Prerequisites on Debian/Ubuntu host:

```bash
sudo apt update
sudo apt install -y live-build debootstrap squashfs-tools xorriso qemu-system-x86 zenity
```

Quick build steps (from project root):

```bash
chmod +x build.sh scripts/prepare_live_build.sh
./scripts/prepare_live_build.sh
./build.sh
```

If the build completes, an ISO will be in `live-build/` (example: `live-image-amd64.hybrid.iso`).

Test in QEMU:

```bash
qemu-system-x86_64 -m 2048 -cdrom live-build/live-image-amd64.hybrid.iso -boot d
```

Notes:
- CI is configured in `.github/workflows/build.yml` to produce an ISO artifact on push.
- To customize branding, replace files in `config/branding/` before building.
- The first-run wizard uses `zenity` and is triggered via autostart; it runs once per machine.

Helper scripts included (in `scripts/`):

- `commit_and_push_branding.sh` — commits `config/branding/*` and pushes to the current branch.
- `trigger_ci_by_tag.sh` — creates an annotated tag and pushes it (useful if workflows run on tags).

If you want me to build the ISO for you, I cannot run `live-build` from this environment. Two options:
1. You run the build locally using the steps above.
2. Push this repo to GitHub (or add a remote) and I can prepare commits/scripts; once pushed, GitHub Actions will build the ISO and provide the artifact — if you want that, give me the repo URL or push and tell me to trigger the CI.

Commands to push branding and trigger CI locally:

```bash
chmod +x scripts/commit_and_push_branding.sh scripts/trigger_ci_by_tag.sh
./scripts/commit_and_push_branding.sh
# optionally: ./scripts/trigger_ci_by_tag.sh v0.1.0
```

After CI finishes, download the `nova-iso` artifact from the Actions run.
