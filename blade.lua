function blade_draw()
    local b, n = love.mouse.getPosition()
    local bladeheight, bladewidth = blade:getDimensions()
    if (#arr > 0) then
        dist = distance(n,b)
    end
    for k, v in pairs(arr) do
        love.graphics.draw(blade, b, n, math.atan2(n - v.y, b - v.x) + math.pi / 2, 0.1, dist / 800 * 40 * 0.05,
            bladewidth - 50, 400)
    end
end

function blade_mechanics(dt)
    local b, n = love.mouse.getPosition()
    if (#arr > 0) then
        local a = arr[1].y - n
        local c = b - arr[1].x
        local d = (arr[1].x * n) - (arr[1].y * b)
        local speed = distance(n,b)/ 0.05
        local rot = math.atan2(n - arr[1].y, b - arr[1].x)
        arr[1].x = arr[1].x + math.cos(rot) * dt * speed
        arr[1].y = arr[1].y + math.sin(rot) * dt * speed
    end
end

function distance(n,b)
  return math.sqrt(((n - arr[1].y) * (n - arr[1].y)) + ((b - arr[1].x) * (b - arr[1].x)))
end 

function check_intersection(v)
    local b, n = love.mouse.getPosition()
    local dist = math.sqrt(((v.y - arr[1].y) * (v.y - arr[1].y)) + ((v.x - arr[1].x) * (v.x - arr[1].x)))
    if (dist <= v.r) then
        return 1
    else
        return 0
    end
end

function create_point(x, y)
    local a = {}
    a.x = x
    a.y = y
    a.r = 5
    table.insert(arr, a)
end
