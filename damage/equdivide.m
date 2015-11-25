% equdivide:
% ��˵�еĳ�����ʽ
%
% Input:
%   @atk: ����ֵ��attack
%   @def: ����ֵ��defend
%
% Output:
%   @damage: �����˺�ֵ������������Ѫ���仯
%
% remark:
%   ������ʽ��������˷���ʽͬԴ�����������������ǹ���
%   dh = a^2/(d+a)
%
% maintain: lymslive / 2015-11

function damage = equdivide(atk, def)

	a = atk;
	d = def;
	c = a;

	r = d ./ (d + c);
	dh = a * (1 - r);

	damage = dh;
end %-of main

