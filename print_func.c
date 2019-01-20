char* const memory = (char*)0xb8000;
unsigned temp_memory = 0;
/*
int hello_world() {
	const char* string = "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
  int i = 0;
	while(*string){
    memory[(i++)<<1] = *string++;
  }
  return;
}
*/

void scroll_page(int count_scroll){
  unsigned int symbol_counter = 80*25;
  unsigned int symbol_counter_without_row = symbol_counter-80*count_scroll;
  unsigned int under_symbol = (80*count_scroll)<<1;
  unsigned int symbol = 0;
  temp_memory -= ((count_scroll*80)<<1);
  for(; symbol < symbol_counter_without_row; ++symbol)
    memory[symbol << 1] = memory[(symbol << 1) + under_symbol];
  for(symbol = symbol_counter_without_row; symbol < symbol_counter; ++symbol)
    memory[symbol << 1] = ' ';
  return;
}

unsigned string_length(const char* string){
  const char* tmp = string;
  while(*tmp){
    *tmp++;
  }
  return tmp - string;
}

void space_counter(unsigned count){
  for(unsigned i=0; i < count; ++i){
    temp_memory+=(1<<1);
    memory[temp_memory] = ' ';
  }
  return;
}

void print(char* string){
  unsigned str_len=string_length(string);
  unsigned i=0;
  unsigned count_spacer=0;
  unsigned j=0;
  unsigned save_symbol=0;
  unsigned t=0;
  for(; i<str_len; ++i){
    if(string[i] == '\n'){
        save_symbol = i;
        count_spacer = 80 - (j%80);
        if(count_spacer)
          space_counter(count_spacer-t);
        else
          space_counter(80-t);
        j = 0;
        t = 0;
    }
    else if(string[i] == '\t'){
      save_symbol = i;
      count_spacer = 82 - (j%82) - t;
      if(count_spacer)
        space_counter(count_spacer);
      else
        space_counter(82-t);
      j = 0;
      t = 2;
    }
    else{
      memory[temp_memory] = string[i];
      temp_memory += (1<<1);
      ++j;
    }
  }
  if(save_symbol){
    save_symbol = str_len-save_symbol - 1;
    count_spacer = 80 - ((save_symbol)%80);
    space_counter(count_spacer-t);
  }
  else{
    //count_spacer = 80 - ((str_len-1)%80);
    space_counter(80-str_len);
  }
  return;
}

void reverse(char* str, int length){
	unsigned start = 0;
	unsigned end = length - 1;
	while (start < end){
		char tmp = str[start];
		str[start++] = str[end];
		str[end--] = tmp;
	}
  return;
}

void write(char* storage){
  for(;*storage;*storage++){
    memory[temp_memory] = *storage;
    temp_memory+=(1<<1);
  }
  return;
}

void itoa (int number,const unsigned base){
	unsigned char i = 0;
	unsigned char isNegative = 0;
  char storage[1024] = {0};
	if (!number){
		storage[i++] = '0';
		storage[i] = '\0';
    write(storage);
    return;
	}
	if (number < 0 && base == 10){
		isNegative = 1;
		number = -number;
	}
	while (number){
		unsigned char digit = number % base;
		storage[i++] = digit + '0';
		number /= base;
	}
  if (isNegative){
		storage[i++] = '-';
	}
	storage[i] = '\0';
	reverse(storage, i);
  write(storage);
  return;
}


void PANIC_FUNC(const char* err_msg, const char* filename, int line){
temp_memory=0;
print("file: ");
print(filename);
print("error: ");
print(err_msg);
print("line: ");
itoa(line,10);
while(1);
}

int main(){
  temp_memory = 0;
  print("\nal\tlax\n");
  //scroll_page(1);
  print("na nebe\tsa\tx");
  print("prav\nit");
  //scroll_page(1);
  print("vse\nmi nami");
  print("ke\tkaa\nchebure\nkaa");
  print("rabotaet!");
  itoa(598,10);
  //PANIC_FUNC("test panic",__FILE__,__LINE__);
  return 0;
}
