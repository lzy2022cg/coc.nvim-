# coc.nvim-

更新ubuntu apt-get update && apt-get upgrade

先安装clash for linux

根据搜索结果¹²，你需要先安装**neovim**和**vim-plug**，然后通过**vim-plug**安装**coc.nvim**插件，最后配置相应的语言服务器。

具体步骤如下：

- 安装neovim：apt install neovim

- 安装vim-plug：在终端运行以下命令，下载plug.vim文件，并把它放到“autoload”目录。
```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

- 安装coc.nvim：在终端运行以下命令，创建并编辑init.vim文件，添加coc.nvim插件的信息，然后保存退出。
```bash
mkdir -p ~/.config/nvim; cd ~/.config/nvim
vi init.vim # 输入以下内容，注意Linux与Windows的换行符问题，如果出现Error，请单行复制
call plug#begin('~/.vim/plugged')
" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
```
- 在neovim中运行以下命令，安装coc.nvim插件。
```vim
:PlugInstall
```

安装nodejs：Node.js版本低于14.14.0，这可能会导致一些问题或不兼容，所以我们用以下命令来实现
wget https://nodejs.org/dist/v16.13.1/node-v16.13.1-linux-x64.tar.xz
tar -xJf ./node-v16.13.1-linux-x64.tar.xz -C ~/
mv node-v16.13.1-linux-x64/ node16
sudo vi /etc/profile # 将文件尾部添加这两行
export NODE_HOME=$HOME/node16
export PATH=$NODE_HOME:$NODE_HOME/bin:$PATH
source /etc/profile # 刷新配置

- 配置coc.nvim：在终端运行以下命令，编辑init.vim文件，添加coc.nvim的相关配置，然后保存退出。具体配置可以参考[coc.nvim的官方文档](https://github.com/neoclide/coc.nvim#example-vim-configuration)。
```bash
nvim ~/.config/nvim/init.vim # 添加以下配置
" 剩下的配置在：https://github.com/neoclide/coc.nvim#example-vim-configuration
" 复制到此处
```

- 安装相应的语言服务器：根据你需要使用的编程语言，安装对应的语言服务器。例如，如果你需要使用Typescript，你可以在终端运行以下命令，安装Typescript语言服务器。
```bash
npm install typescript
如果你想要安装C/C++语言服务器，你可以在终端运行以下命令，安装**clangd**¹²，这是一个支持C/C++/Objective-C的语言服务器。
```bash
sudo apt-get install clangd
```
安装完成后，你还需要在neovim中运行以下命令，安装**coc-clangd**²，这是一个基于coc.nvim的clangd扩展。
```vim
:CocInstall coc-clangd
```
这样你就可以使用coc.nvim和clangd来实现C/C++的自动补全功能了。😊
```
如果你需要使用其他语言，你可以参考[coc.nvim的官方文档](https://github.com/neoclide/coc.nvim#language-servers)中的列表，选择合适的语言服务器并安装。

这样你就完成了在WSL下安装vim的自动补全插件coc.nvim的过程。希望对你有帮助。😊
