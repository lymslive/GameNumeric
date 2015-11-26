classic problem solusion
======

典型问题解法收集。doc/ 目录下有理论分析文档，源于某位业内前辈的研究。

suit
-----

    avgnum = suit(Pvec)

套装收集问题，指定各件掉率，集满平均需要几次？

suitmore
--------

    avgnum = suitmore(Pvec,Nvec)

套装问题加强版，各单件要求收集多件，集满又平均要几次？

markovto
-------

    [step, stop, cost] = markovto(Pmatrix, source, target, lcost)

马氏链转移，从起点到终点需要平均多少步，平均多少消耗？

markovby
--------

    [target cost] = markovby(Pmatrix, source, step, lcost)

马氏链转移，从起点经过固定步数，平均能前进到哪步，及多少消耗？

markovbyto
---------

    p = markovbyto(Pmatrix, source, target, step)

马氏链转移，从起点经过固定步数，能达到前面某步的概率？

备注：一般游戏中更常见的是 suit 与 markovto。
猎命与有失败强化问题本质同源，用 markovto 或 mrkovby 计算。
