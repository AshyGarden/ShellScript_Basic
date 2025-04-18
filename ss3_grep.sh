
#grep - Linux & Unixで最も多く使われる特定の文字列を探すコマンド

#基本的な使い方
#gep [オプション] パターン [ファイル]

# grepの様々なオプション - notionに詳細を整理

#1. 情報関連オプション
#--help  - 옵션확인
grep --help

#-V(version) - grep コマンド バージョン 確認
grep -V

# パターン文法に関連オプション
#ex -E(--extended-regexp) - 前に検索した単語一つが一致したり
#一致しなくても検索できる拡張正規表現式
grep 'q[[lower]]*\??' shellscript.txt
#出力: Do you have any questions? or Do you need any help?

grep -E 'q[[lower]]*\??'  shellscript.txt
#出力(2列) Do you have any questions? or Do you need any help?
#If you have any questions,Please send a mail to the email below. 등

#ex -F(--fixed-strings) -  パターンを細く線を減らす場合に使用
grep -F '# Date' # 後ろの ' は除いて見なければならない

#ex -G(--basic-regexp)
grep 'q[[lower]]*\??' shellscript.txt
#出力: Do you have any questions? or Do you need any help?

grep -G 'q[[lower]]*\??' shellscript.txt
#出力: Do you have any questions? or Do you need any help?(非常にオプションなしで正規表現式を使用する場合、出力値は同じ)

#ex -P(--basic-regexp) - 正規式を利用したパターン検索時に使用
grep "(?<=\[')[^,]*" /etc/shell/script.conf
#出力: (なし)

grep -P "(?<=\[')[^,]*" /etc/shell/script.conf
#出力: "['-v','-R','500']"
#Where '[' indicates zero or one occurrences, '{' indicates zero or multiple


# マッチング制御に関連オプション
#ex -e(--regexp) - 複数のパターンを検索する際に使用、OR条件で検索(通常ERROR、WARNINGなどを探すのに使用)
grep -e 'option'--regexp 'file' shellscript.txt
# 出力(2列) option~ : ~options
#           file: ~

#ex -f(--file) -  よく使うパターンを保存して再利用する時に使用
echo 'option' > op
echo 'file' > fl
grep -f op --file=fl shellscript.txt
# 出力(2列) option~ : ~options
#           file: ~

#ex -i(--ignore-case) - 大文字と小文字を区別せずにすべての文字列を検索
grep -i 'option' shellscript.txt
# option~ : ~options

# 出力制御に関連オプション - パターンと一致する単語の数、パターンが含まれたファイル名を探す場合に有用
#ex -c(--count)
grep -c 'option' shellscript.txt
#出力: 2

#ex --color - 一致する文字列の出力色を調整(GREP_COLORと同じように使用)
GREP_COLOR="1;32" grep --color 'option' shellscript.txt 
#黄緑色で出力

#ex --L --files-with-matches - 検索したいパターンが含まれたファイルリストだけを照会する時に使用するオプション
grep -L 'shell' ./*
#./shellscript.txt 等

#  出力ライン制御に関連オプション
#ex -b(--byte-offset) -  検索パターンが含まれたラインのバイト数をラインの一番前の部分に一緒に見せてくれる。
grep -b 'option' shellscript.txt
#出力: 126: ~ option ~

#ex -H(--with-filename) - 特定のファイルを対象に検索する場合にもファイル名を一緒に見たい場合に使用
grep -H 'option' shellscript.txt
#出力: shellscript.txt: ~ option ~
 
#ex -h(--no-filename) - ファイル対象検索時にファイル名を非表示にしたい場合
grep -h 'option' shellscript.txt
#出力:  ~ option ~ (ファイル名が前に出力されない)

#ex -Z(--null) -  ファイルリストを検索する際、複数の行で検索されたファイルリストのニューラインを削除し、1行で出力できるようにする
grep -Z  -L 'option' ./*
#出力: ./shellscript.txt./test.txt[~]$

#-----------------------------------------------------------

#Contextライン制御関連オプション
#ex-A(--after-context) - 検索されたパターンが含まれたラインを基準に設定したライン数だけライン '下' を表示する。
grep -A 2 'option' shellscript.txt
# ~ option ~
#
# (2列目の下が追加的に見える)

#ex-B(--after-context) - 検索されたパターンが含まれたラインを基準に設定したライン数だけライン '上' を表示する。
grep -B 2 'option' shellscript.txt
# (2列上が追加的に見える)
#
# ~ option ~

#ex-C(--after-context) - 検索されたパターンが含まれたラインを基準に設定したライン数だけライン '上+下' を表示する。
grep -C 2 'option' shellscript.txt
# (2列上が追加的に見える)
# ~
# ~ option ~
# ~
# (2列目の下も追加的に見える)

#ex - group seperator - 検索された文字列が他の行で検索される場合、group seperatorと一緒に設定したグループ部分記号を検索されたパターンライン上に表示します。
grep -A 1 --group-seperator='==========' '# [[:option:]]' shellscript.txt
# ~ (1列上で見せる)
# ==========
# ~ option ~
# ==========
# ~ (1列下に見せる)

#ex -no-group seperator - グループ部分の記号を区別せずに出力
grep -A 1 --no-group-seperator='==========' '# [[:option:]]' shellscript.txt
# ~ (1列上で見せる)
# ~ option ~
# ~ (1列下に見せる)

# ファイルとディレクトリ オプション
#ex-a (--text) - バイナリファイルの場合に利用可能、そのパターンがバイナリファイル内にパターンがあるか検索
grep -a '^option' shellscript.txt
# ~ option ~

#ex - binary - files - Typeオプションを利用してバイナリファイルを検索する時に使用
grep --binary-files=text '^option' shellscript.txt
# ~ option ~

#ex - DACTION(--directories) - デバイスを検索対象から除外させる場合
sudogrep -Dread 'option' #読み取りアクセス - 権限エラーが発生可能
sudogrep -D skip 'option' #デバイス検索スキップ - エラーX

#ex-d ACTION(--devices) - ディレクトリを検索対象から含めたり除外させたりする場合
sudogrep - dread 'option' #現在およびすべてのファイルディレクトリでoptionという単語を検索
sudogrep-d skip 'option'  #現在のディレクトリを'除く'すべてのディレクトリでoptionという単語を検索

#ex-r(--recursive) - 下位ディレクトリ内のファイルまですべて検索したい場合
grep -r --include=expression* 'option' ./*
# ./shellscript.txt./test.txt[~]$

# その他オプション
#ex -line-buffered - 大量のログ、サイズが非常に大きいファイルを検索する時、検索後に出力結果を調整
#使用時にメモリングが無理になることがあるので注意して使用
sudo grep --line-buffered -i -r 'option' /bin/log/*
# ~~

#ex -U (--binary) - 一般テキストファイルをバイナリファイルとして扱い、キャリッジパターン、ラインフィードなどの文字を削除して検索を行う
grep -U 'option' shellscript.txt
# ~ option ~

#ex - Z (--null-data) - ファイルの内容をそのまま表示するオプション
grep -z 'option' ./*.txt
# ~全体ファイルの内容~