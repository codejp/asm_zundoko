CFLAGS = -Wall -Wextra
CFLAGS += -nostdinc -nostdlib -fno-builtin -c

zundoko.img: zundoko.o
	ld -o $@ $< -T boot.ld -Map zundoko.map

zundoko.o: zundoko.S

.S.o:
	gcc $(CFLAGS) -o $@ $<

run: zundoko.img
	qemu-system-i386 -fda zundoko.img

clean:
	rm -f *~ *.o *.bin *.dat *.img *.map a.out zundoko

.PHONY: clean run
