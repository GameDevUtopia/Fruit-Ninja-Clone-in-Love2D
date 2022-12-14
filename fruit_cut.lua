function fruit_partition(v, r)

    local cut_upper = {}
    cut_upper.x = v.x + r * (math.cos(v.rotation - math.pi / 2)) / 4
    cut_upper.y = v.y + r * (math.sin(v.rotation - math.pi / 2)) / 4
    cut_upper.xspeed = v.xspeed + math.random(50, 100) * (math.cos(v.rotation - math.pi / 2))
    cut_upper.yspeed = v.yspeed + math.random(50, 100) * (math.sin(v.rotation - math.pi / 2))
    cut_upper.r = r / 2
    cut_upper.rotation = v.rotation + math.pi / 2
    cut_upper.type = types_of_fruit[v.type].cut_1
    table.insert(cut_fruits, cut_upper)

    local cut_lower = {}
    cut_lower.x = v.x + r * (math.cos(v.rotation + math.pi / 2)) / 4
    cut_lower.y = v.y + r * (math.sin(v.rotation + math.pi / 2)) / 4
    cut_lower.xspeed = v.xspeed + math.random(50, 100) * (math.cos(v.rotation + math.pi / 2))
    cut_lower.yspeed = v.yspeed + math.random(50, 100) * (math.sin(v.rotation + math.pi / 2))
    cut_lower.r = r / 2
    cut_lower.type = types_of_fruit[v.type].cut_2
    cut_lower.rotation = v.rotation + math.pi / 2
    table.insert(cut_fruits, cut_lower)

end

function throw_fruit()

    local watermelonwidth, watermelonheight = types_of_fruit[1].full:getDimensions()
    local orangewidth, orangeheight = types_of_fruit[2].full:getDimensions()

    local fruit = {}
    fruit.x = math.random(0, window_width)
    fruit.y = window_height + 50
    fruit.r = math.random(1, 2) == 1 and watermelonwidth or orangewidth
    fruit.xspeed = (fruit.x < (window_width / 2)) and math.random(0, 100) or math.random(-100, 0)
    fruit.yspeed = math.random(-900, -600)
    fruit.rotationspeed = math.random(-5, 5)
    fruit.rotation = 0
    fruit.type = math.random(1, 2)
    table.insert(circles, fruit)

end

function fruit_draw()

    local b, n = love.mouse.getPosition()
    for k, v in pairs(circles) do
        local ox, oy = types_of_fruit[v.type].full:getDimensions()
        love.graphics.draw(types_of_fruit[v.type].full, v.x, v.y, v.rotation, 2, 2, ox / 2, oy / 2)
    end
    
    for k, v in pairs(cut_fruits) do
        local ox, oy = v.type:getDimensions()
        love.graphics.draw(v.type, v.x, v.y, v.rotation, 2, 2, ox / 2, oy / 2)
    end

end

function fruit_mechanics(dt)

    local b, n = love.mouse.getPosition()
    if (#circles > 0 and #arr > 0) then
        for k, v in pairs(circles) do
            if (check_intersection(v) == 1) then
                local rot = math.atan2(n - arr[1].y, b - arr[1].x)
                fruit_partition(v, rot)
                table.remove(circles, k)
                score = score + 1
            end
        end
    end

    for k, v in pairs(circles) do

        v.x = v.x + v.xspeed * dt
        v.y = v.y + v.yspeed * dt
        v.yspeed = v.yspeed + gravity * dt;
        v.rotation = v.rotation + v.rotationspeed * dt

        if (v.y > window_height + v.r and v.yspeed > 0) then
            fruit_counter = fruit_counter + 1
            if (fruit_counter > 2) then
                game_over = true
                fruit_counter = 0
                state = "lose"
                score = 0
            end
            table.remove(circles, k)
        end
    end

    if (#cut_fruits > 0) then
        for k, v in pairs(cut_fruits) do
            v.x = v.x + v.xspeed * dt
            v.y = v.y + v.yspeed * dt
            v.yspeed = v.yspeed + gravity * dt;
        end
    end
end
