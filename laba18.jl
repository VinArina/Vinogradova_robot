function in_the_corners!(r::Robot)
    number = 0
    deed = []

    while ((isborder(r, Sud)) && (isborder(r, West))) == false
        push!(deed, moves!(r, West))
        push!(deed, moves!(r, Sud))
        number += 2
    end

    side = Nord

    for _ in 1:4
        moves!(r, side)
        putmarker!(r)
        side = next(side)
    end

    while (number > 0) == true
        side = isodd(number) ? Ost : Nord

        for _ in 1:deed[number]
            move!(r, side)
        end

        number -= 1
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

next(side::HorizonSide) = HorizonSide(mod(Int(side)+3, 4))