function coded = bch155(msg_seq)  %定义函数bch编码
%  输入为msg_seq信息位
%  输出为编码后的码元coded
g=[1 0 1 0 0 1 1 0 1 1 1];            %生成多项式系数
n=15;k=5;                             %默认为BCH（15，5）
%% 从输入msg_seq中提取信息位msg
display('信息位：')
if nargin<1                      %判断输入信息 ,若未输入,系统自动产生5组信息码，并显示出信息位
    nmsg=5;
msg=randi([0,1],[nmsg,k])  
else
    lmsg = length(msg_seq);
    nmsg = ceil(lmsg/k);
    msg = [msg_seq(:);zeros(nmsg*k-lmsg,1)];
msg = reshape(msg,k,nmsg).'    
end
xx = [msg zeros(nmsg,n-k)];   %将输入信息码msg拓展为矩阵形式的xx
%% 进行编码,将xx编码为coded
coded =zeros(nmsg,n);
for i=1:nmsg
    [q,r]=deconv(xx(i,:),g);              %产生余式
    r=abs(rem(r,2));
    coded(i,:)=r;
end
coded = coded + xx;                       %产生信息码
end

