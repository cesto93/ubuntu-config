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

			hooks = {
				UnitTests = function(gp, params)
					local template = "I have the following code from {{filename}}:\n\n"
					.. "```{{filetype}}\n{{selection}}\n```\n\n"
					.. "Please respond by writing unit tests for the code above."
					local agent = gp.get_chat_agent()
					gp.Prompt(params, gp.Target.vnew, agent, template)
				end,
				Explain = function(gp, params)
					local template = "I have the following code from {{filename}}:\n\n"
					.. "```{{filetype}}\n{{selection}}\n```\n\n"
					.. "Please respond by explaining the code above."
					local agent = gp.get_chat_agent()
					gp.Prompt(params, gp.Target.vnew, agent, template)
				end,
			},

			default_chat_agent = "OllamaGemma",
			default_code_agent = "OllamaGemma",
		}
		require("gp").setup(conf)
	end,
}
