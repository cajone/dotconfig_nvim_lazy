-- Dadbod-ui setup

return {
  { "kristijanhusak/vim-dadbod-ui", },
  { "kristijanhusak/vim-dadbod-completion", },    -- DB autocompletion
  config = function()
    local db_ui_icons = require("db_ui_icons")
    local db_ui_notification = require("db_ui_notification") 
    db_ui_notification.setup({
      options = {
        db_ui_notification_width = 1000,
      },
    })
    db_ui_icons.setup({
      options = {
       expanded = {
               db= '-',
               buffers= '-',
               saved_queries= '-',
               schemas= '-',
               schema= '-',
               tables= '-',
               table= '-',
       },
       collapsed= {
               db= '+',
               buffers= '+',
               saved_queries= '+',
               schemas= '+',
               schema= '+',
               tables= '+',
               table= '+',
         },
       },
    })
  end,
}
