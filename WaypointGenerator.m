
%waypoints from vector.
function waypointlist = WaypointGenerator(A)

%Define matrixe
dimensions = size(A);

nr_fields = dimensions(1);

nr_vectors = dimensions(2);

%%Create waypoints


for j = 1:nr_fields
    
sortedlist = sortlist(A,nr_vectors,j);


end

y = waypoints(A,sortedlist,nr_vectors)
       
        
figure()
hold
xlim([0 3000])
ylim([-1000 1000])
for k = 1:2:2*nr_vectors-1
%   xstart = A(1,sortedlist(1,k),sortedlist(2,k),1);
%   ystart = A(1,sortedlist(1,k),sortedlist(2,k),2);
%   xend = A(1,sortedlist(1,k),endpo(sortedlist(2,k)),1);
%   yend = A(1,sortedlist(1,k),endpo(sortedlist(2,k)),2);
    scatter(y(1,k),y(2,k),'r','filled')
    scatter(y(1,k+1),y(2,k+1),'blue','filled')
    quiver(y(1,k),y(2,k),(y(1,k+1)-y(1,k))/3,(y(2,k+1)-y(2,k))/3)
      a = (k+1)/2;
    b = num2str(a);
    c = cellstr(b);
    dx = 0.1; dy = 0.1;
    text(y(1,k)+dx,y(2,k)+dy,c);
    text(y(1,k+1)+dx,y(2,k+1)+dy,c);


end
hold off

waypointlist = y;

end

function y = waypoints(A,sortedlist,nr_vectors) 
y = zeros(2,nr_vectors*2)
i = 1
for k = 1:nr_vectors

   xstart = A(1,sortedlist(1,k),sortedlist(2,k),1);
   ystart = A(1,sortedlist(1,k),sortedlist(2,k),2);
   xend = A(1,sortedlist(1,k),endpo(sortedlist(2,k)),1);
   yend = A(1,sortedlist(1,k),endpo(sortedlist(2,k)),2);

y(1,i) = xstart;
y(1,i+1) = xend;
y(2,i) = ystart;
y(2,i+1) = yend;
i = i+2;
end
end
  

%%plotter



function sortedlist = sortlist(A,nr_vectors,fieldnumber)
    sortedlist = zeros(2,nr_vectors);
    sortedlist = linspace(1,nr_vectors,nr_vectors);
    [firstvectorindex, startpoint] = findfirstvector(A,nr_vectors,1);
    sortedlist(1,1) = sortedlist(1,firstvectorindex);
    sortedlist(2,1) = startpoint;
    sortedlist(1,firstvectorindex) = 1;
    
    
    
    for i = 2:nr_vectors
        temp = sortedlist(1,i);
        [nextvectorindex,startpoint] = findclosestpoint(A,fieldnumber,sortedlist,i, nr_vectors);
        sortedlist(1,i) = sortedlist(1,nextvectorindex);
        sortedlist(2,i) = startpoint;
        sortedlist(1,nextvectorindex) = temp;
        
    end
        
          
    
    
    
end



function [vektorindex,startpoint] = findfirstvector(B, antallvektorer,jordenummer)
    leastvektorindex = 0;
    startingend = 0;
    distancetoorigin = inf;
for i = 1:antallvektorer
    for j = 1:2
       s =  B(jordenummer,i,j,1) +1000;
       s2 = B(jordenummer,i,j,2) +1000;
    temp = norm([s s2]);
    if (temp < distancetoorigin)
        distancetoorigin = temp;
        leastvektorindex = i;
        startingend = j;
    end
    end
end
vektorindex = leastvektorindex;
startpoint = startingend;
end


        
function y = endpo(startpoint)
  if startpoint == 1
  y = 2;
   else
  y = 1;
  end
end
        
  function [vectorindex,startpoint] = findclosestpoint(A,jordenummer,sortedlist,iterationnumber,antallvektorer)
    leastvektorindex = 0;
    startingend = 0;
    distancetoorigin = inf;
    Prevvectorindex = sortedlist(1,iterationnumber-1);
    endpoint = endpo(sortedlist(2,iterationnumber - 1));
    startpoint = endpo(endpoint);
    PrevX = A(jordenummer,Prevvectorindex,endpoint,1);
    PrevY = A(jordenummer,Prevvectorindex,endpoint,2);
    Prev_prevX = A(jordenummer,Prevvectorindex,startpoint,1);
    DirectionprevVector = PrevX - Prev_prevX;
   
    for i = iterationnumber:antallvektorer 
       for j = 1:2
        NyX = A(jordenummer,sortedlist(1,i),j,1); 
        NyY = A(jordenummer,sortedlist(1,i),j,2); 
       distanceX =  NyX -PrevX;
       distanceY =  NyY - PrevY;
        

       if DirectionprevVector * distanceX < 1;

         temp = norm([0.3*distanceX distanceY]);
       else
        temp = norm([0.1*distanceX distanceY]);
        end

        if (temp < distancetoorigin)
        distancetoorigin = temp;
        leastvektorindex = i;
        startingend = j;
    end
       end
end

vectorindex = leastvektorindex;
startpoint = startingend;
  end
  
