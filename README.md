# 805yinyou

805音遊, A rythm game that can be played on a 8051 MCU.

# Roadmap:

- [ ] Finding 3 music to implement
- [ ] Implement the mapping
- [ ] Implement scoring
- [ ] Implement win condition
- [ ] Memory for high score
- [ ] Interface for changing music

## Current To do

- [ ] Mapping the song on the 8x8 LED
- [ ] Implementing Scoring

## Finished Task

- [x] Finished writig Assembly code for Bad Apple songs

# Contributing Rules (貢獻規則)

> [!IMPORTANT]
> Make sure to use the asmfmt.py on your a51 files before pushing to git.\
> 確保在推送到 git 之前在 a51 檔案上使用 asmfmt.py。

## How to use asmfmt.py (如何使用asmfmt.py)

At the directory of the asmfmt.py file, open a terminal or command prompt and write following command.\
在 asmfmt.py 檔案的目錄中，開啟終端機或命令提示字元並寫入以下命令。

```bash
python asmfmt.py -f filename.a51
```

Change filename.a51 into your a51 files.\
將 filename.a51 變更為您的 a51 檔案。

Or if you wanted to format all assembly files on a directory you can do this with the following command.\
或者，如果您想要格式化目錄中的所有組件文件，可以使用以下命令來執行此操作。

```bash
#If you are using linux
python asmfmt.py -d /path/to/directory

#If you are using windows
python asmfmt.py -d \path\to\directory
```

Note: Notice the difference of `\` and `/`.\
備註: 注意“\”和“/”的區別。
