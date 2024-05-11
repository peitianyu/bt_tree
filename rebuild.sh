# 如输入clean, 则删除build文件夹
if [ $1 = "clean" ]; then
    rm -rf build
fi

# 如果没有build文件夹, 新建一个
if [ ! -d "build" ]; then
    mkdir build
fi

cd build && cmake  -G Ninja .. && ninja

./all_tests

cd ..