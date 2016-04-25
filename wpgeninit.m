close all
if exist('gradientImage', 'var') == 0 
clear all;
end
warning('off', 'all')
% addpath(genpath('/home/cmath/jsonlab'))

IP = '10.22.71.122';
socket = tcpip(IP, 9191, 'NetworkRole', 'client');
set(socket, 'Timeout', 0)
set(socket,'OutputBufferSize',4096);

connected = false;

while connected == false
    try    
        fopen(socket);
        connected = true;
    catch
       connected = false; 
    end
end

userInputPoint = [0.2 0.2];
fieldToFindTracks = 4;

imageName = 'images/farm.PNG';
I = im2double(imread(imageName));

% Generating data - The important part

if exist('gradientImage', 'var') == 0 
[fieldAreas, gradientImage] = processImage(I, true);
end

disp('done processing');

while true
	bytesRead = 0;
	while bytesRead == 0
	 [package, bytesRead] = fread(socket);
		if bytesRead ~= 0
			try
				data = loadjson(char(package)')
				status = data.status; 
				area = data.area;
			catch
				disp('Could not unmarshal data')
                bytesRead = 0;
			end
		end

    end
    
   
    fieldToFindTracks = whichFieldIsPoint(fieldAreas, area);
    
    if fieldToFindTracks == -1
        disp('Miss');
        disp(area);
        continue;
    end
    
    disp('Hit');
    disp(fieldToFindTracks);
    
    [vectors,recreated] = findTracksInField(gradientImage, fieldAreas, fieldToFindTracks);
    
    disp('found vectors');
    
    sHitI = size(gradientImage);
    vectorImage = drawVectorImage(vectors, sHitI);
    
    figure(1);
    imshow(vectorImage);
    
	%vectors = vectors;
	length = size(vectors);
	length = length(1)
    A = zeros(1,length,2,2);
	for i = 1:length
		A(1,i,:,:) = [vectors(i,1) vectors(i,2);
		vectors(i,3) vectors(i,4)];
	end

	waypoints = WaypointGenerator(A);

	data = struct(...
				'name',{'imaging'},...
				'status', {'start'},...
				'area', {[0,0]},...
				'waypoints_x',{waypoints(1,:)./2944},...
				'waypoints_y',{waypoints(2,:)./1633});

	package = savejson('',data);
	set(socket, 'Timeout', 2)
	fwrite(socket, package)
	set(socket, 'Timeout', 0)
end
