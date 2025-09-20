`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.09.2025 18:24:08
// Design Name: 
// Module Name: AXI_from_MAC_tb
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

module AXI_from_MAC_tb;
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
    wire second_out;
    
    AXI_from_MAC test (
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
        .second_out(second_out)    
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
        
        din = 64'b1111111111111111111111111111111111111111111111110000000001110000;
        tkeep = 8'b11111111;
        tvalid = 1;
        tlast = 0;
        #10;
        din = 64'b0000000111100000000000000000000000000001100000000000000000000001;
        tkeep = 8'b11111111;
        tvalid = 1;
        tlast = 0;
        #10;
        din = 64'b0000001000000011000001000000010100000110000001110000100000001001;
        tkeep = 8'b11111111;
        tvalid = 1;
        tlast = 0;
        #10;
        din = 64'b0000101000001011000011000000110100001110000011110001000000010001;
        tkeep = 8'b11111111;
        tvalid = 1;
        tlast = 0;
        #10;
        din = 64'b0001001000010011000101000001010100010110000101110001100000011001;
        tkeep = 8'b11111111;
        tvalid = 1;
        tlast = 0;
        #10;
        din = 64'b0001101000011011000111000001110100011110000111110010000000100001;
        tkeep = 8'b11111111;
        tvalid = 1;
        tlast = 0;
        #10;
        din = 64'b0010001000100011001001000010010100100110001001110010100000101001;
        tkeep = 8'b11111100;
        tvalid = 1;
        tlast = 1;
        #10;
        tvalid = 0;
        tlast = 0;
        #20;




        
        
                
        din = 64'b1111111111111111111111111111111111111111111111110000000000000000;
        tkeep = 8'b11111111;
        tvalid = 1;
        tlast = 0;
        #10;
        din = 64'b0000000000000000000000000000000000000000100000000000000000000001;
        tkeep = 8'b11111111;
        tvalid = 1;
        tlast = 0;
        #10;
        din = 64'b0000001000000011000001000000010100000110000001110000100000001001;
        tkeep = 8'b11111111;
        tvalid = 1;
        tlast = 0;
        #10;
        din = 64'b0000101000001011000011000000110100001110000011110001000000010001;
        tkeep = 8'b11111111;
        tvalid = 1;
        tlast = 0;
        #10;
        din = 64'b0001001000010011000101000001010100010110000101110001100000011001;
        tkeep = 8'b11111000;
        tvalid = 1;
        tlast = 1;
        #10;
        tvalid = 0;
        tlast = 0;
        #20;
    end    





endmodule
