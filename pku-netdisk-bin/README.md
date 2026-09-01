# pku-netdisk-bin

北京大学“北大网盘 2.0”Linux 客户端的本地 Arch Linux 包。

上游程序是上海爱数 AnyShare `7.0.6-3-281` 的北大 OEM 版本，服务器预配置为 `disk.pku.edu.cn`。

程序安装到纯 ASCII 路径 `/opt/pkudisk`，命令入口为 `/usr/bin/anyshare`。

## 获取上游安装包

上游 `.deb` 需要登录北大网盘并使用有效下载令牌，不能把下载地址中的令牌提交到 Git。请在浏览器中访问：

```text
https://disk.pku.edu.cn/
```

登录后下载 Linux 客户端，并严格保存为：

```text
目录：当前项目目录（即包含 PKGBUILD 的目录）
文件名：pku-netdisk_7.0.6.3-281_amd64.deb
相对路径：./pku-netdisk_7.0.6.3-281_amd64.deb
```

该文件已被 `.gitignore` 忽略。不要把下载令牌、`.deb`、`src/`、`pkg/` 或生成的 `*.pkg.tar.*` 提交到仓库。

## 构建并安装

推荐使用包装脚本。它会在构建前检查 `.deb` 是否存在以及 SHA-256 是否匹配：

```bash
./build.sh -si
```

只构建、不安装：

```bash
./build.sh -f
```

直接运行 `makepkg` 也可以；缺少 `.deb` 时，`PKGBUILD` 会提示下载地址、目标路径和文件名。

生成的包位于当前目录，文件名类似：

```text
pku-netdisk-bin-7.0.6.3.281-4-x86_64.pkg.tar.zst
```

也可以单独安装已构建的包：

```bash
pkexec pacman -U ./pku-netdisk-bin-7.0.6.3.281-4-x86_64.pkg.tar.zst
```

卸载：

```bash
pkexec pacman -Rns pku-netdisk-bin
```

## 启动

应用菜单中搜索“北大网盘 2.0”，或者执行：

```bash
anyshare
```

这个版本内置 Electron 11 / Chromium 87，Wayland 下通常通过 XWayland 运行。遇到 GPU 渲染问题时可测试：

```bash
anyshare --disable-gpu
```

当前 Arch Linux 的内核与 glibc 会触发旧版 Chromium seccomp 过滤器的 `SIGSYS` 崩溃。启动脚本仅自动添加 `--disable-seccomp-filter-sandbox`，保留其余 Chromium 沙箱层，不使用完全关闭沙箱的 `--no-sandbox`。
