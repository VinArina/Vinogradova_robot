function cross!(r::Robot)
    side = Nord

       for _ in 1:4
           tpr = 1

           while tpr != 0
               tpr = move_place(r, side)
               putmarker!(r)
           end

           side = inverse(side)

           while ismarker(r)
               move_place(r,side)
           end

           side = inverse(next(side))
       end
       putmarker!(r)
   end
   
   function move_place(r::Robot, side::HorizonSide)
       number_steps = 0

       while isborder(r, side) && !isborder(r, next(side))
           move!(r, next(side))
           number_steps += 1
       end
       tpr=0
       
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
   
   next(side::HorizonSide) = HorizonSide(mod(Int(side)+1, 4))
   inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))