# pulse-secure-local

Local Arch Linux package for Ivanti Secure Access Client.

## Fixes compared with the current AUR recipe

- Updates the client from 22.8R5 build 41063 to 22.8R6 build 44527.
- Replaces the dead UCSB RPM URL with a working public university mirror.
- Preserves vendor ELF binaries byte-for-byte with `!strip !debug`, because some VPN gateways validate the client binary hash.
- Packages the complete `/opt/pulsesecure` payload, including new R6 files and internal symlinks.
- Keeps the systemd unit in Arch's `/usr/lib/systemd/system` location.

## Build and install

`gtkmm3` and the legacy WebKitGTK 4.0 package are required dependencies, so build this package through an AUR helper:

```sh
paru -Bi .
websudo systemctl enable --now pulsesecure.service
```

This package also depends on the sibling `libjxl11-compat` package. It installs the genuine versioned libjxl 0.11 runtime libraries from Arch Linux's archived `libjxl 0.11.2-2` package and can coexist with the current `libjxl 0.12` package.

On systems with the `archlinuxcn` repository enabled, `webkit2gtk-imgpaste` provides the required `webkit2gtk` 4.0 ABI. Its dependencies are satisfied by AUR `libsoup` plus `libjxl11-compat`. This combination was verified with `ldd` against both `libwebkit2gtk-4.0.so.37` and `pulseUI`, with no unresolved libraries.

`webkit2gtk-4.1` remains installed independently but is not ABI-compatible with the `libwebkit2gtk-4.0.so.37` required by `pulseUI`.

Do not symlink `libjxl.so.0.12` to `libjxl.so.0.11`; those are different ABIs. The compatibility package installs the actual 0.11 implementation instead.
