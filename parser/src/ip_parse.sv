`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2025 15:07:07
// Design Name: 
// Module Name: ip_parse
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


module ip_parse #(parameter inwidth = 64)(
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
    output [2:0] word_on_out,
    output [3:0] TIL_out
    
    );
    
    reg header_reading = 0;
    
    reg[3:0] TIL = 4'b0000;
    wire TIL_odd = TIL[0];
    wire [2:0] words = TIL[3:1];
    
    reg [2:0] word_on = 3'b000;
    

    
    
    reg [31:0] overlap_delay = 31'b0;
    reg [7:0] overlap_keep = 31'b0;
    reg tvalid_delay = 0;
    

    
    
    reg parse = 0;
    reg tlast_out_delay = 0;
    
    assign parsing = parse;
    assign word_on_out = word_on;
    assign TIL_out = TIL;
    
    wire [7:0] tkeep_anded;
    assign tkeep_anded = tkeep & {8{tvalid}};
    
    
    initial begin
        tlast_out = 0;
    end
  
    
    
    
    always @(posedge clk)begin
        tvalid_delay <= tvalid;
        overlap_delay <= din[31:0];
        overlap_keep <= tkeep_anded[3:0];
        outvalid <= parse;
        
        if(header_reading) begin
            word_on <= word_on + 1;
        end
        
        if(word_on == words-2+TIL_odd & tvalid) begin
            header_reading <= 0;
            parse <= 1;        
        end
        
        if(~tvalid_delay & tvalid) begin
            TIL <= din[59:56];
            header_reading <= 1;
            word_on <= 3'b000;
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
            if(tkeep[3:0] == 4'b00) begin
                tlast_out <= 1; 
                parse <= 0;
            end
            else begin
                tlast_out_delay <= 1;
            end
        end
        
        
        
        
        if(parse) begin
            if(TIL_odd) begin
                out <= {{overlap_delay},{din[63:32]}};
                out_keep <= {{overlap_keep},{tkeep_anded[7:4]}};  
            end
            
            else begin
                out <= din;
                out_keep <= tkeep_anded;
            
            end     
        end
        
    
    
    
    
    end
    
    
    
    
    
    
endmodule
