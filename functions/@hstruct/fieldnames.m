% fieldnames:
% ���������б�
%
% ����Ƕ������飬Ĭ��Ҳֻ���ص�һ�����������
%
% maintain: lymslive / 2015-12-04
function names = fieldnames(me)

if numel(me) == 1
    names = fieldnames(me.stin_);
else
    names = fieldnames(me(1).stin_);
    warning('user:hstruct:fieldnames', 'only use the first object in array');
end

end %F
