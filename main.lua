love.window.setTitle("Candy Löve")

local all_strokes = {}
local current_stroke = nil
local wiggle = true

function love.load()
    love.graphics.setBackgroundColor(1,1,1)
    love.graphics.setLineStyle("smooth")
    love.graphics.setLineWidth(3)
end

function love.update(dt)
    if love.mouse.isDown(1) and current_stroke ~= nil then
        local mouse_x, mouse_y = love.mouse.getPosition()
        table.insert(current_stroke, {x = mouse_x, y = mouse_y})
    end
end

function love.mousepressed(x, y, button)
    if button == 1 then
        current_stroke = {}
        table.insert(all_strokes, current_stroke)
    end
end

function love.mousereleased(x, y, button)
    if button == 1 then
        current_stroke = nil
    end
end

function love.draw()
    love.graphics.setColor(0, 0, 0)
    
    for stroke_index, stroke in ipairs(all_strokes) do
        for i = 2, #stroke do
            local current_point = stroke[i]
            local previous_point = stroke[i-1]

            local start_x = previous_point.x
            local start_y = previous_point.y

            local end_x = current_point.x
            local end_y = current_point.y

            if wiggle then
                start_x = start_x + love.math.random(-2, 2)
                start_y = start_y + love.math.random(-2, 2)
            
                end_x = end_x + love.math.random(-2, 2)
                end_y = end_y + love.math.random(-2, 2)
            end

            love.graphics.line(start_x, start_y, end_x, end_y)
            love.graphics.circle("fill", start_x, start_y, 1.5)
        end
    end
end

function love.keypressed(key, scancode, isrepeat)
    if key == "w" then
        if wiggle == true then
            wiggle = false
        else
            wiggle = true
        end
    end
    
    if key == "escape" then
        love.event.quit()
    end
end