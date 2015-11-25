% 套装收集问题：
%  某套装由 n 件装备组成，每次杀 boss 掉且只掉其中一件，掉哪件由各件概率决定，
%  请问要收集满套装平均需要杀 boss 几次
%
% 输入参数：
%   Pvec, 每个部件的产出概率，互斥。
%   一维向量，元素都小于1时视为概率，大于1时视为权重，不论行向量或列向量
% 输出参数：
%   avgnum, 期望次数，即问题结果
% 注意：
%   combntns 函数将在后续Matlab版本废弃，改用 nchoosek
%
% maintain: lymslive / 2015-11

function avgnum = suit(Pvec)

	if any(Pvec < 0 )
		error('probability should positive float, or int as weight');
	end

	if sum(Pvec) <= 1
		P = Pvec;
	else
		P = Pvec/sum(Pvec);
	end

	n = length(Pvec);
	avgnum = 0;
	for i = 1 : n
		avgnum = avgnum + (-1)^(i+1) * sum( 1 ./ sum(nchoosek(P,i),2) );
	end

end %-of main
