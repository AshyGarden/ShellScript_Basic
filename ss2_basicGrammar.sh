
#基本変数宣言-文字列出力
language="Korean"
#echo "I can speak $language"

#ディレクトリ作成
language2="Korean English Japanese"
#mkdir $language2

function print(){
	echo $1
}
# print "I can type ShellScript!"

language3="ShellScript"
function print2(){
	echo "I can type $language3"
}
# print2

#地域変数
regionVar = "regionVariable"
function learn() {
	local regions="Region Variables"
	echo "This is $regions"
}

function printR=(){
	echo "I can type $1"
}

learn
printR $regionVar
#printR $regions #作動しない

#予約変数および環境変数システムのために事前にシステムで使用している変数
#notionにまとめ（種類が多様）

#位置パラメータ - スクリプト実行時に一緒に来るパラメータ
echo "This is $0"
echo "Controlled by $1, $2"
echo "This ShellScript parameters ard $*"
echo "This ShellScript parameters ard $@"
echo "This parameter count is $#"

#$*, $@ 
# $*, $@ - 使用時文字を個別認識
# $*, $@ - for, ""と一緒に使用する場合、文字を個別認識ではなく一つの文字列として認識
#入力 -> "A B C" で入力
for params in $* #または $@
do
	echo "I am $lan"
done
#出力->"A B C"で入力時、パラメータをすべて個別に認識
#I am A
#I am B
#I am C 

for params in "$@" #または "$#"
do
	echo "I am $lan"
done
#出力 - I am A B C - 一つの文字列として認識

#--------------------------------------------------------------
#매개변수 확장
url = "www.shellscript.com/"

echo "http://$urllogin.html" #http://www..html
echo "http://${url}login.html" #http://www.shellscript.com/login.html

#변수 초기화 방법 - ${변수-문자열}등
#변수의 문자열 값을 변경하기 위한 매개변수 확장자
#notion에 정리

#조건문 if - 상세한 정리는 notion
# if [조건식]
# then
# 	수행문
# elif [조건식]
# then
# 	수행문
# else
# 	수행문
# fi

#switch-case 변수에 따라 분기를 해야하는 경우 사용
# case $command in
# 	start)
# 	echo "START"
# 	;;
# 	stop)
# 	"stop")
# 	echo "STOP"
# 	;;
# 	restart)
# 	echo "RESTART"
# 	;;
# 	help)
# 	echo "HELP"
# 	;;
# 	*)  
# 	echo "please input command"
# esac

#繰り返し文 for - 多数の値を利用して同じ作業を処理する場合、主に使用
#基本の使い方1 - pythonなどで使われる方式(主に使用)
for various in [範囲(リスト配列など)]
do
	反復文
done
#基本使用法2 - java、c++などで使用(あまり使わない)
for ((変数=初期値; 条件式; 増加値))
do
	反復文
done

#反復文 while
while [$変数1 演算子 $変数2]
do
	反復文
done

#-------------------------------------
#演算子
# 文字列演算子
# -z 文字列の長さが「0なら」参
# -n 文字列の長さが「0でなければ」参
if [-z $1]
then
	echo true
else
	echo false
fi

# 比較演算子 (-eq, -ne, -gt, -ge, -lt, -le, > ,>=)
# 整数比較演算子定理は、notion
var1 =10
var2 =15
if [$var1 -eq $var2]
then 
	echo ture
else
	echo false
fi

# 論理演算子 - 詳細整理は notion
# AND, OR
logic1 =10
logic2 =15
logic3 =20

if [$logic1 -lt $logic2 -a $logic2 -gt $logic3]
then 
	echo ture
else
	echo false
fi

#-------------------------------------
# ディレクトリ演算子 - 変数タイプがディレクトリである場合に使用可能
# 特定のディレクトリ内のファイルリストの中にディレクトリがあるかどうかをチェックするときに使用
if [ -d $HOME]
then 
	echo ture
else
	echo false
fi

#ファイル演算子 - ファイルの様々な属性をチェックする演算子
#ファイル権限チェック -r :read -w:write -x:execute -s:size
if [ -r $HOME] #[ -w $HOME] [ -x $HOME] [ -s $HOME]
then 
	echo ture
else
	echo false
fi
#ファイル所有権 チェック -0 -G
if [ -0 $HOME] #[ -G $HOME]
then 
	echo ture
else
	echo false
fi

# ファイル比較演算子 - 2 つの変数で定義されたファイルを比較する演算子
# -nt(最新ファイル) -ot(以前のファイル) ef(同一ファイル)
# どちらのファイルがより最近作成されたかなどを確認可能
if [ $FILE1 -nt $FILE2] #[ $FILE1 -ot $FILE2] [ $FILE1 -ef $FILE1] 
then 
	echo ture
else
	echo false
fi

