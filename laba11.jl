function l_tude!(r::Robot)
    number = 0
    deed = []

       while ((isborder(r, Sud)) && (isborder(r, West))) == false
           push!(deed, moves!(r, West))
           push!(deed, moves!(r, Sud))
           number += 2
       end

    number_vert = 0
    number_hor = 0

       for i in 1:number
           if isodd(i) == true
            number_hor += deed[i]
           else
            number_vert += deed[i]
           end
       end

    side = Nord

       for _ in 1:2
           number_vert = coord_mark(r, side, number_vert)
           side = next(side)
           number_hor = coord_mark(r, side, number_hor)
           side = next(side)
       end

       while (number > 0) == true
           side = isodd(number) ? Ost : Nord
           move_step(r, side, deed[number])
           number -= 1
       end
   end
   
   function moves!(r::Robot, side::HorizonSide)
       number_steps = 0

       while isborder(r,side) == false
           move!(r, side)
           number_steps += 1
       end
       return number_steps
   end
   
   function coord_mark(r::Robot, side::HorizonSide, number_steps::Int)
       move_step(r, side, number_steps)
       putmarker!(r)
       number_steps = moves!(r, side)
       return number_steps
   end
   
   function move_step(r::Robot, side::HorizonSide, number_steps::Int)
       for _ in 1:number_steps
           move!(r, side)
       end
   end
   
   next(side::HorizonSide) = HorizonSide(mod(Int(side)+3, 4))