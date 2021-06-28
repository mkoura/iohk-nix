{ stdenv, lib, fetchFromGitHub, autoreconfHook }:

stdenv.mkDerivation rec {
  name = "libsodium-1.0.18";

  src = fetchFromGitHub {
    owner = "input-output-hk";
    repo = "libsodium";
    rev = "b397839b58ccfd09dde2191c7e1b67d47184f6b0";
    sha256 = "sha256-I4rXYV7Y+XcxKvTEevgzhi7ghxkQD1O+iw4FJmay0ns=";
  };

  nativeBuildInputs = [ autoreconfHook ];

  configureFlags = "--enable-static";

  outputs = [ "out" "dev" ];
  separateDebugInfo = stdenv.isLinux && stdenv.hostPlatform.libc != "musl";

  enableParallelBuilding = true;

  doCheck = true;

  meta = with lib; {
    description = "A modern and easy-to-use crypto library - VRF fork";
    homepage = "http://doc.libsodium.org/";
    license = licenses.isc;
    maintainers = [ "tdammers" "nclarke" ];
    platforms = platforms.all;
  };
}
