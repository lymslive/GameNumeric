% 套装问题加版：
% 套装中要求每个单件装备不止1，各件所需数量以一个向量给出
%
% 输入参数：
%   Pvec, 每个部件的产出概率，互斥。
%   一维向量，元素都小于1时视为概率，大于1时视为权重，不论行向量或列向量
%   Nvec, 套装所要求各单件数量组成的向量，须横向量
% 输出参数：
%   avgnum, 期望次数，即问题结果
%
% maintain: lymslive / 2015-11

function avgnum = suitmore(Pvec,Nvec)

	if sum(Pvec) <= 1
		P = Pvec;
	else
		P = Pvec/sum(Pvec);
	end

	N = Nvec;

	n=numel(N);Mat=zeros(1,prod(N+1));
	Pow=cumprod(N+1);Pow=[1 Pow(1:end-1)];

	for index=2:numel(Mat)
		vector=Ind2Vec(index,Pow);
		SubInd=ones(n,1)*vector-eye(n);
		Uper=zeros(1,n);Down=zeros(1,n);
		for i=1:n
			if SubInd(i,i)>0
				Uper(i)=P(i)*Mat(Vec2Ind(SubInd(i,:),Pow));
				Down(i)=P(i);
			end
		end
		Mat(index)=(1+sum(Uper))/sum(Down);
	end
	avgnum=Mat(end);

end %-main

%% 子函数
% 1、内存索引转数组索引
function Vector=Ind2Vec(Index,Pow)
	Vector=zeros(size(Pow));
	for i=numel(Pow):-1:1
		Vector(i)=ceil(Index/Pow(i));
		Index=Index-(Vector(i)-1)*Pow(i);
	end
end
% 2、数组索引转内存索引
function Index=Vec2Ind(Vector,Pow)
	Index=dot(Vector-1,Pow)+1;
end
