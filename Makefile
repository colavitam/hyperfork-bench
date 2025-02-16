IMAGES=basic_fork basic_memtest java gcc
IMAGES_EXT4=$(patsubst %,out/%.ext4,$(IMAGES))

SIGNALS=fork reset done
SIGNALS_EXEC=$(patsubst %,out/%,$(SIGNALS))
SIGNALS_OBJ=$(patsubst %,build/%.o,$(SIGNALS))
SIGNALS_REQ_OBJ=build/comm.o

CFLAGS=-O2
LDFLAGS=-static

all: $(SIGNALS_EXEC) $(IMAGES_EXT4)

SIGNALS_DEP := out/memtest

out/memtest: images/basic_memtest/memtest.c
	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)

$(SIGNALS_OBJ) $(SIGNALS_REQ_OBJ): build/%.o: signals/%.c signals/*.h
	mkdir -p out build
	$(CC) $(CFLAGS) -c $< -o $@

$(SIGNALS_EXEC): out/%: build/%.o $(SIGNALS_REQ_OBJ)
	mkdir -p out build
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

$(IMAGES_EXT4): out/%.ext4: $(SIGNALS_EXEC) $(SIGNALS_DEP)
	mkdir -p out build
	./build_docker.sh $*

clean:
	rm -rf build out

.PHONY: clean $(IMAGES_EXT4)
