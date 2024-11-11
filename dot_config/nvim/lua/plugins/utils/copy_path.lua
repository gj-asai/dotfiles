-- https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/370
return function (state)
    local node = state.tree:get_node()
    local filepath = node:get_id()
    local filename = node.name
    local modify = vim.fn.fnamemodify

    local results = {
        filepath,
        modify(filepath, ":."),
        modify(filepath, ":~"),
        filename,
        modify(filename, ":r"),
        modify(filename, ":e"),
    }

    vim.ui.select({
        "1. Path relative to CWD: " .. results[1],
        "2. Filename: " .. results[2],
        "3. Filename without extension: " .. results[3],
        "4. Absolute path: " .. results[4],
        "5. Path relative to HOME: " .. results[5],
        "6. Extension of the filename: " .. results[6],
    }, { prompt = "Choose to copy to clipboard:" }, function(choice)
        if choice then
            local i = tonumber(choice:sub(1, 1))
            if i then
                local result = results[i]
                vim.fn.setreg('"', result)
            end
        end
    end)
end
