本项目是 [neorv32](https://github.com/stnolting/neorv32) 在矿机控制板 **ebaz4205** 上的实现。

### 用法

克隆此项目到本地

然后打开 vivado

![tcl_console](https://github.com/ATmega8/neorv32_ebaz4205/blob/18271bd9b3ad066eb73289dc05a3f683941b8af4/doc/image/tcl_console.png)

在 tcl 控制台中输入

```tcl
cd /path/to/repo
```

切换工作目录，然后执行 tcl 脚本创建工程

```tcl
source ./neorv32_ebaz4205.tcl
```

然后在创建完成的工程里生成一下 HDL Wrapper

![hdl](https://github.com/ATmega8/neorv32_ebaz4205/blob/18271bd9b3ad066eb73289dc05a3f683941b8af4/doc/image/hdl.png)

接下来就可以综合直至生成 bitstream
