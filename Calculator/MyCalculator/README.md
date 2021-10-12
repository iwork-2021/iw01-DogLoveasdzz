# 一.功能说明
    + 实现了竖屏下按钮的全部功能
    + 横屏下部分功能未实现，如下：
        + 左右括号。由于完成的是单步运算的计算器，故括号未实现
        + 2nd 按键。用于切换部分按键功能
        + 弧度制与角度制的切换
    
# 二.实现过程
## 1.UI制作
1. 使用stack view组织视图和控件。这部分在课程以及示例视频中均有提及，不再描述。
2. 为视图与控件添加约束。只完成上述功能的话，由于缺少约束，控件会在手机旋转屏幕过后挤在一起，所以需要给每一个控件和视图添加大小约束（长与宽相对父控件的比例），以及位置约束（最左端以及最上端相对父控件/其他同层次控价的位置）。
3. 区分横屏与竖屏的UI布局。在控件、约束属性中，添加install的条件，使之仅在横屏或竖屏下有效。
4. 添加按钮属性，如背景色，字体。也可以在添加runtime属性，使之呈现圆角效果

## 2.计算模块制作
1. 首先仿照示例视频，完成部分单目操作符，双目操作符，数字按键的功能
2. 改进“=”。示例中的“=”只会在双目操作符中使用，单目操作符会直接给出结果。对于双目操作符，有形式a op b =，示例中通过将其拆分为一对“数字+操作符”，先将a op储存起来，在调用等号时，将储存起来的a op与b一同计算，给出结果。这也导致了，打开计算机，输入数字后接等号，会导致找不到a与op，程序崩溃。或者在进行一次双目运算后，输入数字接等号，会继承上一个算式的a与op。故我对以上内容进行优化，使之贴近真实的计算器。
3. 添加小数点。小数点按钮的功能和数字按钮一样。只是需要限制小数点个数。我是在ViewController里对小数点的个数进行限制。个人认为应当在计算模块实现，但是实现起来难度有点大，故直接在ViewController内进行限制
4. 实现Rand。添加闭包()->Double ，参数空返回double类型数，用于返回drand48函数的值
5. 实现mc、m+、m-、mr。在Calculator类中添加static成员变量，以及对该变量对于的加、减、重置、读取的静态方法，以便在操作符对应的函数内可以直接读取、修改改静态变量。

# 三.内容展示
截图放在目录“iw01-DogLoveasdzz/Calculator/images“下
1. 0.5-9=-8.5
2. log 7
3. rand
以上三式的截图位于该目录下的同名文件夹内。