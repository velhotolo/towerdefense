local Levels = {}

-- Legenda: g=Goblin, a=Arqueiro, o=Orc, b=Bugbear, r=Corredor, k=Blindado, s=Sapador, h=Xama, f=Harpia(Voador), B=Chefe
-- Tiles: 0=Grama, 1=Estrada, 2=Torre, 3=Minerio(Mina), 4=Agua, 5=Colina(+25% alcance), 6=Floresta(cortar=15g)
Levels.data = {
    { name = "1. Vigia do Centro", gold = 140, crystal = 10, towerHp = 150,
      paths = { {{1,7},{10,7}} },
      features = { {3,5,3}, {6,9,5}, {8,5,5}, {4,10,6}, {5,10,6} },
      waves = { {"g","g","r","g","o"}, {"g","a","r","o","a","g"} } },

    { name = "2. Duas Frentes", gold = 160, crystal = 15, towerHp = 160,
      paths = { {{1,7},{10,7}}, {{20,7},{10,7}} },
      features = { {5,5,3}, {15,9,3}, {8,5,5}, {12,9,5}, {10,3,4}, {10,4,4} },
      waves = { {"g","r","a","o","r","a"}, {"o","k","a","s","o","r"} } },

    { name = "3. Emboscada Norte", gold = 175, crystal = 20, towerHp = 170,
      paths = { {{10,1},{10,7}}, {{1,4},{5,4},{5,7},{10,7}} },
      features = { {14,4,3}, {3,9,3}, {7,5,5}, {12,5,5}, {8,9,6}, {9,9,6} },
      waves = { {"g","a","r","o","h","o"}, {"k","o","b","f","a","f"} } },

    { name = "4. Cerco em Cruz", gold = 190, crystal = 20, towerHp = 180,
      paths = { {{1,7},{10,7}}, {{20,7},{10,7}}, {{10,1},{10,7}} },
      features = { {4,4,3}, {16,4,3}, {8,9,5}, {12,9,5}, {10,11,4}, {10,12,4} },
      waves = { {"r","g","a","k","h","o","s"}, {"o","b","f","k","a","b","f"} } },

    { name = "5. Marcha dos Bugbears", gold = 210, crystal = 25, towerHp = 190,
      paths = { {{1,2},{10,2},{10,7}}, {{20,12},{10,12},{10,7}} },
      features = { {5,5,3}, {15,9,3}, {8,5,5}, {12,9,5}, {6,8,6}, {14,6,6} },
      waves = { {"o","k","b","h","a","o","s"}, {"b","k","f","b","h","o","B"} } },

    { name = "6. Chuva de Flechas", gold = 220, crystal = 25, towerHp = 200,
      paths = { {{1,7},{10,7}}, {{20,7},{10,7}}, {{10,13},{10,7}} },
      features = { {4,10,3}, {16,10,3}, {8,5,5}, {12,5,5}, {10,3,4}, {10,4,4} },
      waves = { {"a","a","r","f","a","h","a"}, {"a","b","f","k","a","s","b"} } },

    { name = "7. Quatro Ventos", gold = 240, crystal = 30, towerHp = 210,
      paths = { {{1,7},{10,7}}, {{20,7},{10,7}}, {{10,1},{10,7}}, {{10,13},{10,7}} },
      features = { {5,4,3}, {15,10,3}, {8,5,5}, {12,5,5}, {8,9,5}, {12,9,5} },
      waves = { {"r","o","f","k","h","a","s"}, {"b","f","k","b","h","o","f"} } },

    { name = "8. Espiral Goblinoide", gold = 250, crystal = 35, towerHp = 220,
      paths = { {{1,2},{18,2},{18,7},{10,7}}, {{20,12},{2,12},{2,7},{10,7}} },
      features = { {6,5,3}, {14,9,3}, {10,5,5}, {10,9,5}, {5,9,6}, {15,5,6} },
      waves = { {"k","a","b","r","h","o","s"}, {"b","b","f","k","h","b","B"} } },

    { name = "9. Assalto Total", gold = 270, crystal = 40, towerHp = 240,
      paths = { {{1,3},{6,3},{6,7},{10,7}}, {{20,3},{14,3},{14,7},{10,7}}, {{10,13},{10,7}} },
      features = { {3,10,3}, {17,10,3}, {8,5,5}, {12,5,5}, {10,4,5} },
      waves = { {"b","f","k","b","h","o","s","r"}, {"b","b","f","k","h","b","f","B"} } },

    { name = "10. A Queda da Horda", gold = 300, crystal = 50, towerHp = 260,
      paths = { {{1,7},{10,7}}, {{20,7},{10,7}}, {{10,1},{10,7}}, {{10,13},{10,7}} },
      features = { {4,4,3}, {16,4,3}, {4,10,3}, {16,10,3}, {8,5,5}, {12,5,5}, {8,9,5}, {12,9,5} },
      waves = { {"b","k","f","b","h","s","b","f"}, {"b","B","f","k","h","b","B","f","s"} } },
}

function Levels.buildGrid(levelIndex)
    local lvl = Levels.data[levelIndex]
    local grid = {}
    for r = 1, 13 do
        grid[r] = {}
        for c = 1, 20 do grid[r][c] = 0 end
    end
    for _, path in ipairs(lvl.paths) do
        for i = 1, #path - 1 do
            local c1, r1 = path[i][1], path[i][2]
            local c2, r2 = path[i+1][1], path[i+1][2]
            local dc = (c2 > c1) and 1 or (c2 < c1 and -1 or 0)
            local dr = (r2 > r1) and 1 or (r2 < r1 and -1 or 0)
            local c, r = c1, r1
            while true do
                grid[r][c] = 1
                if c == c2 and r == r2 then break end
                c, r = c + dc, r + dr
            end
        end
    end
    if lvl.features then
        for _, f in ipairs(lvl.features) do
            if grid[f[2]][f[1]] == 0 then grid[f[2]][f[1]] = f[3] end
        end
    end
    grid[7][10] = 2
    return grid, lvl
end

return Levels