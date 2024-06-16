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

# How to play

To play, you will need 3 8051 microcontroller, and 2 jumper cable. Lets assume the microconttrollers are named as A,B, and C. So you take the Bass.a51 hex file burn it into A, Beatmap.a51 hex file burn it into B and MelodyScoreKey.a51 hex file into C. And then put the Jumper cable from A's P3.1(TX) to B's P3.0 (RX) and  put the second Jumper cable from B's P3.1(TX) to P3.0(RX). And you are good to go! Press the any key on the 4x4 Key at Microcontroller A, and the game will start! Have Fun!

要遊玩這個遊戲，你需要 3 個 8051 微控制器和 2 條跳線。我們假設微控制器命名為甲、乙和丙。首先，將 Bass.a51 的 hex 文件燒錄到甲，將 Beatmap.a51 的 hex 文件燒錄到乙，並將 MelodyScoreKey.a51 的 hex 文件燒錄到丙。接下來，用跳線將甲的 P3.1 (TX) 連接到乙的 P3.0 (RX)，再用另一條跳線將乙的 P3.1 (TX) 連接到丙的 P3.0 (RX)。一切就緒後，按下微控制器甲上 4x4 鍵盤的任意鍵，遊戲將開始！祝你玩得開心！

Video Demonstration (影片示範): https://youtu.be/faz8mmd0WDA?feature=shared

# Afterwords
This project is made for fun, I always wanted to try to see the potential of these 8051 microcontroller and it seems like it could act as a platform to create game, but ofcourse why would anyone play a game on a microcontroller? I don't know, but other than that it was a good exercise for my logic too, as it actually make my brain hurts for a long time thinking how to efficiently use those 8 registers and accumulator. But in the end, I made it, and I am glad that I did not give up halfway. I hope this project might help someone who is also trying to do some projects on a 8051 microcontroller. Oh and if the chinese is kinda weird, its because I used google translate cause I have a skill issue with that language, and yeah that's all! 

這個專案是為了好玩而製作的，我一直想看看這些 8051 微控制器的潛力，似乎它可以作為創建遊戲的平台。但是，當然了，為什麼會有人在微控制器上玩遊戲呢？我不知道。不過，除此之外，這對於我的邏輯也是一個很好的練習，因為思考如何有效地使用這些 8 個寄存器和累加器確實讓我頭疼了很久。但最終，我做到了，而且我很高興我沒有在中途放棄。我希望這個專案能夠幫助那些也在嘗試使用 8051 微控制器做一些專案的人。哦，如果中文有點奇怪，那是因為我用了谷歌翻譯，因為我對這門語言不太熟練，就是這樣！

# Contributing Rules (貢獻規則)

> [!IMPORTANT]
> Make sure to use the asmfmt.py on your a51 files before pushing to git to maintain the desired formatting.\
> 請確保在將您的 a51 文件推送到 Git 之前使用 asmfmt.py 來保持所需的格式。

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
