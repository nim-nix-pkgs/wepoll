{
  description = ''Windows epoll wrapper.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-wepoll-master.flake = false;
  inputs.src-wepoll-master.ref   = "refs/heads/master";
  inputs.src-wepoll-master.owner = "xflywind";
  inputs.src-wepoll-master.repo  = "wepoll";
  inputs.src-wepoll-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-wepoll-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-wepoll-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}