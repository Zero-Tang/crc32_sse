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

#include <stdlib.h>
#include "crc32.h"

u8 stdcall check_sse42()
{
#if defined(_msvc) || defined(_icl)
	u32 info[4];
	__cpuid(info,1);
	return _bittest(&info[2],20);
#endif
}

#if defined(_icl)
u32 stdcall sse_crc32(void* buffer,size_t size,u32 prev)
{
	u8* buf=(u8*)buffer;
	u32 crc=prev;
	u32 i=0;
	for(;i<size;i++)
		crc=_mm_crc32_u8(crc,buf[i]);
	return crc;
}
#endif

u32 stdcall std_crc32(void* buffer,size_t size,u32 prev)
{
	u8* buf=(u8*)buffer;
	u32 crc=prev;
	u32 i=0;
	for(;i<size;i++)
	{
		u8 crc_index=(u8)(crc^buf[i]&0xff);
		crc=crc32c_table[crc_index]^(crc>>8);
	}
	return crc;
}