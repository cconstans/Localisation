% 
if sum(diff(angleM(3:end-2)))< 0
    pNb = 10:-1:1;
%     angleA = fliplr(aMax3);
else
    pNb = 1:10;
end    
%     
% Linéaire regression
x = 1:length(angleM);

% angleM(angleM>angleM(1))=angleM(angleM>angleM(1))-360;
% angleA(angleM>angleM(end),2)=angleA(angleM>angleM(end),2)-360;
% angleM(angleM>angleM(end))=angleM(angleM>angleM(end))-360;
if angleM(1)>angleM(2) angleM(1)=angleM(1)-360; end
p = polyfit(x,angleM,1);
angleFit = polyval(p,x);  
figure
hA = plot(x,angleM,'-.ok');
hold on
hTh = plot(x,0:36:360-36,'k-');
hFit = plot(x,angleFit);

if AntenneCorrigee
    
    title([arrID ' forme corrigée'] )
else
    title([arrID ' forme circulaire'] )
end
% Plot some side lobe
for ii=2:2
   hSl = plot(x,angleA(:,ii),'o') 
end

xlabel('Ping number')
ylabel('Angle of arrival')
ax = gca;
ax.XTickLabel = pNb;
leg= legend([hA,hTh,hFit, hSl],{'Ping','Theoritical curve','Lin. Reg. Curve','Secondary lobe'},'Location','northwest')
% leg= legend([hA,hFit, hSl],{'Ping','Lin. Reg. Curve','Secondary lobe'},'Location','northwest')

% print([folderOut 'angleOfArrival_' outName '.png'],'-r150','-dpng')