
all:    build

build:
	nasm -f elf64 helloworld-len.asm -o helloworld-len.o
	ld -m elf_x86_64 helloworld-len.o -o helloworld-len

clean:
	rm -v helloworld-len.o helloworld-len