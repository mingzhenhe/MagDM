function [X,labels] = classSwissRoll(Num)
% initialize the  # of data
N=Num;
% standard swiss roll data
% tt is the numerical matrix which contains the position imformation of the data  
tt = (3*pi/2)*(1+2*rand(1,N));   
prp = 0.1;
height = prp*rand(1,N);
X = [prp*(tt).*cos(tt); height; prp*(tt).*sin(tt)];  %3*Num
num1 = 0;
num2 = 0;
num3 = 0;
num4 = 0;
labels = zeros(Num,1);

% 2 classes dataset
% for num = 1:2000
%     if(tt(num)<9.45)
%         labels(num)=1;
%         num1 = num1+1;
%     elseif(tt(num)<=15)
%         labels(num)=2;
%         num2 = num2+1;
%     end
% end

% 4 classes dataset
for num = 1:Num
    if(tt(num)<7.25)
        labels(num)=1;
        num1 = num1+1;
    elseif(tt(num)<9.45)
        labels(num)=2;
        num2=num2+1;
    elseif(tt(num)<11.75)
        labels(num)=3;
        num3=num3+1;
    elseif(tt(num)<=14.25)
        labels(num)=4;
        num4 = num4+1;
    end
end

% %=== Visualize the data, show the picture
% point_size = 20;
% figure(1)
% scatter3(X(:,1),X(:,2),X(:,3), point_size,labels,'filled');
% colorbar;
% title("4 classes swiss roll");
% view([12 12]); 
% 1
end

