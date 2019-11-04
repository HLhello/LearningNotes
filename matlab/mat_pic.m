<code>function PlotLineStyle  
% 没有用脚本形式，写成函数形式是因为要调用几个子程序，这样写进一个函数文件里更方便
clear;clc;
%%
x = 0:0.2:2*pi;
y1 = sin(x);
y2 = cos(x);
y3 = 0.2*x;
y4 = 0.05*x.^2;
y5 = 1./(1+x);
subplot(2,2,1)
plot(x,y1,'-d','Color','r','MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10)
% d：表示倒置的菱形，-d表示用线连接，r表示红色，MarkerEdgeColor表示符号边缘颜色，
% MarkerFaceColor表示符号内部颜色，MarkerSize表示符号大小
% 各种线型、符号、颜色代码参考下表
% 颜色用RGB表示、全名称表示
subplot(2,2,2)
plot(x,y2,'-o','Color','c','MarkerEdgeColor',[1 0 1],'MarkerFaceColor','green','MarkerSize',10)
%
%% 线型
% - Solid line (default)
% -- Dashed line
% : Dotted line
% -. Dash-dot line
%% 符号
% o Circle
% + Plus sign
% * Asterisk
% . Point
% x Cross
% s Square
% d Diamond
% ^ Upward-pointing triangle
% v Downward-pointing triangle
% > Right-pointing triangle
% < Left-pointing triangle
% p Pentagram
% h Hexagram
%% 颜色
% LongName ShortName RGB
% 'yellow' 'y' [1 1 0]
% 'magenta' 'm' [1 0 1]
% 'cyan' 'c' [0 1 1]
% 'red' 'r' [1 0 0]
% 'green' 'g' [0 1 0]
% 'blue' 'b' [0 0 1]
% 'white' 'w' [1 1 1]
% 'black' 'k' [0 0 0]
%% 一个坐标轴里绘制多条曲线，两种方法
subplot(2,2,3)
plot(x,y4,'-d','Color','r','MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10)
hold on
plot(x,y5,'-*','Color','c','MarkerEdgeColor',[1 0 1],'MarkerFaceColor','green','MarkerSize',10)
hold off  % hold on 之后之后加上 hold off
subplot(2,2,4)
% 这种方法只能对最后面的一条曲线的线型做修改，前面的曲线只能修改符号和线的形状
plot(x,y1,x,y2,x,y3,'-d','Color','r','MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10)
%% 这些都是常规的绘制曲线方法，下面是我总结出来的一些特殊技巧
% 主要针对的是绘制的曲线数量不定，要求对每条曲线都设置线型
% 这里给了8种线型和符号，当然，你也可以设置更多
% 采用cell类型保存
LineShape = {'-d','-s','-o','-^','-v','-<','->','-p'};
FileName = {'y1','y2','y3','y4','y5'};
figure  % 一定要新建一个Figure，不然会覆盖原来的Figure
% 不管你有多少条曲线，都可以有唯一的一种线型对应
for i = 1:size(FileName,2)
 mLS = LinSP(i);  % 选取一种线型，这里你可以用randi随机选一个序号对应一种线型和符号
 LineColor = LineCL(i);
 % eval函数没用过吧，help一下吧，嘿嘿
 plot(x,eval(FileName{1,i}),LineShape{mLS},'Color',LineColor,'MarkerFaceColor',LineColor, 'MarkerSize',3);
 hold on;
end
hold off
legend(FileName);  % 图例，用cell类型变量作为参数
% 感受一下斜体、下标、粗体是怎么设置的吧
xlabel('\it T_2\rm (ms)','FontSize',12,'FontWeight','bold');  
ylabel('信号幅值(a.u.)','FontSize',12,'FontWeight','bold');
end
%% 下面是子函数
function Color=LineCL(number)
% 返回一个颜色数组
number = mod(number,12);
if number == 0
  number = 12;
end
switch number  % 前面6种是常见的颜色，见上面的颜色对照表
  case 1
 Color = [1 0 1];
  case 2
 Color = [0 1 1];
  case 3
 Color = [1 0 0];
  case 4
 Color = [0 0 0];
  case 5
 Color = [0 0 1];
  case 6
 Color = [0 1 0];
  case 7%  下面的颜色表示我随便写的
 Color = [19 137 211]/255;
  case 8
 Color = [107 100 102]/255;
  case 9
 Color = [188 159 102]/255;
  case 10
 Color = [255 199 127]/255;
  case 11
 Color = [176 0 255]/255;
  otherwise
 Color = [0 128 102]/255;
end
end
function mLS=LinSP(number)
% 返回一种线型序号
mLS = mod(number,8) + 1;
end</code>