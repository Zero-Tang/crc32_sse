/*
  CRC32_SSE - SSE4.2 Accelerated CRC32 Program
  Powered by zero.tangptr@gmail.com

  This project is a simple demo to perform CRC32
  hashing using SSE4.2 technology for acceleration.

  This software is provided "as is", without warranty
  of any kind, express or implied, including but not
  limited to the warranties of merchantability, fitness 
  for a particular purpose and non-infringement. In no
  event should the authors or copyright holders be
  liable for any claim, damages or other liability,
  whether in an action of contract, tort or otherwise,
  arising from, out of or in connection with the
  software or the use or other dealings in the software.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "crc32.h"

u32 std_crc32(void* buffer,size_t size,u32 prev)
{
	u8* buf=(u8*)buffer;
	u32 crc=prev;
	u32 i=0;
	for(;i<size;i++)
	{
		u8 crc_index=(u8)(crc^buf[i]&0xff);
		crc=crc_table[crc_index]^(crc>>8);
	}
	crc^=0xffffffff;
	return crc;
}

void main()
{
	char string_buf[1000]="Example input";
	printf("Type \"exit\" to leave program!\n");
	printf("Example CRC32 hash of string \"Example input\"\n");
	while(strnicmp(string_buf,"exit",_countof(string_buf)))
	{
		size_t len=strnlen_s(string_buf,1000);
		u32 std=std_crc32(string_buf,len,0xffffffff);
		u32 sse=sse_crc32(string_buf,len,0xffffffff);
		printf("Result by Non-Optimized: 0x%X\n",std);
		printf("Result by SSE-Optimized: 0x%X\n",sse);
		printf("Input string to hash: ");
		scanf_s("%s",string_buf,_countof(string_buf));
	}
	system("pause");
}