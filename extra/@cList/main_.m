function tf = main_(varargin)
% a test driver methods

s_Test();

tf = true;
end %F main

function s_Test()

fprintf('creat an empty stack:\n');
stack = cList();
assert(stack.isemptied(), 'method isemptied() fails');

fprintf('push five number(1: 5) elements to stack:\n');
for i = 1 : 5
    stack.push(i);
end
assert(stack.count == 5, 'properties count fails');

fprintf('test top() method:\n');
assert(stack.top() == 5, 'method top() fails');
assert(stack.top(3) == 3, 'method top(i) fails');
assert(stack.top(1) == 1, 'method top(1) fails');

oldstack = stack;
copystack = stack.clone();
fprintf('display the objects:\n');
oldstack,
fprintf('test pop() method:\n');
assert(stack.top() == stack.pop(), 'pop ~= top ??');
assert(stack.count == 4, 'pop donnot remove element?');
assert(stack.top() == 4, 'new top fails?');
assert(oldstack.top() == stack.top(), 'handle class fails?');
assert(stack.pop(3) == 3, 'pop(i) fails?');
assert(stack.pop(1) == 1, 'pop(1) fails?');
stack,

fprintf('see cloned stack\n');
copystack,

fprintf('retrive the cloned stack\n');
stack = copystack;

fprintf('test type() and cat()\n');
datatype = stack.type();
assert(strcmp(datatype, class(1)), 'type() fails?');
vector = stack.cat();
assert(all(vector == [1:5]'), 'cat() fails?');
disp(datatype);
disp(vector);

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

fprintf('see the oldstack\n');
oldstack,

fprintf('construct from varargin:\n');
list = cList('abc', 'bcd', 'cde', 'def');
list,
fprintf('test iterator():\n');
next = list.iterator();
disp(next());
disp(next());
disp(next());
disp(next());
assert(isempty(next()), 'next() fails');
fprintf('test iterator(-1):\n');
prev = list.iterator(-1);
disp(prev());
disp(prev());
disp(prev());
disp(prev());
assert(isempty(prev()), 'prev() fails');

fprintf('use iterator in while loop\n');
next = list.iterator();
val = next();
while val
    disp(val);
    val = next();
end

end %F sub
