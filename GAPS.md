> [!NOTE]
> Missing or deferred behavior must fail fast and be tracked explicitly. No placeholder behavior should mask absent parity work.

# Dart Gaps

## Current explicit gaps
- `dart-stakeholder.foundation-pending`: deterministic scheduler, CLI wiring, and runtime skeleton are not implemented yet.
- `dart-stakeholder.classic-six-pending`: classic-six dedicated renderer depth is not implemented yet.
- `dart-stakeholder.modern-core-pending`: modern-core dedicated renderer depth is not implemented yet.
- `dart-stakeholder.post-modern-core-pending`: later packet families remain unimplemented.
- `dart-stakeholder.traceability-rows-pending`: traceability rows will be added when real behavior is promoted from scaffold to implementation.
- `dart-stakeholder.codeql-activation-pending`: CodeQL activation is deferred until the repo contains source-bearing implementation files in a supported language.
- `dart-stakeholder.flake-lock-pending`: `flake.nix` is present, but `flake.lock` was not generated during scaffold bootstrap because `nix` is unavailable in the current local environment.

## Guardrail
- Do not present this scaffold as an implementation-complete parity port.
