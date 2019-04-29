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

.code

sse_crc32 proc

	xchg rcx,rdx
	xchg rdx,rsi
	cld
loop_crc:
	lodsb
	crc32 r8d,al
	loop loop_crc
	mov rsi,rdx
	mov eax,r8d
	ret

sse_crc32 endp

end