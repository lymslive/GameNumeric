% equmultiply:
% ��˵�еĳ˷���ʽ
%
% Input:
%   @atk: ����ֵ��attack
%   @def: ����ֵ��defend
%   @cst: ��������, һ����һ���ȼ����Ǹ�������const
%
% Output:
%   @damage: �����˺�ֵ������������Ѫ���仯
%
% remark:
%   �˷���ʽ�����ڷ����������������ʣ��ʲ���ʡ�Ե������� cst
%   dh = ac/(d+c)
%
%   ֧�������������㣬���ʵ�����õ�� ./
%
% maintain: lymslive / 2015-11

function damage = equmultiply(atk, def, cst)

	a = atk;
	d = def;
	c = cst;

	r = d ./ (d + c);
	dh = a * (1 - r);

	damage = dh;
end %-of main
