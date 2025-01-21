return {
    "numToStr/Comment.nvim",
    config = function()
        vim.keymap.set('n', '<leader>cc', 'gcc', { desc = vim.fn.nr2char(0xf27a).."[C]ode [C]oment" })
        vim.keymap.set('v', 'cc', 'gc', { desc = vim.fn.nr2char(0xf27a).."[C]ode [C]oment" })
    end
}
