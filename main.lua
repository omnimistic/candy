love.window.setTitle("Candy Löve")

local all_strokes = {}
local current_stroke = nil
local wiggle = true

local point_distance = 5

function love.load()
    love.graphics.setBackgroundColor(1,1,1)
    love.graphics.setLineStyle("smooth")
    love.graphics.setLineWidth(3)
end

function love.update(dt)
    if love.mouse.isDown(1) and current_stroke ~= nil then
        local mouse_x, mouse_y = love.mouse.getPosition()

        if #current_stroke == 0 then
            table.insert(current_stroke, {x = mouse_x, y = mouse_y})
        else
            local last_point = current_stroke[#current_stroke]

            local dx = mouse_x - last_point.x
            local dy = mouse_y - last_point.y

            local distance = math.sqrt((dx*dx) + (dy*dy))

            if distance >= point_distance then
                table.insert(current_stroke, {x = mouse_x, y = mouse_y})
            end
        end
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
        if #stroke > 1 then
            local prev_x = stroke[1].x
            local prev_y = stroke[1].y

            if wiggle then
                prev_x = prev_x + love.math.random(-2, 2)
                prev_y = prev_y + love.math.random(-2, 2)
            end
            
            for i = 2, #stroke do
                local cur_x = stroke[i].x
                local cur_y = stroke[i].y
            
                if wiggle then
                    cur_x = cur_x + love.math.random(-2, 2)
                    cur_y = cur_y + love.math.random(-2, 2)
                end

                love.graphics.line(prev_x, prev_y, cur_x, cur_y)
                love.graphics.circle("fill", prev_x, prev_y, 1.5)

                prev_x = cur_x
                prev_y = cur_y
            end
            
            love.graphics.circle("fill", prev_x, prev_y, 1.5)

        elseif #stroke == 1 then
            local px, py = stroke[1].x, stroke[1].y
            
            if wiggle then
                px = px + love.math.random(-2, 2)
                py = py + love.math.random(-2, 2)
            end
            love.graphics.circle("fill", px, py, 1.5)
        end
    end
end

function love.keypressed(key, scancode, isrepeat)
    if key == "w" then
        wiggle = not wiggle
    end
    
    if key == "escape" then
        love.event.quit()
    end
end