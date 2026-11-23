local Sprites = {}

local PALETTE = {
    ['.'] = {0, 0, 0, 0},
    ['G'] = {0.20, 0.58, 0.34, 1}, ['g'] = {0.14, 0.40, 0.38, 1}, -- Grama
    ['D'] = {0.58, 0.39, 0.25, 1}, ['d'] = {0.42, 0.25, 0.18, 1}, -- Estrada
    ['S'] = {0.62, 0.72, 0.80, 1}, ['s'] = {0.35, 0.43, 0.54, 1}, -- Pedra
    ['U'] = {0.25, 0.45, 0.85, 1}, ['W'] = {0.78, 0.22, 0.28, 1}, -- Azul / Vermelho
    ['B'] = {0.48, 0.26, 0.18, 1}, ['b'] = {0.78, 0.52, 0.28, 1}, -- Madeira
    ['K'] = {0.09, 0.10, 0.15, 1}, ['O'] = {0.60, 0.88, 0.40, 1}, -- Contorno / Pele
    ['o'] = {0.25, 0.58, 0.28, 1}, ['R'] = {0.95, 0.35, 0.25, 1}, -- Verde / Fogo
    ['Y'] = {1.00, 0.82, 0.35, 1}, ['F'] = {0.94, 0.94, 0.96, 1}, -- Ouro / Branco
    ['C'] = {0.35, 0.85, 0.98, 1}, ['c'] = {0.15, 0.45, 0.75, 1}, -- Gelo / Água
    ['P'] = {0.65, 0.25, 0.85, 1}, ['T'] = {0.22, 0.18, 0.24, 1}, -- Veneno / Piche
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
    -- Terrenos
    Sprites.grass  = makeSprite({"GGGGGGGG","GGgGGGGG","GGGGGGGG","GGGGGgGG","GGGGGGGG","GgGGGGGG","GGGGGGgG","GGGGGGGG"})
    Sprites.path   = makeSprite({"DDDDDDDD","DdDDDDDD","DDDDDdDD","DDDDDDDD","DDdDDDDD","DDDDDDdD","DDDDDDDD","DdDDDDDD"})
    Sprites.ore    = makeSprite({"GGGGGGGG","GssYYssG","GsYssYsG","GsssYYsG","GsYYsssG","GssssssG","GGGGGGGG","GGGGGGGG"})
    Sprites.water  = makeSprite({"cccccccc","cCcccccc","ccccCCcc","cccccccc","ccCCcccc","ccccccCc","cccccccc","cCcccccc"})
    Sprites.hill   = makeSprite({"GGGGGGGG","GggggggG","gGGGGGGg","gGggggGg","gGggggGg","gGGGGGGg","GggggggG","GGGGGGGG"})
    Sprites.forest = makeSprite({"GGooooGG","GooooooG","ooGooGoo","GooooooG","GGooooGG","GGGKKGGG","GGGKKGGG","GGGGGGGG"})
    Sprites.tower  = makeSprite({"..UUUU..","..UYYU..",".SSSSSS.",".SsSSsS.",".SSSSSS.",".SSKKSS.",".SKbbKS.","SSSSSSSS"})

    -- Construções
    Sprites.barricade  = makeSprite({"........",".S.SS.S.","BBBBBBBB","bBBBBBBb","BBBBBBBB",".B....B.",".B....B.","........"})
    Sprites.wall       = makeSprite({"SSSSSSSS","SsSsSsSs","SSSSSSSS","sSsSsSsS","SSSSSSSS","SsSsSsSs","SSSSSSSS","sSsSsSsS"})
    Sprites.tar        = makeSprite({"........",".TTTTTT.","TTKTTTKT","TTTTTTTT","TTTKKTTT","TTTTTTTT",".TTTTTT.","........"})
    Sprites.explosive  = makeSprite({"....Y...","...RY...","..WWWW..",".WKKKKW.",".WWYYWW.",".WKKKKW.","..WWWW..","........"})
    Sprites.watchtower = makeSprite({".bBBBBb.",".BBBBBB.","..bKKb..","..BBBB..","..BYYB..","..BBBB..",".bBBBBb.",".B....B."})
    Sprites.cannon     = makeSprite({"........","..KKKK..",".KKKKKKR",".KKKKKK.","..BBBB..",".bBYYBb.",".B....B.","........"})
    Sprites.ice        = makeSprite({"...CC...","..CCCC..",".CCFFCC.","..CCCC..","..sCCs..",".sSSSSs.",".sSSSSs.","........"})
    Sprites.poison     = makeSprite({"..PPPP..",".POOOOP.","..PPPP..","..sPPs..",".sSSSSs.",".sSSSSs.",".s....s.","........"})
    Sprites.ballista   = makeSprite({"...YY...",".bBBBBb.","b..YY..b","..BBBB..","..bKKb..",".bBBBBb.",".B....B.","........"})
    Sprites.griffin    = makeSprite({"F..UU..F","FF.YY.FF","FFYYYYFF",".FYYYYF.","..YYYY..",".Y.YY.Y.","........","........"})
    Sprites.mine       = makeSprite({"..BBBB..",".BYYYYB.","BKKKKKKB","BKYYYYKB","BKKKKKKB",".BBBBBB.",".B....B.","........"})

    -- Inimigos
    Sprites.goblin        = makeSprite({"........","..OOOO..",".OORROO.","..oOOo..","..BBBB..","..o..o..","........","........"})
    Sprites.goblin_archer = makeSprite({".......b","..OOOO.b",".OORROb.","..oOOob.","..BBBB.b","..o..o..","........","........"})
    Sprites.orc           = makeSprite({"..OOOO..",".OORROO.",".OOOOOO.","..oOOo..",".BBBBBB.",".BoBBoB.","..K..K..","........"})
    Sprites.bugbear       = makeSprite({".BBBBBB.","BBBRRBBB","BBBBBBBB","bBBBBBBb","KKKKKKKK","BKKKKKKB",".BB..BB.",".KK..KK."})
    Sprites.runner        = makeSprite({"........","........",".s....s.",".ssssss.","ssRssRss",".ssssss.",".s....s.","........"})
    Sprites.armored       = makeSprite({"..SSSS..",".SSRRSS.",".SSSSSS.",".sSSSSs.","SSSSSSSS","sSsSSsSs","..K..K..","........"})
    Sprites.sapper        = makeSprite({"....Y...","...RY...","..OOOO..",".OORROO.","..WWWW..","..o..o..","........","........"})
    Sprites.shaman        = makeSprite({"..PPPP..",".POOOOP.",".OORROO.","..PPPP..",".PPYYPP.","..o..o..","........","........"})
    Sprites.flyer         = makeSprite({"P......P","PP.PP.PP","PPPPPPPP",".PPRRPP.","..PPPP..","...PP...","........","........"})
    Sprites.boss          = makeSprite({"Y.YYYY.Y","WWWWWWWW","WWRWWWRW","WWWWWWWW","SSSSSSSS","WWSWWSWW","KK.KK.KK","........"})
end

return Sprites