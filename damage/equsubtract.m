% equsubtract:
% ��˵�еļ�����ʽ
%
% Input:
%   @atk: ����ֵ��attack
%   @def: ����ֵ��defend
%   @threshold: ��ѡ�ı������ޣ�һ����С������ʾ����˺�Ϊ�����İٷֱ�
%
% Output:
%   @damage: �����˺�ֵ������������Ѫ���仯
%
% remark:
%   ����������ʡ�� threshold��������˺���ͽض�Ϊ 0������ 1
%
% maintain: lymslive / 2015-11

function damage = equsubtract(atk, def, threshold)

	a = atk;
	d = def;
	if nargin >= 3
		k = threshold;
	else
		k = 0;
	end

	dh = a - d;
	dh = max(dh, k * a);

	damage = dh;

end %-of main
