function find_mark!(r::Robot)
    numer_steps = 1
    side = Nord

    while ismarker(r) == false
        for _ in 1:2
            validate(r, side, number_steps)
            side = next(side)
        end
        number_steps += 1
    end
end

function validate(r::Robot, side::HorizonSide, number_steps::Int)
    for _ in 1:number_steps
        move!(r, side)
        
        if ismarker(r) == true
            break
        end
    end
end

next(side::HorizonSide) = HorizonSide(mod(Int(side)+3, 4))