require("lspconfig").yamlls.setup({
  settings = {
    yaml = {
      schemas = {
        ["https://goauthentik.io/blueprints/schema.json"] = "**/*authentik-provider.y*ml",
      },
    },
  },
})
