% t1=rand(1,20);
% t2=rand(1,20);
% theta1=10; % from AIS
% theta2=80; % from AIS
% Nhydro=20;
% c0=1500;
% load('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation_reseau\virtual_data\signal_211028_103451.mat');

R1=mean(t1)*c0;
R2=mean(t2)*c0;

% R1=R1_th;
% R2=R2_th;

M=[cosd(theta1) sind(theta1); cosd(theta2) sind(theta2)];
if det(M)==0
    error('Déterminant nul')
end

x=zeros(1,Nhydro);
y=zeros(1,Nhydro);

for ii=1:Nhydro
    Ci=[R1-t1(ii)*c0; R2-t2(ii)*c0];
    Xi=M\Ci;
    x(ii)=Xi(1);
    y(ii)=Xi(2);
end

figure,
xlim([-20 20 ]), ylim([-20 20 ]), daspect([1 1 1])
for ii=1:Nhydro
    hold on;
    p1=plot(x_th(ii),y_th(ii),'kx');
    p2=plot(x(ii),y(ii),'rx');
end
quiver([ 20*cosd(theta1) 20*cosd(theta2)],[20*sind(theta1) 20*sind(theta2)],...
   [ -cosd(theta1) -cosd(theta2)],[-sind(theta1) -sind(theta2)],0.5)
xlabel('x (m)'), ylabel('y (m)')
legend('point théorique','point estimé')