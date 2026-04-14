{
  description = "stakeholder-circus dart-stakeholder";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      devShells = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; };
        in {
          default = pkgs.mkShell {
            packages = with pkgs; [ dart git jq python312 ];
          };
        });
      apps = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; };
            mk = name: text: {
              type = "app";
              program = "${pkgs.writeShellScript name text}";
            };
        in {
          build = mk "build" ''mkdir -p build && dart pub get && dart analyze && dart test && dart compile exe bin/stakeholder.dart -o build/stakeholder'';
          test = mk "test" ''dart pub get && dart test'';
          check = mk "check" ''mkdir -p build && python3 scripts/validate_scaffold.py && dart pub get && dart format --set-exit-if-changed . && dart analyze && dart test && dart compile exe bin/stakeholder.dart -o build/stakeholder'';
          format = mk "format" ''dart format .'';
        });
    };
}
