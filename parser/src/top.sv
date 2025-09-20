`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2025 19:20:20
// Design Name: 
// Module Name: top
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


module top#(parameter inwidth = 64,outwidth=64, [47:0] source = {48{1'b1}}, [15:0] etype = {{8{1'b0}},{1'b1},{7{1'b0}}})(
    input clk,
    input [inwidth-1:0] din,
    input [7:0] tkeep,
    input tvalid,
    input tlast,
    output [inwidth-1:0] out_ip,
    output [7:0] out_keep_ip,
    output outvalid_ip,
    output tlast_out_ip,
    output[inwidth-1:0] out_wire_v,
    output [7:0] out_keep_wire_v,
    output outvalid_wire_v,
    output tlast_out_wire_v
    
    
    );
    
    wire[inwidth-1:0] out_wire;
    wire [7:0] out_keep_wire;
    wire outvalid_wire;
    wire tlast_out_wire; 
    
    assign out_wire_v = out_wire;
    assign out_keep_wire_v = out_keep_wire;
    assign outvalid_wire_v = outvalid_wire;
   assign tlast_out_wire_v = tlast_out_wire; 
    
    
    
    
    AXI_from_MAC #(.inwidth(inwidth),.source(source),.etype(etype)) eth_layer(
    .clk(clk),
    .din(din),
    .tkeep(tkeep),
    .tvalid(tvalid),
    .tlast(tlast),
    .out(out_wire),
    .out_keep(out_keep_wire),
    .outvalid(outvalid_wire),
    .tlast_out(tlast_out_wire)
    );
    
    ip_parse #(.inwidth(inwidth)) ip_layer (
    .clk(clk),
    .din(out_wire),
    .tkeep(out_keep_wire),
    .tvalid(outvalid_wire),
    .tlast(tlast_out_wire),
    .out(out_ip),
    .out_keep(out_keep_ip),
    .outvalid(outvalid_ip),
    .tlast_out(tlast_out_ip)
    
    );
endmodule
