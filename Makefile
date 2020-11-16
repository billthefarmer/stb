# Makefile for Sussex booklet
#

all:	stb_book.pdf stb_booklet.pdf

stb.ps:	stb.abc
	abc2ps -o -f stb.abc -O =

stb_index_book.ps:	stb.ps index_book.awk
	gawk -f index_book.awk stb.ps > stb_index_book.ps

stb_index_booklet.ps:	stb.ps index_booklet.awk
	gawk -f index_booklet.awk stb.ps > stb_index_booklet.ps

stb_book.ps:	stb_index_book.ps
	psnup  -Pa5 -2 stb_index_book.ps > stb_book.ps

stb_booklet.ps:	stb_index_booklet.ps
	psbook stb_index_booklet.ps | psnup -Pa5 -2 > stb_booklet.ps

stb_booklet.pdf:	stb_booklet.ps
	ps2pdf -sPAPERSIZE#a4 stb_booklet.ps stb_booklet.pdf

stb_book.pdf:	stb_book.ps
	ps2pdf -sPAPERSIZE#a4 stb_book.ps stb_book.pdf

clean:
	rm *.ps
	rm *.pdf
