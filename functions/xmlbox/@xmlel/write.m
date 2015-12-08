% write: 将格式化的 xml 文本写入文件中
% 调用 char()
function ST = write(obj, file)
ST = 1;

fid = fopen('file', 'w');
fprintf(fid, '%s', obj.char());
fclose(fid);

ST = 0;
end %F-main
