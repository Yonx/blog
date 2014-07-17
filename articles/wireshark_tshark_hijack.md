劫持tshark解包接口
====

wireshark是一款伟大的工具，tshark是wireshark的命令行工具，具有丰富的功能。
但是tshark只能将数据包抓取解析并按照既定格式打印出来，没办法做更自由的数据格式，
比如把特定数据形成Porotobuf格式，也没法对外交互，比如发送到某个socket等。

So，let‘s make it.

