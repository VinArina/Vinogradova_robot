function avarege_temp(r)
    temp = 0
    m = moves(r, Nord)
    n = 1

    side = Nord

    while isborder(r, Ost) == false 
        n += 1
        side = HorizonSide(mod(Int(side)+2, 4))
        temp += finding_temp(r, side)
        move!(r, Ost)
    end
    
    side = HorizonSide(mod(Int(side)+2, 4))
    temp += finding_temp(r, side)
    print(temp/(n*m))
end

function finding_temp(r, side)
    n = 0

    while isborder(r, side)==false
       n=n+temperature(r) 
       move!(r, side)
    end
    n += temperature(r)
    return n
end
function moves(r, side)
    num = 1

    while isborder(r, side) == false
        num += 1
        move!(r, side)
    end
    return num
end