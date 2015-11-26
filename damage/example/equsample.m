% 假设一种战斗模型
% 基本伤害公式用除法
% A 打 B，附加中毒两回合，不叠加，使B 在自己行动回合受10点伤害 
% B 有反伤，每次被击反伤 10 点伤害
% (实际效果半斤八两，都增加10伤害而已)
% 注意：该函数不用主动调用，
% 由 cpcbattle 每回自动调用两次，且 A/B 的调用顺序交替
function [A B] = equsample(A, B, t)

	% 基本伤害，调用除法公式
	dh = equdivide(A.atk, B.def);
	dh = floor(dh);
	B.hp = B.hp - dh;

	% 毒与反伤都简单固定 10 伤害
	du = 10;
	fs = 10;

	% 这是 B 的被动回合
	% 如果中毒者在对方行动时也扣血，则取消注释这段
	% if isfield(B, 'isdu') && B.isdu
		% if t - B.duStart < 2
			% B.hp = B.hp - du;
		% else
			% B.isdu = false;
		% end
	% end

	% 由于 A B 是互相打的，调用顺序可能是反过来的
	% 调用该函数时，是 A 在自己行动回合
	if isfield(A, 'isdu') && A.isdu
		if t - A.duStart < 2
			A.hp = A.hp - du;
		else
			% 超过回合，中毒 debuff 消失
			A.isdu = false;
		end
	end

	% 如果 A （攻击方）有能下毒的技能
	if isfield(A, 'candu') && A.candu
		if ~isfield(B, 'isdu') || ~B.isdu
			% 如果 B 未中毒，则令其中毒，并保存中毒开始时间（回合）
			B.isdu = true;
			B.duStart = t;
			% B.hp = B.hp - du;
			% 这里设定 A 能必定让 B 中毒正常游戏或许应该是概率性中毒
		else
			% B 已经中毒，不能叠加的话什么事也不用做
		end
	end

	% 如果 B （被击方）有反伤技能，让 A 也减少一定伤害
	if isfield(B, 'canfs') && B.canfs
		A.hp = A.hp - fs;
	end

	% 函数结尾，将 A B 的状态返回

end %-of main

%%
% 模拟结果一 ：
% A第一回合让B中毒，B 到第三回合会停止中毒，到第四回合才重新中毒
% 所以 B 少中毒一回合，但每回合 A 打 B 都反伤
% 因此三回合后B出现胜势，最后是B胜，A 被反伤死
