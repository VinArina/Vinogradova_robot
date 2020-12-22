x = 0
y = 0
s_size = 0 

function coordinates!(r::Robot, n::Int)
    global x, y, s_size
    s_size = n
    number_vert = moves!(r, Sud)
    number_hor = moves!(r, West)
    marking!(r)
    moves_back!(r, Sud, y - number_vert)
    moves_back!(r, West, x - number_hor)
end

function moves!(r::Robot, side::HorizonSide)
    number_steps = 0

    while isborder(r, side) == false
        move!(r, side)
        number_steps += 1
    end
    return number_steps
end

function moves_back!(r::Robot, side::HorizonSide, number_steps::Int)
    if (number_steps < 0) == true
        side = inverse(side)
        number_steps *= -1
    end

    for _ in 1:number_steps
        move!(r, side)
    end
end

function marking!(r::Robot)
    marking_rows!(r, Ost)
    side = West

    while isborder(r, Nord) == false
        moves_side!(r, Nord)
        marking_rows!(r, side)
        side = inverse(side)
    end
end

function marking_rows!(r::Robot, side::HorizonSide)
    can_mark!(r, x, y, s_size)

    while isborder(r, side) == false
        moves_side!(r, side)
        can_mark!(r, x, y, s_size)
    end
end

function can_mark!(r::Robot, x_coord::Int, y_coord::Int, size::Int)
    if ((mod(x_coord, 2*size) in 0:size-1) && (mod(y_coord, 2*size) in 0:size-1))
        putmarker!(r)
    end

    if ((mod(x_coord, 2*size) in size:2*size-1) && (mod(y_coord, 2*size) in size:2*size-1))
        putmarker!(r)
    end
end

function moves_side!(r::Robot, side::HorizonSide)
    global x, y
    
    if side == Nord
        y += 1
    elseif side == Sud
        y -= 1
    elseif side == Ost
        x += 1
    elseif side == West
        x -= 1
    end 

    move!(r, side)
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))