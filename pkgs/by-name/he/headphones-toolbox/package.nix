{ lib
, stdenv
, dpkg
, fetchurl
, autoPatchelfHook
, webkitgtk
}:

stdenv.mkDerivation (finalAttrs: {
  name = "headphones-toolbox";
  version = "0.0.3";

  src = fetchurl {
    url = "https://github.com/george-norton/headphones-toolbox/releases/download/headphones-toolbox-beta-v4r2/ploopy-headphones-toolbox_${finalAttrs.version}_amd64.deb";
    hash = "sha256-r+ybcD6koSIJ/6cck3RNXmf758sRnhS1Y4kaYCNbveA=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
  ];

  buildInputs = [
    webkitgtk
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mv usr/bin $out
    mv usr/lib $out
    mv usr/share $out

    runHook postInstall
  '';

  meta = with lib; {
    description = "A UI for configuring Ploopy Headphones";
    homepage = "https://github.com/george-norton/headphones-toolbox";
    maintainers = with maintainers; [ knarkzel nyanbinary ];
    license = licenses.gpl3Only;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "headphones-toolbox";
  };
})
