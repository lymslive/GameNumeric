function tf = main_(reply, varargin)
% a test driver methods

if nargin < 1 || isempty(reply)
    reply = 'n';
elseif ischar(reply) && lower(reply(1)) == 'y'
    reply = 'y';
else
    reply = 'n';
end

tf = s_Test(reply);

end %F main

function tf = s_Test(reply)
tf = false;

fprintf('creat an empty stack:\n');
stack = cList();
assert(stack.isemptied(), 'method isemptied() fails');

fprintf('push five number(1: 5) elements to stack:\n');
for i = 1 : 5
    stack.push(i);
end
assert(stack.count == 5, 'properties count fails');

reply = s_pause(reply);

fprintf('test top() method:\n');
assert(stack.top() == 5, 'method top() fails');
assert(stack.top(3) == 3, 'method top(i) fails');
assert(stack.top(1) == 1, 'method top(1) fails');

oldstack = stack;
copystack = stack.clone();
fprintf('display the objects:\n');
oldstack,
reply = s_pause(reply);

fprintf('test pop() method:\n');
assert(stack.top() == stack.pop(), 'pop ~= top ??');
assert(stack.count == 4, 'pop donnot remove element?');
assert(stack.top() == 4, 'new top fails?');
assert(oldstack.top() == stack.top(), 'handle class fails?');
assert(stack.pop(3) == 3, 'pop(i) fails?');
assert(stack.pop(1) == 1, 'pop(1) fails?');
stack,
reply = s_pause(reply);

fprintf('see cloned stack\n');
copystack,
reply = s_pause(reply);

fprintf('retrive the cloned stack\n');
stack = copystack;

fprintf('test type() and cat()\n');
datatype = stack.type();
assert(strcmp(datatype, class(1)), 'type() fails?');
vector = stack.cat();
assert(all(vector == [1:5]), 'cat() fails?');
disp(datatype);
disp(vector);
reply = s_pause(reply);

fprintf('test up and down method\n');
fprintf('up():\n');
stack.up(),
fprintf('up(3):\n');
stack.up(3),
fprintf('down():\n');
stack.down(),
fprintf('down(4):\n');
stack.down(4),
fprintf('up(2, true):\n');
stack.up(2, true),
fprintf('down(5, true):\n');
stack.down(5, true),
reply = s_pause(reply);

fprintf('see the oldstack\n');
oldstack,
reply = s_pause(reply);

fprintf('construct from varargin:\n');
list = cList('a', 'bc', 'def', 'ghijk');
list,
reply = s_pause(reply);
fprintf('test iterator():\n');
next = list.iterator();
disp(next());
disp(next());
disp(next());
disp(next());
assert(isempty(next()), 'next() fails');
reply = s_pause(reply);

fprintf('test iterator(-1):\n');
prev = list.iterator(-1);
disp(prev());
disp(prev());
disp(prev());
disp(prev());
assert(isempty(prev()), 'prev() fails');
reply = s_pause(reply);

fprintf('use iterator in while loop\n');
next = list.iterator();
val = next();
while val
    disp(val);
    val = next();
end
reply = s_pause(reply);

fprintf('test cat string: list.cat()\n');
catstr = list.cat();
disp(catstr);
assert(strcmp(catstr, ['a' : 'k']), 'string cat fails?');

disp('test ended');
tf = true;

end %F sub

% pause the test, let user see the above test result, and
% wait user enter a replay: 
% -y: no pause further more
% -q: quit the test
% -n: next test, default
function reply = s_pause(reply)

if reply == 'y'
    return;
end

reply = input('<<Enter to continue or y to silence continue? :', 's');

if isempty(reply)
    reply = 'n';
else
    if lower(reply(1)) ~= 'y'
        reply = 'n';
    else
        reply = 'y';
    end
end
end %F sub
