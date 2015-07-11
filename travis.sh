git clone https://github.com/LuaDist/lua.git --quiet
cd lua/
git checkout -qf $LUA_VERSION
cmake .
make
sudo make install
cd ../
make