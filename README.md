# 805yinyou

805音遊, A rythm game that can be played on a 8051 MCU.

# Roadmap:

- [ ] Finding 3 music to implement
- [ ] Memory for high score
- [ ] Interface for changing music

## Current To do
Currently not doing anything

## Finished Task
- [x] Finished writing Assembly code for Bad Apple song
- [x] Finished writing the beatmap for Bad Apple
- [x] Finished writing the scoring logic
- [x] Finished writing the key input
- [x] Finished writing ending of the game

# About This Project

This project is finished in 16 June 2024. Right now it's able to sing the song (with a slight delay) and receive the key input to judge. But currently only one song is available. The Assembly is broken into 3 part, The bass and key input, The beatmap and The melody and scoring. You can see the codes in the Bad Apple Project Folder. I use KEIL MICROVISION 5 to compile these aseembly codes into HEX file and using ISP ICP 8051 to burn it into my microcontroller.

此專案於2024年6月16日完成。但目前只有一首歌曲可用。彙編分為 3 部分：低音和琴鍵輸入、節拍圖以及旋律和配樂。您可以在 Bad Apple Project資料夾中看到程式碼。我使用 KEIL MICROVISION 5 將這些彙編程式碼編譯為 HEX 文件，並使用 ISP ICP 8051 將其燒錄到我的微控制器中。

# Afterwords
This project is made for fun, I always wanted to try to see the potential of these 8051 microcontroller and it seems like it could act as a platform to create game, but ofcourse why would anyone play a game on a microcontroller? I don't know, but other than that it was a good exercise for my logic too, as it actually make my brain hurts for a long time thinking how to efficiently use those 8 registers and accumulator. But in the end, I made it, and I am glad that I did not give up halfway. I hope this project might help someone who is also trying to do some projects on a 8051 microcontroller. Oh and if the chinese is kinda weird, its because I used google translate cause I have a skill issue with that language, and yeah that's all! 

這個專案是為了好玩而製作的，我一直想嘗試看看這些 8051 微控制器的潛力，它似乎可以作為創建遊戲的平台，但當然為什麼有人會在微控制器上玩遊戲呢？我不知道，但除此之外，這對我的邏輯也是一個很好的鍛煉，因為它實際上讓我的大腦長時間受傷，思考如何有效地使用這 8 個寄存器和累加器。但最終我做到了，我很慶幸自己沒有半途而廢。我希望這個專案可以幫助那些也嘗試在 8051 微控制器上做一些專案的人。是的，就是這樣！

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
