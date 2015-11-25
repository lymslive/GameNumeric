% equmultiply:
% 传说中的乘法公式
%
% Input:
%   @atk: 攻击值，attack
%   @def: 防御值，defend
%   @cst: 防御参数, 一般在一定等级下是个常数，const
%
% Output:
%   @damage: 单次伤害值，即被击方的血量变化
%
% remark:
%   乘法公式依赖于防御参数计算免伤率，故不能省略第三参数 cst
%   dh = ac/(d+c)
%
%   支持数组批量运算，因此实现中用点除 ./
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
