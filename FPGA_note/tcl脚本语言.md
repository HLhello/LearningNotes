# TCL脚本语言

Tool Command Language

TCL倾向于在后端的应用，而prel倾向于文件的处理

TCL 命令提示符，都是按照字符来解析的，TCL解释器运用规则把命令分成一个个独立的单词，同时进行必要的置换

TCL中很少用到逗号来分隔命令，大部分是使用空格分隔，通过空格的分隔将命令分隔成字符

置换

1. 变量置换 " $ " --> 变量名换成变量的值

2. 命令置换 " [ ] "--> 方括号内使一个完整的TCL语句

3. 转义置换 " \ " --> 将"\n"转义为换行

4. e.g.

   ```tcl
   Vivado% set a "show"
   show
   Vivado% puts $a
   show
   Vivado% set a [expr 3+4]
   7
   Vivado% puts $a
   7
   Vivado% set x 2
   2
   Vivado% set y 4
   4
   Vivado% puts [expr $x +$y]
   6
   Vivado% puts "[$a]\n"
   [7]
   
   Vivado% puts "$a\n"
   7
   
   Vivado%
   ```

5. TCL解释器对双引号中的 $ 和 [] 符号进行变量置换和命令置换

6. e.g.

   ```tcl
   Vivado% puts "\t[expr $x+$y]"
           6
   Vivado% 
   ```

7. 在花括号内，所有的特殊字符都将成为普通字符，tcl不会对其做特殊处理

8. e.g.

   ```tcl
   Vivado% puts {\t[expr $x + $y]}
   \t[expr $x + $y]
   Vivado%
   ```

9. 变量就是某种容器的名称，可以存储一个值，变量的名称在程序运行中保持不变，但是变量名对应的值会在程序运行中根据需要发生变化

10. 定义一个变量，与变量取值

    ```set 变量名 "变量值"```

    ```$变量名```

数组

TCL中数组可以存储很多值，通过对元素名进行检索，类似于某种事物的几种不同的属性，每一中属性都有其独立的值

1. 定义一个数组 ```set 数组名(元素名) 值```

2. e.g.

   ```tcl
   Vivado% set cell_1(ref_name) "ABC"
   ABC
   Vivado% set cell_1(full_name) "bufx2"
   bufx2
   Vivado% set cell_1(pins) "sdfg"
   sdfg
   Vivado% array size cell_1
   3
   Vivado% array names cell_1
   ref_name pins full_name
   Vivado% 
   ```

3. 列表是标量的有序集合

4. 定义 ```set 列表名{元素1 元素2 元素3 ...}```

5. 取值 ```$列表名```

6. e.g.

   ```tcl
   Vivado% set ivt_list {ivtx1 ivtx2 ivtx3}
   ivtx1 ivtx2 ivtx3
   Vivado% puts $ivt_list
   ivtx1 ivtx2 ivtx3
   Vivado%
   ```

7. 关于列表的几个命令

   1. concat 合并两个列表

   2. e.g.

      ```tcl
      Vivado% set ivt_list1 {ivtx1 ivtx2 ivtx3}
      ivtx1 ivtx2 ivtx3
      Vivado% set ivt_list2 {ivtx4 ivtx5 ivtx6}
      ivtx4 ivtx5 ivtx6
      Vivado% concat $ivt_list1 $ivt_list2
      ivtx1 ivtx2 ivtx3 ivtx4 ivtx5 ivtx6
      Vivado%
      ```

   3. llength 列表长度

   4. e.g.

      ```tcl
      Vivado% llength $ivt_list1
      3
      Vivado% llength [concat $ivt_list1 $ivt_list2]
      6
      Vivado%
      ```

   5. lindex 根据下标索引列表中的某个元素

   6. e.g.

      ```tcl
      Vivado% llength $ivt_list1
      3
      Vivado% llength [concat $ivt_list1 $ivt_list2]
      6
      Vivado%
      ```

   7. lappend 添加新的元素

   8. e.g.

      ```tcl
      Vivado% lappend a $b # 向a中添加列表b，使b作为a的第4个元素
      1 2 3 4 {3 7 9 0}
      Vivado% lindex $a 4
      3 7 9 0
      Vivado% lindex $a 3
      4
      Vivado%
      ```

   9. lsort 将列表按照规则排序

      - -real 按照浮点数值大小排序
      - -unique 唯一化，删除重复的元素
      - -默认 按照ASCII序列进行排序

   10. e.g.

       ```tcl
       Vivado% set a {2 3 4 5 6 7 3}
       2 3 4 5 6 7 3
       Vivado% lsort -real $a
       2 3 3 4 5 6 7
       Vivado% lsort -unique $a
       2 3 4 5 6 7
       Vivado% lsort $a
       2 3 3 4 5 6 7
       Vivado%
       ```


