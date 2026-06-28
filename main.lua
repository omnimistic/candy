
local brush_strokes = {}

function love.load()
    love.graphics.setBackgroundColor(1,1,1)
end

function love.update(dt)
    if love.mouse.isDown(1) then
        local mouse_x, mouse_y = love.mouse.getPosition()
        table.insert(brush_strokes, {x = mouse_x, y = mouse_y})
    end
end

function love.draw()
    love.graphics.setColor(0, 0, 0)
    
    for index, point in ipairs(brush_strokes) do
        love.graphics.circle("fill", point.x, point.y, 3)
    end
end