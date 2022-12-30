
function ternaryOperator(condition,a,b)
 if condition then
  return a
 else
  return b
 end
end


function fnyinyang(r,x,y)
 -- flip y because this function was originally written for a johnsonscript routine that writes out .bmp files directly. In .bmp format, x0,y0 is the bottom left corner, in lua x0,y0 is the top left
 y = r*2-y
 local r2, rh, yModRMinusRh
 if not (math.abs(x-r) < math.sin(math.acos( (y-r)/r ))*r ) then
  return 0
 end
 rh = r*0.5
 yModRMinusRh = math.floor(y % r) - rh
 r2 = r / 7
 if yModRMinusRh < r2 then
  if math.abs(x-r) < r2 * math.sin(math.acos( yModRMinusRh / r2) ) then
   return 2-ternaryOperator(y>r,1,0)
  end
 end
 return 2-ternaryOperator( (x-r) > (math.sin(math.acos( yModRMinusRh / rh )))*rh*ternaryOperator(y<r,-1,1), 1, 0)
end


pals = { { {0,0,0,1}, {0.75,0,0,1}, {0.75,0.5,0,1}, {1,0.65,0,1} },
          { {0,0,0,1}, {0,0,0.75,1}, {0,0.5,0.75,1}, {0,0.75,0.75,1} } }

bg = { {0.5,0.5,0,1}, {0,0,0.5,1} }

sz=3


function love.load()

 mycanvas = love.graphics.newCanvas()
 love.graphics.setCanvas( mycanvas )

 for x=0, 160, 1 do 
  for y=0, 128, 1 do

   v = fnyinyang(64,x-16,y)

   dx=(x-16)-64
   dy=(y)-64
   palindex = (1-math.sqrt(dx*dx+dy*dy)/64)*3
   if love.math.random()<(palindex-math.floor(palindex)) then
    palindex=palindex+1
   end
   palindex=math.floor(palindex+1)

   if v>0 then
    love.graphics.setColor( pals[v][palindex] )
   else
    love.graphics.setColor( bg[math.floor((math.floor(x/6)+math.floor(y/6))%2)+1] )
   end

   love.graphics.rectangle( "fill", x*sz, y*sz, sz, sz )

  end
 end

 love.graphics.setCanvas()
 love.graphics.setColor(1, 1, 1, 1)

end

function love.draw()
 love.graphics.draw(mycanvas,0,0)
 -- love.graphics.setColor( {0,255,0,255} )
 -- love.graphics.circle("fill",200,200,160)
end