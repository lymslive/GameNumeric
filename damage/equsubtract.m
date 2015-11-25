% equsubtract:
% 传说中的减法公式
%
% Input:
%   @atk: 攻击值，attack
%   @def: 防御值，defend
%   @threshold: 可选的保底下限，一般是小数，表示最低伤害为攻击的百分比
%
% Output:
%   @damage: 单次伤害值，即被击方的血量变化
%
% remark:
%   如果输入参数省略 threshold，则减法伤害最低截断为 0，不是 1
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