运算

1. 数学运算 +-*/ 

2. e.g.

   ```tcl
   % expr 5/2
   2
   % expr 5/2.0
   2.5
   % expr 5.0/2
   2.5
   % expr 5.0/2.0
   2.5
   %
   ```

3. 逻辑运算 </<=/>/>=/==/!=

控制语句（使用的时候在查一查）

1. if else
2. foreach
3. while
4. for
5. break
6. continue

1. 过程函数，关键字 —— proc， 类似于C语言中的函数

   1. 全局变量：所有过程之外定义的变量
   2. 局部变量：对于在过程中定义的变量，只在过程中被使用，且退出过程被删除
   3. global可在过程内部引用全局变量，使用的时候可以百度一下

2. e.g.

   ```tcl
   Vivado% proc add {ss dd} {
   set sum [expr $ss + $dd]
   return $sum
   }
   Vivado% add 3 4
   7
   Vivado%
   ```

正则匹配

1. \w 匹配一个字母，数字，下滑线

2. \d 匹配一个数字

3. \s 表示空格

4. .  表示任意一个字符

5. " * " 0次或者多次匹配

6. " + " 一次或者多次匹配

7. " ? " 0次或者次的匹配

8. 锚位，用来指示字符串当中的开头和结尾的位置，^ 匹配开头，$ 匹配结尾

9. e.g.

   1. 匹配：```abc123```的正则
      - ```\w+\d+```
   2. 匹配：```123ADC23```
      - ```^\d\d\d\w+\d\d\d$```
      - 匹配开头为三个数字和结尾也为三个数字的字符串

10. TCL中正则匹配指令

    ``` regexp switches exp string matchVar subMatchVar subMatchVar```

    - regexp 正则表达式命令

    - switches

    ​	-all在字符串中进行全部匹配或者替换，会返回匹配或者替换的总次数

    ​	-nocase将字符串中的大写都当成小写看待

    ​	-indices 存在子匹配变量中不再是字符，而是index

    ​	--表示后面不再是switches，而是正则表达式的模式了，即使后面紧接着是-

    - exp 正则表达式
    - string 匹配的字符串
    - matchvar，submatchvar， submatchvar 捕获到的字符串

11. e.g.

    ```tcl
    % regexp {^(\w+)\s\w+\s(\d+).*} "hello is 25 years old" total name age
    1
    % puts $total
    hello is 25 years old
    % puts $name
    hello
    % puts $age
    25
    %
    ```

文本处理

1. open 文件 打开方式，返回fileid

2. gets fileid 变量名 按行读并返回该行的字符数

3. puts fileid 内容

4. close fileid

5. e.g.

   ```tcl
   % open vivado.jou "r"
   file2030030
   % get file2030030 firstline
   60
   % puts $firstline
   #-----------------------------------------------------------
   % close file2030030
   % open vivado.jou "w"
   file2030070
   % puts file2030070 "hello modified with tclsh"
   % close file2030070
   ```