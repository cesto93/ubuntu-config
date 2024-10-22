return {
	"robitx/gp.nvim",
	config = function()
		local conf = {
			providers = {
				ollama = { 
					disable = false, 
					endpoint = "http://localhost:11434/v1/chat/completions", 
				},
			},
			agents = {
				{
					name = "ChatGPT",
					chat = true,
					command = true,
					-- string with model name or table with model name and parameters
					model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
					-- system prompt (use this to specify the persona/role of the AI)
					system_prompt = require("gp.defaults").chat_system_prompt,
				},
				{
					provider = "ollama",
					name = "OllamaPhi",
					chat = true,
					command = true,
					model = {
						model = "phi3.5",
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

			default_chat_agent = "ChatGPT",
			default_code_agent = "ChatGPT",
		}
		require("gp").setup(conf)
	end,
}
