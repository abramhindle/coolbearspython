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
echo "Marking a syntax error"
./cbpy -s # mark syntax error
git tag | tail -n 1 | fgrep syntax || (echo "Did not commit a failure"; exit)
cat <<EOF > fun.py
import sys
print("SUCCESS SUCCESS")
EOF
./cbpy fun.py
git tag | tail -n 1 | fgrep success || (echo "Did not commit a success"; exit)
echo "Press Ctrl-C right now to inspect the test directory on your own $DIR"
read
rm -rf $DIR
