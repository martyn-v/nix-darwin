{ config, lib, ... }:
{
  options.home.file = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule ({config, ...}: {
      options.mutable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether the file should be mutable.";
      };
    }));
  };

  config.home.activation = lib.mkIf (lib.any (f: f.mutable) (lib.attrValues config.home.file)) {
    mutableFiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${lib.concatStrings (lib.mapAttrsToList (n: f: lib.optionalString f.mutable ''
        $DRY_RUN_CMD cp --remove-destination ${lib.escapeShellArg f.source} $HOME/${lib.escapeShellArg n}
      '') config.home.file)}
    '';
  };
}
