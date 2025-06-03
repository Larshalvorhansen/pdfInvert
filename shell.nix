# shell.nix
{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "invert-pdf-env";

  buildInputs = [ pkgs.imagemagick pkgs.ghostscript ];

  shellHook = ''
    echo "PDF inversion environment ready. Run ./invert-pdf.sh input.pdf output.pdf"
  '';
}
