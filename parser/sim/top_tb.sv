`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2025 19:32:55
// Design Name: 
// Module Name: top_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////




module top_tb;
    
    localparam inwidth = 64;

    reg clk;
    reg [inwidth-1:0] din;
    reg [7:0] tkeep;
    reg tvalid;
    reg tlast;
    wire [inwidth-1:0] out;
    wire [7:0] out_keep;
    wire outvalid;
    wire tlast_out; 
    
    
    wire [inwidth-1:0] out_wire_v;
    wire [7:0] out_keep_wire_v;
    wire outvalid_wire_v;
    wire tlast_out_wire_v;

    
    top test (
        .clk(clk),
        .din(din),
        .tkeep(tkeep),
        .tvalid(tvalid),
        .tlast(tlast),
        .out_ip(out),
        .out_keep_ip(out_keep),
        .outvalid_ip(outvalid),
        .tlast_out_ip(tlast_out), 
        .out_wire_v(out_wire_v),
        .out_keep_wire_v(out_keep_wire_v),
        .outvalid_wire_v(outvalid_wire_v),
        .tlast_out_wire_v(tlast_out_wire_v) 
    );
    
    
    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end
    
    initial begin
        din = 64'b0000000000000000000000000000000000000000000000000000000000000000;
        tkeep = 8'b00000000;
        tvalid = 0;
        tlast = 0;
        #40;
        
        
din = 64'b1111111111111111111111111111111111111111111111110000000000000000;
tkeep = 8'b11111111;
tvalid = 1;
tlast = 0;
#10;
din = 64'b000000000000000000000000000000000000000100000000000101100000000;
tkeep = 8'b11111111;
tvalid = 1;
tlast = 0;
#10;
din = 64'b0000000000000000000000000000000000000000000000000000000000000000;
tkeep = 8'b11111111;
tvalid = 1;
tlast = 0;
#10;
din = 64'b0000000000000000000000000000000000000000000000000000000000000000;
tkeep = 8'b11111111;
tvalid = 1;
tlast = 0;
#10;
din = 64'b0000000000000000000000000000000000000000000000000000000000000000;
tkeep = 8'b11111111;
tvalid = 1;
tlast = 0;
#10;
din = 64'b0000000000000000000000000000000000000000000000000000000000000000;
tkeep = 8'b11111111;
tvalid = 1;
tlast = 0;
#10;
din = 64'b0000000000000000000000000000000000000000000000000000000000000000;
tkeep = 8'b11111111;
tvalid = 1;
tlast = 0;
#10;
din = 64'b0000000000000000000000000000000100000010000000110000010000000101;
tkeep = 8'b11111111;
tvalid = 1;
tlast = 0;
#10;
din = 64'b0000011000000111000010000000100100001010000010110000110000001101;
tkeep = 8'b11111111;
tvalid = 1;
tlast = 0;
#10;
din = 64'b0000111000001111000100000001000100010010000100110001010000010101;
tkeep = 8'b11111111;
tvalid = 1;
tlast = 0;
#10;
din = 64'b0001011000010111000110000001100100011010000110110001110000011101;
tkeep = 8'b11111111;
tvalid = 1;
tlast = 0;
#10;
din = 64'b0001111000011111001000000010000100100010001000110010010000100101;
tkeep = 8'b11111111;
tvalid = 1;
tlast = 0;
#10;
din = 64'b0010011000100111001010000010100100101010001010110010110000101101;
tkeep = 8'b11111111;
tvalid = 1;
tlast = 0;
#10;
din = 64'b0010111000101111001100000011000100110010001100110011010000110101;
tkeep = 8'b11111111;
tvalid = 1;
tlast = 0;
#10;
din = 64'b0011011000110111001110000011100100111010001110110011110000111101;
tkeep = 8'b11111111;
tvalid = 1;
tlast = 0;
#10;
din = 64'b0011111000111111010000000100000101000010010000110100010001000101;
tkeep = 8'b11111111;
tvalid = 1;
tlast = 0;
#10;
din = 64'b0100011001000111010010000100100101001010010010110100110001001101;
tkeep = 8'b11111111;
tvalid = 1;
tlast = 0;
#10;
din = 64'b0100111001001111010100000101000101010010010100110101010001010101;
tkeep = 8'b11111111;
tvalid = 1;
tlast = 0;
#10;
din = 64'b0101011001010111010110000101100101011010010110110101110001011101;
tkeep = 8'b11111111;
tvalid = 1;
tlast = 0;
#10;
din = 64'b0101111001011111011000000110000101100010011000110000000000000000;
tkeep = 8'b11111100;
tvalid = 1;
tlast = 1;
#10;
tvalid = 0;
tlast = 0;
#20;
    end
endmodule
