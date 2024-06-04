vim.opt.termguicolors = true
require("bufferline").setup()

diagnostics_indicator = function(count, level, diagnostics_dict, context)
    if context.buffer:current() then
        return ''
    end

    return ''
end
