function [ areas, lists, numberOfPixelsPrArea, usedSeeds ] = regionGrow( I, seed, T, sizeT )
%REGIONGROW Summary of this function goes here
%   Detailed explanation goes here

% size of input
s = size(I);
ss = size(seed);

% Init Queue
BaseQueue(1,:) = seed(1,:); 
queue(1,:) = seed(1,:);
n = 1;

sq = size(queue);

usedSeeds(ss(1),2) = 0;

%   Init lists and noppa

list(s(1)*s(2),2) = 0;
lists(ss(1), s(1)*s(2),2) = 0;
numberOfPixelsPrArea(ss(1)) = 0;
numberOfAreas = 0;
pixelsThisList = 0;

%   Init seqs

areas(ss(1), s(1),s(2)) = 0;

%   init seq - tmp picture

seq(s(1),s(2)) = 0;

diff_x = 0;
diff_y = 0;

areaOverlap = false; %if an area is found to overlap previous areas

%-------------------------------------------------------init done


for queuePost = 1:ss(1) % loop for each seed(hopefully each area)
    
    seq(:,:) = 0;
    queue = BaseQueue;
    list(:,:)=0;
    
    queue(1,:) = seed(queuePost,:);
    
    areaOverlap = false;
    pixelsThisList = 0;
    
    sq = size(queue);
    n = 1;
    
    for overlapCheck = 1:numberOfAreas %loop checks for overlap with previous areas
       if areas(overlapCheck, queue(1,1),queue(1,2)) == 1
           areaOverlap = true;
           break;
       end
    end

     if areaOverlap
          continue;
     end
    
    while n <= sq(1) %loop for queue this seed
       i=queue(n,:);
       n = n+1;
       
       pixelsThisList = pixelsThisList +1;
       list(pixelsThisList,:) = [(i(1)), (i(2))];
   
        
       
        
        %-------------------------------------------Code for THIS area
        for j = 0:1

               %X direction
            if i(1)-1 + j*2 > 0 && i(1)-1 + j*2 <= s(1)

            diff_x = abs(I(i(1),i(2)) - I(i(1)-1 + j*2,i(2)));

            if diff_x <= T
                if seq (i(1)-1 + j*2,i(2)) == 0
                    queue(end+1,:) = [i(1) - 1 + j*2, i(2)];
                     seq(i(1)-1 + j*2,i(2))=1;

                end
            end

            end
            
            %Y direction
            if i(2) - 1 + j*2 > 0 && i(2) - 1 + j*2 <= s(2)

            diff_y = abs(I(i(1),i(2)) - I(i(1), i(2) - 1 + j*2));

            if diff_y <= T
                if seq (i(1), i(2) - 1 + j*2) == 0

                    queue(end+1,:) = [i(1), i(2) - 1 + j*2];
                    seq(i(1), i(2) - 1 + j*2) = 1;
                    
                end
            end

            end

        end

        sq = size(queue);
    end
    
    %-------------------------------------------code for areas

    if areaOverlap == false
        
        if pixelsThisList >= sizeT
            

            numberOfAreas = numberOfAreas+1;
            usedSeeds(numberOfAreas,:) = seed(queuePost,:);
            areas(numberOfAreas,:,:) = seq;
            lists(numberOfAreas,:,:) = list;
            numberOfPixelsPrArea(numberOfAreas) = pixelsThisList;
        
        end
   
    end
   

end



    areas(numberOfAreas+1:ss(1),:,:) = [];
    lists(numberOfAreas+1:ss(1),:,:) = [];
    numberOfPixelsPrArea(numberOfAreas+1:ss(1)) = [];
    usedSeeds(numberOfAreas+1:ss(1),:) = [];


end

