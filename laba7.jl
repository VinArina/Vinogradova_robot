function chess!(r::Robot)
    side = Ost
    number_vert = moves!(r, Sud)
    number_hor = moves!(r, West)
    tpr = 1

    while isborder(r, Nord) == false
        can_mark(r, abs(number_vert), abs(number_hor), 1)

        while isborder(r, side) == false
            move!(r, side)
            number_hor -= tpr
            can_mark(r, abs(number_vert), abs(number_hor), 1)
        end

        move!(r, Nord)
        side = inverse(side)
        number_vert -= 1
        tpr *= -1
    end

    can_mark(r, abs(number_vert), abs(number_hor), 1)

    while isborder(r, side) == false
        move!(r, side)
        number_hor -= tpr
        can_mark(r, abs(number_vert), abs(number_hor), 1)
    end

    moves_back!(r, Nord, number_vert)
    moves_back!(r, Ost, number_hor)
end

function can_mark(r::Robot, x_coord::Int, y_coord::Int, size::Int)
    if ((mod(x_coord, 2*size) in 0:size-1) && (mod(y_coord, 2*size) in 0:size-1))
        putmarker!(r)
    end

    if ((mod(x_coord, 2*size) in size:2*size-1) && (mod(y_coord, 2*size) in size:2*size-1))
        putmarker!(r)
    end
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

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))