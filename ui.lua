local ui = {}

ui.is_visible = false
ui.panel_height = 150
ui.slide_speed = 15
ui.current_y = 0

function ui.load()
    local window_height = love.graphics.getHeight()
    ui.current_y = window_height
end

function ui.update(dt)
    local window_height = love.graphics.getHeight()

    local hidden_y = window_height
    local visible_y = window_height - ui.panel_height

    local target_y = hidden_y
    if ui.is_visible then
        target_y = visible_y
    end

    ui.current_y = ui.current_y + (target_y - ui.current_y) * ui.slide_speed * dt
end

function ui.draw()
    local window_width = love.graphics.getWidth()

    love.graphics.setColor(0.1, 0.1, 0.1, 1)
    love.graphics.rectangle("fill", 0, ui.current_y, window_width, ui.panel_height)

    love.graphics.setColor(1,1,1,1)
    love.graphics.print("settings panel", 20, ui.current_y + 20)
    
end

function ui.toggle()
    ui.is_visible = not ui.is_visible
end

return ui