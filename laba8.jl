function passage!(r::Robot)
    number_steps = 1
    side = Ost

    while isborder(r, Nord) == true
        validate(r, side, number_steps)
        side = inverse(side)
        number_steps += 1
    end
end

function validate(r::Robot, side::HorizonSide, number_steps::Int)
    for _ in 1:number_steps
        move!(r, side)
        
        if isborder(r, Nord) == false
            break
        end
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))