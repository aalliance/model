function mu = train(t)
    v = 49*1609.34; % Velocity of the train in m/h
    d = v*t; % Distance traveled by the train at time t in milles
    points = csvread('train.csv');
    [distances, posin] = Distances('train.csv');
    positions = [1,posin,length(points)];
    Daccumulative = 0;
    nsegment = 1;
    found = false;
    
    while (nsegment<=length(distances) && found==false)
        Daccumulative = Daccumulative + distances(nsegment);
        if(d>Daccumulative)
            nsegment = nsegment+1;
        else
          found = true;  
        end
    end
    
    if(nsegment == 1)
        smallDistance = d;
    else
        smallDistance = d-sum(distances(1:nsegment));
    end
    
%     if(nsegment>length(distances))
%         fprintf('Train finished its travel');
%     else
%         theta = atan((points(positions(nsegment+1),2)-points(positions(nsegment),2))/(points(positions(nsegment+1),1)-points(positions(nsegment),1)));
%         v_x = v*cos(theta);
%         v_y = v*sin(theta);
%         mu(1) = v_x*t;
%         mu(2) = v_y*t;
%     end

m = (points(positions(nsegment+1),2)-points(positions(nsegment),2))/(points(positions(nsegment+1),1)-points(positions(nsegment),1));
mu(1) = ((smallDistance^2)/(sqrt(smallDistance^2*(1+m^2))))+points(positions(nsegment),1);
mu(2) = ((smallDistance^2*m)/(sqrt(smallDistance^2*(1+m^2))))+points(positions(nsegment),2);
end


