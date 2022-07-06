# loom
64bit hobby operating system

**DISCLAIMER**: This project will be put on hold as the idea I have is way too advanced for me at the moment.

## building
get a copy of [limine](https://github.com/limine-bootloader/limine/tree/v2.0-branch-binary),
after that compile an x86_64 cross compiler with the `mno-red-zone` patch, then

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
