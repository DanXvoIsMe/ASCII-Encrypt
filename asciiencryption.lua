local module = {}

function module.stringToAscii(str)
    local asciiTable = {}
    for i = 1, #str do
        table.insert(asciiTable, str:byte(i))
    end
    return asciiTable
end

function module.asciiToString(asciiTable)
    local str = ""
    for _, v in ipairs(asciiTable) do
        str = str .. string.char(v)
    end
    return str
end

function module.encrypt(input, key)
    local keyAscii = module.stringToAscii(key)
    local keySum = 0
    for _, v in ipairs(keyAscii) do
        keySum = keySum + v
    end

    local encrypted = {}
    for i = 1, #input do
        local charCode = input:byte(i)
        local encryptedChar = charCode + keySum
        table.insert(encrypted, tostring(encryptedChar))
    end
    return table.concat(encrypted, "|")
end

function module.decrypt(input, key)
    local keyAscii = module.stringToAscii(key)
    local keySum = 0
    for _, v in ipairs(keyAscii) do
        keySum = keySum + v
    end

    local decrypted = {}
    for code in string.gmatch(input, "([^|]+)") do
        local charCode = tonumber(code) - keySum
        table.insert(decrypted, string.char(charCode))
    end
    return table.concat(decrypted)
end

return module
