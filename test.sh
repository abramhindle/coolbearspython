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
# This is supposed to not be successful
./cbpy fun.py
git tag | head -n 1 | fgrep failure || (echo "Did not commit a failure"; exit)
cat <<EOF > fun.py
import sys
print("SUCCESS SUCCESS")
EOF
./cbpy fun.py
git tag | tail -n 1 | fgrep succs || (echo "Did not commit a success"; exit)
