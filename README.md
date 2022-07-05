# loom
64bit hobby operating system

## building
get a copy of [limine](https://github.com/limine-bootloader/limine/tree/v2.0-branch-binary)

```console
 $ make
 $ make image
```

## running
because the kernel is 64bit, use this command to run loom

```console
 $ make run
```

## roadmap thing
- [x] long mode
- [x] graphics mode
- [ ] interrupts
- [ ] timer