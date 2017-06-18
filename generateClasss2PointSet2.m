function [point] = generateClasss2PointSet2(iter, stepSize)
 %1 środek stoi w miejscu 
 %2 przesówamy się o 90 stopni względem (2,0)
 %3 stoimy w miejscu na pozycji 90 stopni
 %4 idziemy od 90 do 180 stopni względem (2,0)
 %5 stoimy w miejscu na pozycji 180
 %6 idziemy od 180 do 270 stopni względem (2,0)
 %7 stoimy w miejscu na pozycji 270
 %8 idziemy od 270 do 360 stopni względem (2,0)
 %9 stoimy w miejscu (0,0)
 %10 przesówamy się o 90 stopni względem (-2,0)
 %11 stoimy w miejscu na pozycji 90 stopni
 %12 idziemy od 90 do 180 stopni względem (-2,0)
 %13 stoimy w miejscu na pozycji 180
 %14 idziemy od 180 do 270 stopni względem (-2,0)
 %15 stoimy w miejscu na pozycji 270
 %16 idziemy od 270 do 360 stopni względem (-2,0)
 radius = 2;
 point = [0,0];
 
 
 %pierwsze koło
 if 1 <= iter && iter <= stepSize
     point = getClass2Points(radius, 3.1415, 2, 0);
 elseif stepSize+1 <= iter && iter < stepSize*2
     angle = 3.1415 - (3.1415/2)*(iter-stepSize+1)/stepSize;
     point = getClass2Points(radius, angle, 2, 0);
 elseif stepSize*2+1 <= iter && iter < stepSize*3
     point = getClass2Points(radius, 3.1415/2, 2, 0);  
 elseif stepSize*3+1 <= iter && iter < stepSize*4
     angle = 3.1415/2 - (3.1415/2)*(iter-stepSize*3+1)/stepSize;
     point = getClass2Points(radius, angle, 2, 0);
 elseif stepSize*4+1 <= iter && iter < stepSize*5
     point = getClass2Points(radius, 0, 2, 0);
 elseif stepSize*5+1 <= iter && iter < stepSize*6
     angle = 0 - (3.1415/2)*(iter-stepSize*5+1)/stepSize;
     point = getClass2Points(radius, angle, 2, 0);
 elseif stepSize*6+1 <= iter && iter < stepSize*7 
     point = getClass2Points(radius, -3.1415/2, 2, 0);
 elseif stepSize*7+1 <= iter && iter < stepSize*8
     angle = 3.1415*3/2 - (3.1415/2)*(iter-stepSize*7+1)/stepSize;
     point = getClass2Points(radius, angle, 2, 0); 
 %drugie koło
 elseif stepSize*8+1 <= iter && iter < stepSize*9 
     point = getClass2Points(radius, 0, -2, 0);
 elseif stepSize*9+1 <= iter && iter < stepSize*10
     angle = (3.1415/2)*(iter-stepSize*9+1)/stepSize;
     point = getClass2Points(radius, angle, -2, 0);
 elseif stepSize*10+1 <= iter && iter < stepSize*11
     point = getClass2Points(radius, 3.1415/2, -2, 0);  
 elseif stepSize*11+1 <= iter && iter < stepSize*12
     angle = 3.1415/2 + (3.1415/2)*(iter-stepSize*11+1)/stepSize;
     point = getClass2Points(radius, angle, -2, 0);
 elseif stepSize*12+1 <= iter && iter < stepSize*13
     point = getClass2Points(radius, 3.1415, -2, 0);
 elseif stepSize*13+1 <= iter && iter < stepSize*14
     angle = 3.1415 + (3.1415/2)*(iter-stepSize*13+1)/stepSize;
     point = getClass2Points(radius, angle, -2, 0);
 elseif stepSize*14+1 <= iter && iter < stepSize*15 
     point = getClass2Points(radius, -3.1415/2, -2, 0);
 elseif stepSize*15+1 <= iter && iter < stepSize*16
     angle = 3.1415*3/2 + (3.1415/2)*(iter-stepSize*15+1)/stepSize;
     point = getClass2Points(radius, angle, -2, 0); 
 elseif stepSize*16+1 <= iter && iter < stepSize*17 
     point = getClass2Points(radius, 0, -2, 0);

 
 
end

