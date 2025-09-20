`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2025 16:39:02
// Design Name: 
// Module Name: ip_parse_tb
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


parameter inwidth = 64;

module ip_parse_tb;
    reg clk;
    reg [inwidth-1:0] din;
    reg [7:0] tkeep;
    reg tvalid;
    reg tlast;
    wire [inwidth-1:0] out;
    wire [7:0] out_keep;
    wire outvalid;
    wire tlast_out; 
    wire parsing;
    wire [3:0] TIL_out;
    wire [2:0] word_on_out;
    
    ip_parse test (
        .clk(clk),
        .din(din),
        .tkeep(tkeep),
        .tvalid(tvalid),
        .tlast(tlast),
        .out(out),
        .out_keep(out_keep),
        .outvalid(outvalid),
        .tlast_out(tlast_out) ,
        .parsing(parsing),
        .TIL_out(TIL_out),
        .word_on_out(word_on_out)    
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



        din = 64'b0000010100000000000000000000000000000000000000000000000000000000;
        tkeep = 8'b11111111;
        tvalid = 1;
        tlast = 0;
        #10;
        din = 64'b0000000000000000000000000000000000000000000000000000000000000000;
        tkeep = 8'b11111111;
        tvalid = 1;
        tlast = 0;
        #10;
        din = 64'b0000000000000000000000000000000000000000000000010000001000000011;
        tkeep = 8'b11111111;
        tvalid = 1;
        tlast = 0;
        #10;
        din = 64'b0000010000000101000001100000011100001000000010010000101000001011;
        tkeep = 8'b11111111;
        tvalid = 1;
        tlast = 0;
        #10;
        din = 64'b0000110000001101000011100000111100010000000100010001001000010011;
        tkeep = 8'b11111111;
        tvalid = 1;
        tlast = 0;
        #10;
        din = 64'b0001010000010101000101100001011100011000000110010001101000011011;
        tkeep = 8'b11111111;
        tvalid = 1;
        tlast = 0;
        #10;
        din = 64'b0001110000011101000111100001111100100000001000010010001000100011;
        tkeep = 8'b11111111;
        tvalid = 1;
        tlast = 0;
        #10;
        din = 64'b0010010000100101001001100010011100101000001010010010101000101011;
        tkeep = 8'b11111100;
        tvalid = 1;
        tlast = 1;
        #10;
        tvalid = 0;
        tlast = 0;
        #20;
    end    





endmodule

