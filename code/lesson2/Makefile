
all:    build

build:
	nasm -f elf64 helloworld.asm -o helloworld.o
	ld -m elf_x86_64 helloworld.o -o helloworld

clean:
	rm -v helloworld.o helloworld