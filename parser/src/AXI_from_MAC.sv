`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.09.2025 00:17:18
// Design Name: 
// Module Name: AXI_from_MAC
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


// ethernet header: destination (6), source(6), ethertype(2)


module AXI_from_MAC #(parameter inwidth = 64, [47:0] source = {48{1'b1}}, [15:0] etype = {{8{1'b0}},{1'b1},{7{1'b0}}})(
    input clk,
    input [inwidth-1:0] din,
    input [7:0] tkeep,
    input tvalid,
    input tlast,
    output reg [inwidth-1:0] out,
    output reg [7:0] out_keep,
    output reg outvalid,
    output reg tlast_out, 
    output parsing,
    output second_out
    
    );
    

    
    
    reg [15:0] overlap_delay = 16'b0;
    reg [1:0] overlap_keep = 2'b0;
    reg tvalid_delay = 0;
    

    
    
    reg parse = 0;
    reg second = 0;
    reg tlast_out_delay = 0;
    
    assign parsing = parse;
    assign second_out = second;
    
    wire [7:0] tkeep_anded;
    assign tkeep_anded = tkeep & {8{tvalid}};
    
    
    initial begin
        tlast_out = 0;
    end
  
    
    
    
    always @(posedge clk)begin
        tvalid_delay <= tvalid;
        overlap_delay <= din[15:0];
        overlap_keep <= tkeep_anded[1:0];
        outvalid <= parse;
        
        if(~tvalid_delay & tvalid & (din[63:16] == source)) begin
            second <= 1;
        end
        
        if(second) begin
            second <= 0;
        end
        
        
        
        
        if(tlast_out) begin
            tlast_out <= 0;
        end
        
        if(tlast_out_delay) begin
            tlast_out <= 1;
            tlast_out_delay <= 0;
            parse <= 0;
        end
        
        
        if(tlast) begin            
            if(tkeep[1:0] == 2'b00) begin
                tlast_out <= 1; 
                parse <= 0;
            end
            else begin
                tlast_out_delay <= 1;
            end
        end
        
        if(second) begin
            if(din[31:16] == etype) begin
                parse <= 1;
            end
        
        end
        
        
        if(parse) begin
            out <= {{overlap_delay},{din[inwidth-1:16]}};
            out_keep <= {{overlap_keep},{tkeep_anded[7:2]}};       
        end
        
    
    
    
    
    end
    
    
    
    
    
    
endmodule
