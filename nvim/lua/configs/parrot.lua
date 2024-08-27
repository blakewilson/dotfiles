require("parrot").setup {
  -- Providers must be explicitly added to make them available.
  providers = {
    anthropic = {
      api_key = os.getenv "ANTHROPIC_API_KEY",
    },
  },
}
