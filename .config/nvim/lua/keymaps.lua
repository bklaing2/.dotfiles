local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

map('n', '<leader><Left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<leader><Right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<leader><Down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<leader><Up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
map('n', '<leader>_', '<C-w><C-s>', { desc = 'Split window horizontally' })
map('n', '<leader>|', '<C-w><C-v>', { desc = 'Split window vertically' })

map('n', 'ds', 'd0i<BS><Esc>', { desc = 'Select entire buffer' })
map('v', '<S-a>', '<Esc>gg0vG$', { desc = 'Select entire buffer' })
