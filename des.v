`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.01.2024 19:15:10
// Design Name: 
// Module Name: des
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


module des(
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
    );
    
    parameter FALL=0,LEFT=1,RIGHT=2;
    reg [1:0] state,next_state,temp;
    
    always @ (*) begin
    
    case(state)
    
    FALL:begin
    if(!ground)
    next_state<=FALL;
    else
    next_state<=temp;
    end
    
    LEFT:begin
    if(!ground) begin
    next_state<=FALL;
    temp<=LEFT; end
    else begin
    if(!bump_left)
    next_state<=LEFT;
    else
    next_state<=RIGHT;
    end temp<=state;end
    
    RIGHT:begin
    if(!ground) begin
    next_state<=FALL;
    temp<=RIGHT; end
    else begin
    if(!bump_right)
    next_state<=RIGHT;
    else
    next_state<=LEFT;
    end
    temp<=state;
    end
    
    default:begin
    next_state<=LEFT;
    end
    
    endcase
    end
    
    always @ (posedge clk or posedge areset) begin
    if(areset)
    state<=LEFT;
    else
    state<=next_state;
    end
    
    assign walk_left=(state==LEFT)?1:0;
    assign walk_right=(state==RIGHT)?1:0;
    assign aaah=(state==FALL)?1:0;
endmodule
