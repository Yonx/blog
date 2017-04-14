---
title: 加速正则表达式匹配过程
date: 2017-04-05 23:25:52
tags:
 - 正则
 - re2
 - cpp
 - 性能
---


我们有个小系统，要load几十亿域名，支持字符串查询／正则模式匹配等等各种查找方式，以期找到满足模式的域名进行后续分析。

普通的正则过程会比较慢，尤其正则越复杂，性能下降会很严重。当前load数据有50亿到100亿之间，一个复杂正则可能需要耗费几十分钟才能跑完。

想到一个优化方法
* load数据的过程中，预先计算每个域名的组成，【0-9a-z._-】分别对应到一个bit，一个int64的整数足够
* 查询时，把正则中固定字符串提取出来，算固定字符串的组成，正则匹配之前，先看要检查的域名的对应的组成int64的位与是否能cover正则表达式的组成int64

域名的组成很少会把所有的字符都用到，对于特定的模式，能有overlap的域名只是一小部分，而上述的位与检查会非常迅速，所以可以大大提高匹配过程的效率。粗略估算，提升在5倍左右，对于正则表达式，如果能提供的固定字符串越多，匹配越快，如果完全不包含固定字符串，那就退化到和之前一样了。

问题来了，python里面 re.compile(pattern, 128）会把一个pattern对应的解析后结果展示出来，re2没有这个接口，我们得自己添加。

re2/re2.h 给 RE2 类添加
```C++
 ... ...
+class Regexp {
+    public:
+        string Dump();
+};

class RE2{
    ... ...
+    string RegexpDump() const { return Regexp()->Dump(); }
    ... ...
};
```

Dump方法在re2/regex.h是有的，不过没有给出实现。在re2/testing/下有类似的dump实现，不过dump出来的字符串是一坨不好看，我们修改为如下

re2/regexp.cc，添加到文件最后
```C++

static const char* kOpcodeNames[] = {
  "bad ",
  "no ",
  "emp ",
  "CHR ",
  "STR ",
  "PATTERN ",
  "alt ",
  "0-ANY ",
  "1-ANY ",
  "0-1 ",
  "REPEAT ",
  "SUB",
  "dot ",
  "byte ",
  "bol ",
  "eol ",
  "wb ",   // kRegexpWordBoundary
  "nwb ",  // kRegexpNoWordBoundary
  "BOT ",
  "EOT ",
  "IN ",
  "match ",
};


static void DumpRegexpAppending(Regexp* re, string* s, int level) {
  if (re->op() < 0 || re->op() >= arraysize(kOpcodeNames)) {
    StringAppendF(s, "op%d", re->op());
  } else {
    switch (re->op()) {
      default:
        break;
      case kRegexpStar:
      case kRegexpPlus:
      case kRegexpQuest:
      case kRegexpRepeat:
        if (re->parse_flags() & Regexp::NonGreedy)
          s->append("n");
        break;
    }
    if(! s->empty()){
        s->append("\n");
    }
    for(int i=0; i<level; ++i){
        s->append("  ");
    }

    s->append(kOpcodeNames[re->op()]);
    if (re->op() == kRegexpLiteral && (re->parse_flags() & Regexp::FoldCase)) {
      Rune r = re->rune();
      if ('a' <= r && r <= 'z')
        s->append("fold");
    }
    if (re->op() == kRegexpLiteralString && (re->parse_flags() & Regexp::FoldCase)) {
      for (int i = 0; i < re->nrunes(); i++) {
        Rune r = re->runes()[i];
        if ('a' <= r && r <= 'z') {
          s->append("fold");
          break;
        }
      }
    }
  }
  s->append("{");
  switch (re->op()) {
    default:
      break;
    case kRegexpEndText:
      if (!(re->parse_flags() & Regexp::WasDollar)) {
        s->append("\\z");
      }
      break;
    case kRegexpLiteral: {
      Rune r = re->rune();
      char buf[UTFmax+1];
      buf[runetochar(buf, &r)] = 0;
      s->append(buf);
      break;
    }
    case kRegexpLiteralString:
      for (int i = 0; i < re->nrunes(); i++) {
        Rune r = re->runes()[i];
        char buf[UTFmax+1];
        buf[runetochar(buf, &r)] = 0;
        s->append(buf);
      }
      break;
    case kRegexpConcat:
    case kRegexpAlternate:
      for (int i = 0; i < re->nsub(); i++){
          DumpRegexpAppending(re->sub()[i], s, level+1);
      }
      break;
    case kRegexpStar:
    case kRegexpPlus:
    case kRegexpQuest:
      DumpRegexpAppending(re->sub()[0], s, level+1);
      break;
    case kRegexpCapture:
      if (re->name()) {
        s->append(*re->name());
        s->append(":");
      }
      DumpRegexpAppending(re->sub()[0], s, level+1);
      break;
    case kRegexpRepeat:
      s->append(StringPrintf("%d,%d ", re->min(), re->max()));
      DumpRegexpAppending(re->sub()[0], s, level+1);
      break;
    case kRegexpCharClass: {
      string sep;
      for (CharClass::iterator it = re->cc()->begin();
           it != re->cc()->end(); ++it) {
        RuneRange rr = *it;
        s->append(sep);
        if (rr.lo == rr.hi)
          s->append(StringPrintf("%#x", rr.lo));
        else
          s->append(StringPrintf("%#x-%#x", rr.lo, rr.hi));
        sep = " ";
      }
      break;
    }
  }
  if((*s)[s->size()-1] == '}'){
      s->append("\n");
      for(int i=0; i<level; ++i){
          s->append("  ");
      }
  }
  s->append("}");
}

string Regexp::Dump() {
  string s;
  DumpRegexpAppending(this, &s, 0);
  return s;
}
```

这样做个小程序

main.cc
```C++
int main(int argc, char* argv[])
{
    for(int i=1; i<argc; ++i){
        auto line = std::string(argv[i]);
        re2::RE2 p(line);
        if(p.ok()){
            std::cout << ">>> " << line << std::endl;
            std::string pcc = p.RegexpDump();
            std::cout << pcc << std::endl;
        }else{
            std::cout << ">>> " << line << " Parse error." << std::endl;
        }
    }
    return 0;
}
```

```sh
[xuyang@dev:/secret/path/]$ ./repattern.exe '^hello[0-9]{1,3}\.[abc_.-]{5,6}world$'
>>> ^hello[0-9]{1,3}\.[abc_.-]{5,6}world$
PATTERN {
  BOT {}
  STR {hello}
  REPEAT {1,3
    IN {0x30-0x39}
  }
  CHR {.}
  REPEAT {5,6
    IN {0x2d-0x2e 0x5f 0x61-0x63}
  }
  STR {world}
  EOT {}
}
```

上述STR／CHR的部分就是我们关心的“一个正则中固定字符串”的部分，这里是“hello.”，将其映射到一个uint64 for pattern。
正则匹配之前，先通过一个位与运算判断上面的uint64 for pattern是否被包含与uint64 for string, 不被包含的就说明原始字符串肯定不会含有hello.对应的所有字符，也就肯定不可能被正则匹配过程命中，直接忽略掉匹配过程，加速整体匹配性能。




