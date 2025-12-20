{
  buildPythonPackage,
  fetchFromGitHub,

  hatchling,

  mcp,
  python-dotenv,
  zenpy,
}:

buildPythonPackage rec {
  pname = "zendesk-mcp-server";
  version = "3410b0d6efa19b99781ede4f536c6a6e565a879a";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "reminia";
    repo = "zendesk-mcp-server";
    rev = version;
    sha256 = "sha256-ew34z3ltrj2ovJSAQS9Eqg/f+Klw6nTon455bbLY4rg=";
  };

  postPatch = ''
        substituteInPlace src/zendesk_mcp_server/server.py \
          --replace-fail "from mcp.server import Server, types" "import mcp.types as types
    from mcp.server.lowlevel import Server"
  '';

  build-system = [
    hatchling
  ];

  dependencies = [
    mcp
    python-dotenv
    zenpy
  ];

  meta = {
    mainProgram = "zendesk";
  };
}
