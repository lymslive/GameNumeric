% equdivide:
% 传说中的除法公式
%
% Input:
%   @atk: 攻击值，attack
%   @def: 防御值，defend
%
% Output:
%   @damage: 单次伤害值，即被击方的血量变化
%
% remark:
%   除法公式本质上与乘法公式同源，不过防御参数就是攻击
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

