
window_width = 800
window_height = 800

require "fruit_cut"
require "blade"
require "bomb"
require "gui"


gravity = 500

max = 0

arr = {}
circles = {}
cut_fruits = {}
bombs = {}

timer = 0
bomb_timer = 0
bomb_timer_limit = math.random(2, 5)

game_over = false
fruit_counter = 0
state = "main_menu"

function love.load()

    love.window.setMode(window_width, window_height)
    blade = love.graphics.newImage("Images/Swords/sword_red.png")

   -- math.randomseed(os.time())

    types_of_fruit = {}

    -- Water_Melons 
    local watermelon = {}
    watermelon.full = love.graphics.newImage("Images/Water_Melon/wat_1.png")
    watermelon.cut_1 = love.graphics.newImage("Images/Water_Melon/wat_2.png")
    watermelon.cut_2 = love.graphics.newImage("Images/Water_Melon/wat_3.png")
    table.insert(types_of_fruit, watermelon)

    -- Oranges
    local oranges = {}
    oranges.full = love.graphics.newImage("Images/Oranges/orange_1.png")
    oranges.cut_1 = love.graphics.newImage("Images/Oranges/orange_2.png")
    oranges.cut_2 = love.graphics.newImage("Images/Oranges/orange_3.png")
    table.insert(types_of_fruit, oranges)

    bomb_img = love.graphics.newImage("Images/Bombs/bomb.png")
    -- max=0
    background = love.graphics.newImage("Images/Background/Wiki-background.jpg")
    backgroundwidth, backgroundheight = background:getDimensions()
    

end

function love.update(dt)

    if love.keyboard.isDown("escape") then 
       love.event.quit()
    end 
    if state == "play" then
        if (game_over == false) then

            ------timer for throwing fruits-----
            timer = timer + dt
            bomb_timer = bomb_timer + dt

            if (timer > 3) then
                timer = 0
                local number = math.random(1, 6)
                for i = 1, number, 1 do
                    throw_fruit()
                end
            end

            if (bomb_timer > bomb_timer_limit) then
                bomb_timer = 0
                bomb_timer_limit = math.random(2, 5)
                throw_bomb()
            end

            -----fruit logic cut fruit logic and blade cut detect--------
            blade_mechanics(dt)
            fruit_mechanics(dt)
            bomb_mechanics(dt)

        end

        if (game_over == true) then
            bombs = {}
            cut_fruits = {}
            circles = {}
        end
    end
end

function love.mousepressed(x, y, button)

    if (button == 1) then
        create_point(x, y)
    end

    if state == "main_menu" then
        if check_collision(play_button, x, y) then
            state = "play"
        end

    elseif state == "lose" then
        if check_collision(main_menu_button, x, y) then
            state = "main_menu"
            fruit_counter = 0
            game_over = false
        end
    end

end

function check_collision(array, x, y)

    return x > array.x and 
           x < array.x + array.width and 
           y > array.y and 
           y < array.y + array.height

end

function love.mousereleased(x, y, button, isTouch)
    arr = {}
end

function love.draw()
    love.graphics.draw(background, 0, 0, 0, window_width / backgroundwidth, window_height / backgroundheight)

    if state == "main_menu" then
        draw_play_button()
        love.graphics.setFont(name_font)
        love.graphics.printf("Fruit Ninja", 0, 100-70, window_width, "center")

    elseif state == "lose" then
        draw_menu_button()
        love.graphics.printf("You Lose Press Menu button to return to main menu", 0, 200-140, window_width, "center")

    else
        love.graphics.draw(background, 0, 0, 0, window_width / backgroundwidth, window_height / backgroundheight)
        fruit_draw()
        blade_draw()
        bomb_draw()
        displayScore()
    end

end
