function display(obj)
fprintf('doc(%s)%s\n', obj.file, obj.xpath);
display(obj.self);
end
