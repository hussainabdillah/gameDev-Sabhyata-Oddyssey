function love.load()
    anim8 = require 'libraries/anim8'
    love.graphics.setDefaultFilter("nearest", "nearest")

    player = {}
    player.x = 400
    player.y = 100
    player.speed = 3
    player.sprite = love.graphics.newImage('sprites/parrot.png')
    player.spriteSheet = love.graphics.newImage('sprites/player-sheet.png')
    --local frameWidth = 48  -- 1152 / 8
    --local frameHeight = 47  -- 1080 / 8
    player.grid = anim8.newGrid(144, 135, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())

    player.animations = {}
    player.animations.walkDown = anim8.newAnimation(player.grid('3-8', 4), 0.4)
    player.animations.walkLeft = anim8.newAnimation(player.grid('1-6', 1), 0.4)
    player.animations.walkRight = anim8.newAnimation(player.grid('1-6', 5), 0.4)
    player.animations.walkUp = anim8.newAnimation(player.grid('7-8', 5, '1-4', 6), 0.4)

    player.animations.idleDown = anim8.newAnimation(player.grid('7-8', 1, '1-3', 2), 0.8)
    player.animations.idleLeft = anim8.newAnimation(player.grid('1-5', 3), 0.8)
    player.animations.idleRight = anim8.newAnimation(player.grid('4-8', 2), 0.8)
    player.animations.idleUp = anim8.newAnimation(player.grid('6-8', 3, '1-2', 4), 0.8)

    player.anim = player.animations.idleDown

    background = love.graphics.newImage('sprites/background.png')
end

function love.update(dt)
    player.isMoving = false

    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed
        player.anim = player.animations.walkRight
        player.isMoving = true
    end

    if love.keyboard.isDown("left") then
        player.x = player.x - player.speed
        player.anim = player.animations.walkLeft
        player.isMoving = true
    end

    if love.keyboard.isDown("down") then
        player.y = player.y + player.speed
        player.anim = player.animations.walkDown
        player.isMoving = true
    end

    if love.keyboard.isDown("up") then
        player.y = player.y - player.speed
        player.anim = player.animations.walkUp
        player.isMoving = true
    end

    if player.isMoving == false then
        if player.anim == player.animations.walkRight then
            player.anim = player.animations.idleRight
        elseif player.anim == player.animations.walkLeft then
            player.anim = player.animations.idleLeft
        elseif player.anim == player.animations.walkDown then
            player.anim = player.animations.idleDown
        elseif player.anim == player.animations.walkUp then
            player.anim = player.animations.idleUp
        end
    end

    player.anim:update(dt)
end


function love.draw()
    love.graphics.draw(background, 0, 0)
    player.anim:draw(player.spriteSheet, player.x, player.y, nil, 2)
end