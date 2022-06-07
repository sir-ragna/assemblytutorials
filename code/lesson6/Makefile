
all:    build

build:
	nasm -f elf64 helloworld-inc.asm -o helloworld-inc.o
	ld -m elf_x86_64 helloworld-inc.o -o helloworld-inc

clean:
	rm -v helloworld-inc.o helloworld-inc