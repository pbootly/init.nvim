-- `coursier install metals`
local metals_bin = vim.fn.executable("metals") == 1 and "metals"
  or vim.fn.expand("~/Library/Application Support/Coursier/bin/metals")

return {
  cmd = { metals_bin },
  filetypes = { "scala", "sbt" },
  root_markers = { "build.sbt", "build.sc", "build.gradle", "pom.xml", ".scala-build" },
  init_options = {
    statusBarProvider = "off",
  },
  capabilities = {
    workspace = {
      didChangeWatchedFiles = { dynamicRegistration = false },
    },
  },
  settings = {
    metals = {
      showImplicitArguments = true,
      showInferredType = true,
    },
  },
}
