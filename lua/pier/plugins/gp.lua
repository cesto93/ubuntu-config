return {
	"robitx/gp.nvim",
	config = function()
		local conf = {
			providers = {
				ollama = { 
					disable = false, 
					endpoint = "http://localhost:11434/v1/chat/completions", 
				},
				openai = { 
					disable = true, 
				},
			},
			agents = {
				{
					provider = "ollama",
					name = "OllamaGemma",
					chat = true,
					command = true,
					model = {
						model = "gemma2:2b",
					},
					system_prompt = "You are a general AI assistant.",
				},
				{
					name = "CodeOllamaLlama3.1-8B",
					disable = true,
				},
			},
			default_chat_agent = "OllamaGemma",
		}
		require("gp").setup(conf)
	end,
}
