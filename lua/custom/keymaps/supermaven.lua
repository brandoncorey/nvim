function bind_super_maven()
  return {
    accept_suggestion = '<Tab>',
    clear_suggestion = '<C-;>',
    accept_word = "<C-'>",
  }
end

return {
  bind_super_maven = bind_super_maven,
}

