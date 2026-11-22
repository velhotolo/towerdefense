local Sprites = {}

local PALETTE = {
    ['.'] = {0, 0, 0, 0},
    ['G'] = {0.20, 0.58, 0.34, 1}, -- Grama
    ['g'] = {0.14, 0.40, 0.38, 1}, -- Grama escura
    ['D'] = {0.58, 0.39, 0.25, 1}, -- Estrada
    ['d'] = {0.42, 0.25, 0.18, 1}, -- Terra escura
    ['S'] = {0.62, 0.72, 0.80, 1}, -- Pedra clara
    ['s'] = {0.35, 0.43, 0.54, 1}, -- Pedra escura
    ['U'] = {0.25, 0.45, 0.85, 1}, -- Azul real (Torre/Cavaleiro)
    ['W'] = {0.78, 0.22, 0.28, 1}, -- Vermelho (Explosivo/Inimigo)
    ['B'] = {0.48, 0.26, 0.18, 1}, -- Madeira/Pelo Bugbear
    ['b'] = {0.78, 0.52, 0.28, 1}, -- Madeira clara
    ['K'] = {0.09, 0.10, 0.15, 1}, -- Contorno escuro
    ['O'] = {0.60, 0.88, 0.40, 1}, -- Pele Goblin/Orc
    ['o'] = {0.25, 0.58, 0.28, 1}, -- Sombra verde
    ['R'] = {0.95, 0.35, 0.25, 1}, -- Olho/Fogo
    ['Y'] = {1.00, 0.82, 0.35, 1}, -- Ouro/Grifo
    ['F'] = {0.94, 0.94, 0.96, 1}, -- Branco (Asas do Grifo)
}

local function makeSprite(matrix)
    local h, w = #matrix, #matrix[1]
    local data = love.image.newImageData(w, h)
    for y = 1, h do
        for x = 1, w do
            local c = PALETTE[matrix[y]:sub(x, x)] or PALETTE['.']
            data:setPixel(x - 1, y - 1, c[1], c[2], c[3], c[4])
        end
    end
    local img = love.graphics.newImage(data)
    img:setFilter("nearest", "nearest")
    return img
end

function Sprites.load()
    Sprites.grass = makeSprite({
        "GGGGGGGG","GGgGGGGG","GGGGGGGG","GGGGGgGG",
        "GGGGGGGG","GgGGGGGG","GGGGGGgG","GGGGGGGG"
    })
    Sprites.path = makeSprite({
        "DDDDDDDD","DdDDDDDD","DDDDDdDD","DDDDDDDD",
        "DDdDDDDD","DDDDDDdD","DDDDDDDD","DdDDDDDD"
    })
    -- Torre Central (Objetivo)
    Sprites.tower = makeSprite({
        "..UUUU..","..UYYU..",".SSSSSS.",".SsSSsS.",
        ".SSSSSS.",".SSKKSS.",".SKbbKS.","SSSSSSSS"
    })
    -- Construções
    Sprites.barricade = makeSprite({
        "........",".b.bb.b.","BBBBBBBB","bBBBBBBb",
        "BBBBBBBB",".B....B.",".B....B.","........"
    })
    Sprites.wall = makeSprite({
        "SSSSSSSS","SsSsSsSs","SSSSSSSS","sSsSsSsS",
        "SSSSSSSS","SsSsSsSs","SSSSSSSS","sSsSsSsS"
    })
    Sprites.explosive = makeSprite({
        "....Y...","...RY...","..WWWW..",".WKKKKW.",
        ".WWYYWW.",".WKKKKW.","..WWWW..","........"
    })
    Sprites.watchtower = makeSprite({
        ".bBBBBb.",".BBBBBB.","..bKKb..","..BBBB..",
        "..BYYB..","..BBBB..",".bBBBBb.",".B....B."
    })
    Sprites.cannon = makeSprite({
        "........","..KKKK..",".KKKKKKR",".KKKKKK.",
        "..BBBB..",".bBYYBb.",".B....B.","........"
    })
    Sprites.griffin = makeSprite({
        "F..UU..F","FF.YY.FF","FFYYYYFF",".FYYYYF.",
        "..YYYY..",".Y.YY.Y.","........","........"
    })
    -- Goblinoides
    Sprites.goblin = makeSprite({
        "........","..OOOO..",".OORROO.","..oOOo..",
        "..BBBB..","..o..o..","........","........"
    })
    Sprites.goblin_archer = makeSprite({
        ".......b","..OOOO.b",".OORROb.","..oOOob.",
        "..BBBB.b","..o..o..","........","........"
    })
    Sprites.orc = makeSprite({
        "..OOOO..",".OORROO.",".OOOOOO.","..oOOo..",
        ".BBBBBB.",".BoBBoB.","..K..K..","........"
    })
    Sprites.bugbear = makeSprite({
        ".BBBBBB.","BBBRRBBB","BBBBBBBB","bBBBBBBb",
        "KKKKKKKK","BKKKKKKB",".BB..BB.",".KK..KK."
    })
end

return Sprites