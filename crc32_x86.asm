; CRC32_SSE - SSE4.2 Accelerated CRC32 Program
; Powered by zero.tangptr@gmail.com

; This project is a simple demo to perform CRC32
; hashing using SSE4.2 technology for acceleration.

; This software is provided "as is", without warranty
; of any kind, express or implied, including but not
; limited to the warranties of merchantability, fitness 
; for a particular purpose and non-infringement. In no
; event should the authors or copyright holders be
; liable for any claim, damages or other liability,
; whether in an action of contract, tort or otherwise,
; arising from, out of or in connection with the
; software or the use or other dealings in the software.

.686
.model flat,stdcall
.code

sse_crc32 proc buffer:dword,len:dword,prev:dword

	push esi
	mov edx,dword ptr[prev]
	mov esi,dword ptr[buffer]
	mov ecx,dword ptr[len]
	cld
loop_crc:
	lodsb
	crc32 edx,al
	loop loop_crc
	pop esi
	mov eax,edx
	ret

sse_crc32 endp

end