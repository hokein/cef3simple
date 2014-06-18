## Requirement

CEF version 3.1650.1562

## Building steps on Linux

1. Build source code: `./build-linux.sh <your_cef3_path>`

2. Launch cef3simple: `./cef3simple`

**Notes**

Unlike windows platform, when you compile the cef application, 
you should keep the directory `libcef_dll_wrapper` and `libcef_dll_wrapper.a` in
the same place, otherwise you will get a `Malformed Archive` error message when
linking.

`libcef_dll_wrapper.a` is built on `<cef_dir>/out/Release/obj.target` or `
<cef_dir>/out/Debug/obj.target`.
