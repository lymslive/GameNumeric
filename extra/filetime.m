% 获取文件的最近修改时间
% 参考 java 方法 http://emily2ly.iteye.com/blog/742799
% dir 返回的 date 无法自定义格式
function ftime = filetime(filename)

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar; 

fid = File(filename);
time = fid.lastModified();
fmt = SimpleDateFormat('yyyy-MM-dd HH:mm:ss');
cal = Calendar.getInstance();
cal.setTimeInMillis(time);
ftime = fmt.format(cal.getTime());

end %F-main
