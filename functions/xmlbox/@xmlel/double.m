% 将 xmlel 对象数组转化为矩阵
% 返回与第一个元素同组的属性值矩阵
% 注意，如果属性值不能转化为 double，则返回字符串矩阵
function val = double(obj)
val = obj.atMatrix(obj(1).name);
end %F-main
