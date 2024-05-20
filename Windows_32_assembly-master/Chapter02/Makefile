SRCS=$(wildcard *.c)
OBJS=$(patsubst %.c,%.o,$(SRCS))

all:$(OBJS)
.c.o:
	gcc -c $< -o $@
