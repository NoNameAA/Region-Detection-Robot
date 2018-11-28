data=csvread('DATA0001.csv');
color=data(2:2:end,2);
encoder=data(3:2:end,2);
encoder(end+1)=7001;
%=====================================
%Raw data
subplot(4,1,1);
plot(color,'red');
xlabel('Index');
ylabel('Raw data');
hold on;
plot(encoder,'blue');
hold off;
%=====================================
%Smooth
subplot(4,1,2);
purecolor=color;
for i=1:length(purecolor)-9
    purecolor(i)=sum(color(i:1:i+9)) / 10;
end
plot(purecolor);
xlabel('Index');
ylabel('Smoothed data');
%ylim([0,70]);
%=====================================
%Peaks
subplot(4,1,3);
diffcolor=( purecolor(3:1:end)-purecolor(1:1:end-2) ) ./ 2;
diffcolor=abs(diffcolor);
plot(diffcolor);
xlabel('Index');
ylabel('Derivative of colors');
%=====================================
%Find peaks
subplot(4,1,4);
plot(diffcolor);
peakcolorx(1)=-100;
peakcolory(1)=-100;
total=1;
for i=1:length(diffcolor)
    if diffcolor(i)>0.8  &&  diffcolor(i)>=diffcolor(i-1)  &&  diffcolor(i)>=diffcolor(i+1)
        if i-peakcolorx(total)<=80  &&  diffcolor(i)>peakcolory(total)
            peakcolorx(total)=i;
            peakcolory(total)=diffcolor(i);
        elseif i-peakcolorx(total)>80
            total=total+1;
            peakcolorx(total)=i;
            peakcolory(total)=diffcolor(i);
        end    
    end
end
%peakcolor

for i=1:total-1
   peakcolorx(i)=peakcolorx(i+1);
   peakcolory(i)=peakcolory(i+1);
end
peakcolorx(total)=0;
peakcolory(total)=0;
total=total-1;

finalx=peakcolorx(1:total);
finaly=peakcolory(1:total);


plot(diffcolor);
hold on;
plot(finalx,finaly,'ro');
hold off;
xlabel('Index');
ylabel('Peaks');
title('Find peaks');
%=====================================
%Print the report
unit=finalx(1);
for i=2:total
    if finalx(i)-finalx(i-1)<unit
        unit=finalx(i)-finalx(i-1);
    end
end

disp('Table of results:');

current_color=0;
last_position=0;
for i=1:total
    len=( finalx(i)-last_position ) / unit;
    %round(len)
    if current_color==0
        display(sprintf('region %d is green , width is %d',i,round(len)) );
    else
        display(sprintf('region %d is blue  , width is %d',i,round(len)) );
    end
    last_position=finalx(i);
    current_color=1-current_color;
end
%=====================================
