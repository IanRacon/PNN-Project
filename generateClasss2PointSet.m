function [point] = generateClasss2PointSet(iter, stepSize)
 %1 - 100 środek stoi w miejscu
 %101 - 150 przesówamy się o 90 stopni
 %151 - 200 stoimy w miejscu na pozycji 90 stopni
 %201 - 250 idziemy od 90 do 180 stopni
 %251 - 300 stoimy w miejscu na pozycji 180
 %301 - 350 idziemy od 180 do 270 stopni
 %351 - 400 stoimy w miejscu na pozycji 270
 %401 - 450 idziemy od 270 do 360 stopni
 radius = 2;
 point = [0,0];
 
 if 1 <= iter && iter <= stepSize
     point = getClass2Points(radius, 0);
 elseif stepSize+1 <= iter && iter < stepSize*2
     angle = (3.1415/2)*(iter-stepSize+1)/stepSize;
     point = getClass2Points(radius, angle);
 elseif stepSize*2+1 <= iter && iter < stepSize*3
     point = getClass2Points(radius, 3.1415/2);  
 elseif stepSize*3+1 <= iter && iter < stepSize*4
     angle = 3.1415/2 + (3.1415/2)*(iter-stepSize*3+1)/stepSize;
     point = getClass2Points(radius, angle);
 elseif stepSize*4+1 <= iter && iter < stepSize*5
     point = getClass2Points(radius, 3.1415);
 elseif stepSize*5+1 <= iter && iter < stepSize*6
     angle = 3.1415 + (3.1415/2)*(iter-stepSize*5+1)/stepSize;
     point = getClass2Points(radius, angle);
 elseif stepSize*6+1 <= iter && iter < stepSize*7 
     point = getClass2Points(radius, 3.1415*3/2);
 elseif stepSize*7+1 <= iter && iter < stepSize*8
     angle = 3.1415*3/2 + (3.1415/2)*(iter-stepSize*7+1)/stepSize;
     point = getClass2Points(radius, angle); 
 end
 
end

