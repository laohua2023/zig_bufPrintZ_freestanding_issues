
const std = @import("std");

const UART_REG_TXFIFO  = @intToPtr(*volatile u32, 0x10000000);
pub fn putc(ch:u8) void
{
	while (UART_REG_TXFIFO.* < 0) {}
	UART_REG_TXFIFO.* = ch;
}


export fn main() void {
	putc('A');
	putc('A');
	putc('A');

	var a:usize = 1;
	var b:usize = 666;
	var x:usize = @ptrToInt(&b) + a;


	var tmpBuff:[100:0]u8 = undefined;
	var tmpstr = std.fmt.bufPrintZ(&tmpBuff, "hello {} world!", .{x} ) catch "999";  // <=  HANG HERE!
	for(tmpstr) |c| {
		putc(c);
	}
	putc('B');
	putc('B');
	putc('B');


	while(true) {}
}

pub fn panic(msg: []const u8, error_return_trace: ?*std.builtin.StackTrace, ret_addr: ?usize) noreturn {
	putc('P');
	_ = msg;
	_ = error_return_trace;
	_ = ret_addr;
	while (true) {
		@breakpoint();
	}
}
