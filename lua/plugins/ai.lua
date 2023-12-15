return {
  {
    "David-Kunz/gen.nvim",
    config = function()
      require('gen').prompts['Ageneral'] = {
        model = 'mixtral',
        prompt = [[You are a senior DevOps engineer, answering questions about  Ansible, Docker, Docker-Compose and Python. Provide code examples where appropriate. If a question is asked about a specific software do not geive examples in other software languages, specifically stick to python where possible $input\n$text]],
        replace = true
      }
      require('gen').prompts['Devops'] = {
        model = 'wizardcoder',
        prompt = [[You are a senior DevOps engineer, answering questions about  Ansible, Docker, Docker-Compose and Python. Provide code examples where appropriate. $input\n$text]],
        replace = true
      }
      require('gen').prompts['Lua'] = {
        model = 'deepseek-coder:6.7b',
        prompt = [[You are a senior DevOps engineer, answering questions about Lua. Provide code examples where appropriate. $input\n$text]],
        replace = true
      }
      require('gen').prompts['General'] = {
        model = 'mistral',
        prompt = [[You are a senior AI engineer, answering questions about LLMs, AI frameworks. $input\n$text]],
        replace = true
      }
    end
  }
}
