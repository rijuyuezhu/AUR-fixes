#!/usr/bin/env bash
set -euo pipefail

project_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
deb_name='pku-netdisk_7.0.6.3-281_amd64.deb'
deb_path="${project_dir}/${deb_name}"
expected_sha256='d90386c33065d8932380f6c530965c09bf57ea561833b6c75fe5101b698da26e'

if [[ ! -f "${deb_path}" ]]; then
  cat >&2 <<EOF
错误：缺少北大网盘上游安装包。

该 .deb 需要登录北大网盘并使用有效下载令牌，PKGBUILD 不会也不能
把令牌写入仓库后自动下载。请手动下载，并放到当前项目目录：

  下载入口：https://disk.pku.edu.cn/
  文件名：  ${deb_name}
  相对路径：./${deb_name}

保存后重新运行：

  ./build.sh -si

该文件已被 .gitignore 忽略，不会被 Git 跟踪。
EOF
  exit 2
fi

actual_sha256=$(sha256sum -- "${deb_path}" | awk '{print $1}')
if [[ "${actual_sha256}" != "${expected_sha256}" ]]; then
  cat >&2 <<EOF
错误：上游 .deb 的 SHA-256 不匹配，可能下载了错误版本或文件不完整。

  文件：./${deb_name}
  期望：${expected_sha256}
  实际：${actual_sha256}

请重新下载版本 7.0.6-3-281，并保存为 ${deb_name}。
EOF
  exit 3
fi

cd -- "${project_dir}"
exec makepkg "$@"
