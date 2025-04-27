```bash
export VSCODE_SERVER_PATCHELF_PATH=/share/apps/gnu/bin/patchelf
export VSCODE_SERVER_CUSTOM_GLIBC_PATH=/share/apps/gnu/lib:/usr/lib64
export VSCODE_SERVER_CUSTOM_GLIBC_LINKER=/share/apps/gnu/lib/ld-linux-x86-64.so.2

/share/apps/gnu/bin/patchelf --set-rpath "/share/apps/gnu/lib:/usr/lib64" node
/share/apps/gnu/bin/patchelf --set-interpreter /share/apps/gnu/lib/ld-linux-x86-64.so.2 node

/share/apps/gnu/bin/patchelf --set-rpath "/share/apps/gnu/lib:/usr/lib64" \
  --set-interpreter /share/apps/gnu/lib/ld-linux-x86-64.so.2 node
```

- `patchelf`: 0.18.0
- `glibc`: 2.41
