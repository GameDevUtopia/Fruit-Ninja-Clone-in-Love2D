function throw_bomb()
    local bombwidth, bombheight = bomb_img:getDimensions()
    local bomb = {}
    bomb.x = math.random(0, window_width)
    bomb.y = window_height + 50
    bomb.r = bombheight / 20
    bomb.xspeed = (bomb.x < (window_width / 2)) and math.random(0, 100) or math.random(-100, 0)
    bomb.yspeed = math.random(-900, -600)
    table.insert(bombs, bomb)
end

function bomb_mechanics(dt)
    local b, n = love.mouse.getPosition()
    for k, v in pairs(bombs) do
        v.x = v.x + v.xspeed * dt
        v.y = v.y + v.yspeed * dt
        v.yspeed = v.yspeed + gravity * dt
    end
    if (#bombs > 0 and #arr > 0) then
        for k, v in pairs(bombs) do
            if (check_intersection(v) == 1) then
                local rot = math.atan2(n - arr[1].y, b - arr[1].x)
                table.remove(bombs, k)
                game_over = true
                state = "lose"
                score = 0
            end
        end
    end
    for k, v in pairs(bombs) do
        if (v.y > window_height + 300) then
            table.remove(bombs, k)
        end
    end
end

function bomb_draw()
    local bomb_height, bomb_width = bomb_img:getDimensions()
    for k, v in pairs(bombs) do
        love.graphics.draw(bomb_img, v.x, v.y, 0, 0.2, 0.2, bomb_width / 2 + 500, bomb_height / 2 - 300)
    end
end
