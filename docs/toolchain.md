# Toolchain contract

This repository is currently a publication-held wider-matrix local tranche.

## Planned commands after promotion
- `dart format --set-exit-if-changed .`
- `dart analyze`
- `dart test`
- `mkdir -p build && dart compile exe bin/stakeholder.dart -o build/stakeholder`

## Stability checks
- `python3 scripts/validate_scaffold.py`
- `nix run .#check`

## Current limitation
- Docker remains the portable release gate for runtime promotion, and the live-provider lane is still deferred.

## Validation notes
- Docker is the portable release gate for runtime promotion.
- The current docs/CI surface stays focused on publication-held stability until the repo gains runnable depth.
