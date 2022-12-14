play_button = {}

play_button.width = 100
play_button.height = 50

play_button.x = window_width / 2 - play_button.width / 2
play_button.y = 2 * window_height / 3 - play_button.height / 2+180

main_menu_button = {}
main_menu_button.width = 200
main_menu_button.height = 100

main_menu_button.x = window_width / 2 - main_menu_button.width / 2
main_menu_button.y = 2 * window_height / 3 - main_menu_button.height / 2+200

button_font = love.graphics.newFont(30)
name_font = love.graphics.newFont(60)

score = 0

function draw_play_button()
   -- love.graphics.rectangle("line", play_button.x, play_button.y, play_button.width, play_button.height)

    love.graphics.setFont(button_font)
    love.graphics.printf("Play", play_button.x, play_button.y + 10, play_button.width, "center")
end

function draw_menu_button()
  --  love.graphics.rectangle("line", main_menu_button.x, main_menu_button.y, main_menu_button.width,
  --      main_menu_button.height)

    love.graphics.setFont(button_font)
    love.graphics.printf("Main Menu", main_menu_button.x, main_menu_button.y + 30, main_menu_button.width, "center")
end

function displayScore()
    love.graphics.print("Score", window_width - 200, 10)
    love.graphics.print(score, window_width - 150, 100)
end
