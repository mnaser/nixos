{
  buildPythonPackage,
  fetchPypi,

  setuptools,

  requests,
  python-dateutil,
  cachetools,
  pytz,
  six,
}:

buildPythonPackage rec {
  pname = "zenpy";
  version = "2.0.56";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-mEzc2T3eXXD6Di1cHRh4uHANwm32PKNBT2tVV3Qjyxw=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    requests
    python-dateutil
    cachetools
    pytz
    six
  ];
}
