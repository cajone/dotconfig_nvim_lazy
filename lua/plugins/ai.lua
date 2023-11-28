return {
  {
    "David-Kunz/gen.nvim",
    config = function()
      require('gen').prompts['Devops'] = {
        model = 'deepseek-coder:6.7b',
        prompt = [[You are a senior DevOps engineer, answering questions about Lua, nvim, Jenkins, Ansible, Chef, Ruby, Docker, Docker-Compose and Python. Provide code examples where appropriate. $input\n$text]],
        replace = true
      }
      require('gen').prompts['Ansible'] = {
        model = 'deepseek-coder:6.7b',
        prompt = [[You are a senior DevOps engineer, answering questions about Ansible. Provide code examples where appropriate. $input\n$text]],
        replace = true
      }
      require('gen').prompts['Lua'] = {
        model = 'deepseek-coder:6.7b',
        prompt = [[You are a senior DevOps engineer, answering questions about Lua. Provide code examples where appropriate. $input\n$text]],
        replace = true
      }
      require('gen').prompts['General'] = {
        model = 'llama2',
        prompt = [[You are a senior DevOps engineer, answering questions about nvim, Jenkins, Ansible, Chef, Ruby, Docker, Docker-Compose and Python. $input\n$text]],
        replace = true
      }
    end
  }
}
