% ��װ����Ӱ棺
% ��װ��Ҫ��ÿ������װ����ֹ1����������������һ����������
%
% ���������
%   Pvec, ÿ�������Ĳ������ʣ����⡣
%   һά������Ԫ�ض�С��1ʱ��Ϊ���ʣ�����1ʱ��ΪȨ�أ�������������������
%   Nvec, ��װ��Ҫ�������������ɵ��������������
% ���������
%   avgnum, ������������������
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

%% �Ӻ���
% 1���ڴ�����ת��������
function Vector=Ind2Vec(Index,Pow)
	Vector=zeros(size(Pow));
	for i=numel(Pow):-1:1
		Vector(i)=ceil(Index/Pow(i));
		Index=Index-(Vector(i)-1)*Pow(i);
	end
end
% 2����������ת�ڴ�����
function Index=Vec2Ind(Vector,Pow)
	Index=dot(Vector-1,Pow)+1;
end
