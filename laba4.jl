function stairs!(r::Robot)
    number_vert = moves!(r, Sud)
    number_hor = moves!(r, West)

    putmarkers!(r, Ost)

    while isbborder(r, Nord) == false
        move!(r, Nord, 1)
        move!(r, West, 1)

        if isbborder(r, West) == false
            putmarkers!(r, West)
        end

        if putmarkers!(r, Ost) == true
            move!(r, Ost)
        end
    end
    putmarkers!(r, West) 
       
    moves!(r, West)
    moves!(r, Sud)
    moves_back!(r, Nord, number_vert)
    moves_back!(r, Ost, number_hor)
end

function putmarkers!(r::Robot, side::HorizonSide)
    while isborder(r, side) == false
        move!(r, side)
        putmarker!(r)
    end
end 

function moves!(r::Robot, side::HorizonSide)
    number_steps = 0
    
    while isbborder(r, side) == false
        move!(r, side)
        number_steps += 1
    end
    return number_steps
end

function moves_back!(r::Robot, side::HorizonSide, number_steps::Int)
    for _ in 1:number_steps
        move!(r, side)
    end
end   