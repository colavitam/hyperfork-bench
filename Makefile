IMAGES=basic_fork
IMAGES_EXT4=$(patsubst %,out/%.ext4,$(IMAGES))

SIGNALS=fork reset done
SIGNALS_EXEC=$(patsubst %,out/%,$(SIGNALS))
SIGNALS_OBJ=$(patsubst %,build/%.o,$(SIGNALS))
SIGNALS_REQ_OBJ=build/comm.o

CFLAGS=-O2
LDFLAGS=-static

all: $(SIGNALS_EXEC) $(IMAGES_EXT4)

$(SIGNALS_OBJ) $(SIGNALS_REQ_OBJ): build/%.o: signals/%.c signals/*.h
	mkdir -p out build
	$(CC) $(CFLAGS) -c $< -o $@

$(SIGNALS_EXEC): out/%: build/%.o $(SIGNALS_REQ_OBJ)
	mkdir -p out build
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

$(IMAGES_EXT4): out/%.ext4:
	mkdir -p out build
	./build_docker.sh $*

clean:
	rm -rf build out

.PHONY: clean $(IMAGES_EXT4)
