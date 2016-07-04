CWD=`pwd`
DIR=`mktemp -d`
echo $DIR
cp cbpy $DIR
cd $DIR
chmod +x cbpy
git init
cat <<EOF > fun.py
import sys
print("FUN FUN FUN")
sys.exit(244)
EOF
git add fun.py
git commit -m 'fun.py init'
echo "# modification" >> fun.py
./cbpy fun.py
