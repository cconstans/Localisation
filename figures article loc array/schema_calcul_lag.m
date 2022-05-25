theta=-30;
R=2;

H1=[-0.5, 1.5]*0.8;
Hi=[-1.5, 0.5]*0.8;
ypi=(Hi(1)*tand(theta)+Hi(2))/(1+tand(theta)^2);
xpi=ypi*tand(theta);

yp1=(H1(1)*tand(theta)+H1(2))/(1+tand(theta)^2);
xp1=yp1*tand(theta);

figure,

quiver(R*sind(theta),R*cosd(theta),-sind(theta)/2,- cosd(theta)/2,'Color','r','LineWidth',2);
text(R*sind(theta)+0.1,R*cosd(theta),'K=[-sin(\theta),-cos(\theta),-z_0/R]','Color','r','FontSize',14)
hold on, plot([0 0],[-1 2],'Color',[0.5 0.5 0.5])
plot([-2 1],[0 0],'Color',[0.5 0.5 0.5])
plot([3*sind(theta),-3*sind(theta)],[3*cosd(theta),-3*cosd(theta)],'Color',[0.5 0.5 0.5])
text(0.1,-0.1,'0')
text(-0.1,0.3,'\theta','FontSize',14)
plot(H1(1),H1(2),'bx'); text(H1(1)+0.1,H1(2)+0.1,'H1','Color','b','FontSize',14)
plot(Hi(1),Hi(2),'bx'); text(Hi(1)+0.1,Hi(2)-0.1,'Hi','Color','b','FontSize',14)
plot(xpi,ypi,'bx'); 
plot([xpi Hi(1)],[ypi Hi(2)],'b--'); 
plot(xp1,yp1,'bx'); 
plot([xp1 H1(1)],[yp1 H1(2)],'b--'); 
plot([xp1 xpi],[yp1 ypi],'b','LineWidth',3); 
text(xpi,(yp1 +ypi)/2,'\delta','FontSize',14,'Color','b'); 

xlim([-2 0.5]),ylim([-0.5 2])
daspect([1 1 1])
