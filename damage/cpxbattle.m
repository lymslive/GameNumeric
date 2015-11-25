% cpxbattle: 'complex battle' relate to simbattle
% ��չ��ս��ģ����
%
% Input:
%   @attacker: ���������ṹ�壬struct
%   @defender: �ܻ������ṹ�壬struct
%   @equation: �˺���ʽ���������
%   @option: ����ѡ�struct �ṹ��
%    option.print: true/false �Ƿ��������ӡս��
%    option.save: true/false �Ƿ�ս��������һ�� cellstr ��
%      ���ʡ�Բ��� option, ��������������������ֻ��ӡ��ֻ�����ڷ��ر�����
%    option.fail: �����������������ж�ʤ���ĺ�����Ĭ�ϰ�Ѫ���и�
%    option.fail1, option.fail2 Ҳ����Ϊǰ����������λ�ֱ���ʧ������
%      Ĭ�Ϲ��� option.fail
%    option.detail: true/false: �����ļ�ս�����������������Ϣ
%      ��Ҫ option.save ��Ϊ false �᷵�� report ��������
%
% Output:
%   @victory: �������Ƿ�ʤ��������ʤ��������ʧ�ܣ�����ֵ��ʾս���غ���
%   @report: ս�����ַ������飬cellstr��cell(n, 1) ������Ԫ��
%     ��� option.detail == true, ����չ report��������������
%     report(:, 2) ����غ�����Ϣ����һ�� report{1, 2} �� 0
%     report(:, 3) �����һ����λ(attacker)��ÿ���ж��غϺ��״̬
%     report(:, 4) ����ڶ�����λ(defender)��ÿ���ж��غϺ��״̬
%     ע�⣺ÿ���غ������������غϣ��ֱ��ʾ������λ���ж��غϣ��ж���״̬��
%     ���һ�� report{end,1} ֻ�Ǳ�ǽ����ı����������� cell Ϊ��
%     �������ݱ��ı���һ��
%
% remark:
%  1. ������ٻغ��� 1v1 ģ�ͣ�attacker �ȹ���
%  2. ÿ�غϵ�������ս����ʽ���ù���˫�����๥��
%     [A B] = equation(A, B, turn)
%     [B A] = equation(B, A, turn)
%     equation �������յĲ�����A,B �Ǳ�ʾ����˫���Ľṹ�壬turn �ǻغ���
%     ����ԭ���Ĳ�ս���� AB�����е����ԣ���Ҫ��Ѫ�������ܱ��޸�
%  3. ���δָ�� option.fail����
%     attacker, defender �ṹ��Ҫ���� .hp �� .h ������ʾѪ�����ԣ�
%     �������Կ���������ֻҪ�����õ� equation �� fail Ҳʹ��ƥ�����������
%  4. ս����ʽ:
%     Round +%2d:\tA --> B;\tA.hp -> %d;\tB.hp -> %d
%     �� AB ����Կ�˫������+/-��ʾ���ԵĻغϣ��г������ж���˫����ʣ��Ѫ��
%     ��ע����ϸս�������һ�к�����Ϊ��
%
% see also: simbattle
%
% maintain: lymslive / 2015-11

function [victory, report] = cpxbattle(attacker, defender, equation, option)

	A = attacker;
	B = defender;

	if nargin < 4 || ~isstruct(option)
		option = struct;
		if nargout < 2
			option.print = true;
			option.save = false;
		else
			option.print = false;
			option.save = true;
		end
		option.fail = @fail;
	else
		if ~isfield(option, 'print')
			option.print = true;
		end
		if ~isfield(option, 'save')
			option.save = true;
		end
		if ~isfield(option, 'fail')
			option.fail = @fail;
		end
	end
	if ~isfield(option, 'fail1')
		option.fail1 = option.fail;
	end
	if ~isfield(option, 'fail2')
		option.fail2 = option.fail;
	end

	report = {};
	replen = 0;
	turn = 0;
	str = '';
	win = '';

	str = sprintf('Start:\tA <-> B;\tA.hp -> %d,\tB.hp -> %d', A.hp, B.hp);
	% ��Ƕ����������ս��
	function dealreport(str, turn)
	if option.print 
			disp(str);
		end
		if option.save
			replen = replen + 1;
			report{replen, 1} = str;
		end
		if nargin > 1 && isfield(option, 'detail') && option.detail
			report{replen, 2} = turn;
			report{replen, 3} = A;
			report{replen, 4} = B;
		end
	end
	dealreport(str, turn);

	while true
		turn = turn + 1;

		% ����غ�ʱ�̣����ж���û˭��
		if option.fail1(A, turn)
			win = 'B';
			break;
		end
		if option.fail2(B, turn)
			win = 'A';
			break;
		end

		% �Ƚ��� A ���ж��غϣ�A ���� B
		[A, B] = equation(A, B, turn);
		str = sprintf('Round +%2d:\tA --> B;\tA.hp -> %d,\tB.hp -> %d', turn, A.hp, B.hp);
		dealreport(str, turn);

		if option.fail2(B, turn)
			win = 'A';
			break;
		elseif option.fail1(A, turn)
			win = 'B';
			break;
		end

		% Ȼ����� B ���ж��غϣ�B ���� A
		[B, A] = equation(B, A, turn);
		str = sprintf('Round -%2d:\tB --> A;\tA.hp -> %d,\tB.hp -> %d', turn, A.hp, B.hp);
		dealreport(str, -turn);

		if option.fail1(A, turn)
			win = 'B';
			break;
		elseif option.fail2(B, turn)
			win = 'A';
			break;
		end
	end

	str = sprintf('Stop: %s wins', win);
	dealreport(str);

	if win == 'A'
		victory = turn;
	else
		victory = -turn;
	end

end %-of main

%% �Ӻ���
% Ĭ�ϵ��ж�ʧ�ܺ�����Ѫ��С��0�������� .hp �� .h
function tf = fail(st, turn)
	if isfield(st, 'hp')
		tf = st.hp <= 0;
	elseif isfield(st, 'h')
		tf = st.h <= 0;
	else
		error('a battle unit should has .hp or .h field!');
	end
end %-of fail
