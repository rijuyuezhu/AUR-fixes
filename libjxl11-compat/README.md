# libjxl11-compat

Cointerinstallable JPEG XL 0.11 runtime ABI libraries extracted from the official archived Arch Linux `libjxl 0.11.2-2` package.

This package intentionally installs only versioned `libjxl*.so.0.11*` files. It does not install unversioned linker names, headers, tools, or pkg-config files, so it can coexist with the current `libjxl` package.

It is needed by prebuilt WebKitGTK 4.0 packages that were linked before Arch Linux upgraded to libjxl 0.12. It is safer than symlinking `libjxl.so.0.12` to `libjxl.so.0.11`, because the actual 0.11 ABI implementation is installed.
