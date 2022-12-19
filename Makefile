.PHONY: clean image
SOURCE = testeModoVideo

all: image

# gerar arquivo floppy.img (um arquivo que corresponde ao disquete)
# o arquivo será preenchido com zero e terá o tamanho de um disquete
floppy.img:
	dd if=/dev/zero of=$@ bs=512 count=2880

# "compilar" o arquivo que contém os mnemônicos das instruções
$(SOURCE).o: $(SOURCE).S
	as $< -o $@

# recortar o binário do objeto e gerar um binário executável para o 
# processador 8086
$(SOURCE).bin: $(SOURCE).o
	objcopy -O binary --only-section=.text $(SOURCE).o $(SOURCE).bin

# copiar o arquivo binário executável para o arquivo floppy.img
image: $(SOURCE).bin floppy.img
	dd if=$(SOURCE).bin of=floppy.img count=1 conv=notrunc

# deletar arquivos 
clean:
	$(RM) -f floppy.img
	$(RM) -f $(SOURCE).o
	$(RM) -f $(SOURCE).bin
