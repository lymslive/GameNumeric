% 测试用例
function ST = main()

az = ['a' : 'z'];
h = qHash();
for i = 1 : 30
	strlen = 3;
	key = '';
	for k = 1 : strlen
		ch = az(randi(strlen));
		key = [key ch];
	end
	% h.(key) = i; % in class method, subsref not called
	h.set(key, i);
	h.display;
end

end %F-main
