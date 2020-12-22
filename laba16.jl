function alll!(r::Robot)
    number = 0
    deed = []

    while ((isborder(r, Sud)) && (isborder(r, West))) == false
        push!(deed, moves!(r, West))
        push!(deed, moves!(r, Sud))
        number += 2
    end

    putmarker!(r)
    
    while !isborder(r, Ost)
        move!(r, Ost)
        putmarker!(r)
    end

    side = West

    while !isborder(r, Nord)
        tpr = 1
        move!(r, Nord)
        putmarker!(r)

        while tpr != 0
            tpr = moves_all!(r, side)
            putmarker!(r)
        end

        side = inverse(side)
    end

    moves!(r, West)
    moves!(r, Sud)
    
    while (number > 0) == true
        side = isodd(number) ? Ost : Nord
        
        for _ in 1:deed[number]
            move!(r, side)
        end
        
        number -= 1
    end
end

function moves_all!(r::Robot, side::HorizonSide)
    number_steps = 0

    while isborder(r, side) && !isborder(r, next(side))
        move!(r, next(side))
        number_steps += 1
    end

    tpr = 0

    if !isborder(r, side)
        move!(r, side)
        tpr += 1
    end

    if number_steps != 0
        while isborder(r, inverse(next(side)))
            move!(r, side)
            tpr += 1
        end

        for _ in 1:number_steps
            move!(r, inverse(next(side)))
        end
    end
    return tpr
end

function moves!(r::Robot, side::HorizonSide)
    number_steps = 0
    while isborder(r, side) == false
        move!(r, side)
        number_steps += 1
    end
    return number_steps
end

next(side::HorizonSide) = (HorizonSide(mod(Int(side)+1, 4)))
inverse(side::HorizonSide) = (HorizonSide(mod(Int(side)+2, 4)))