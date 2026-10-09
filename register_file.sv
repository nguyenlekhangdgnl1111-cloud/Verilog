module register_file(
input logic clk;// xung clock
input logic reset;// reset
input logic wr_en;//write-enable

input logic [4:0] rs_add ;// thanh ghi tam
input logic [4:0] rs1_add, rs2_add; // dia chi thanh ghi 1 va 2;

input logic [31:0] rd_data ; // thanh du lieu tam thoi
output logic [31:0] rd1_data, rd2_data; // thanh du lieu
);

logic [31:0] rf[31:0];

always_ff @(posedge clk || negedge reset ) begin
if (!reset) begin

for (i=0;i<32;i = i+1 ) begin
rf[i] <=32'b0;
end 

end 
elsif(wr_en && (rs_add != 0)) begin
rf[rs_add] <= rd_data;
end    
end
// tape out 
assign rd1_data = (rs1_add == 5'b0) ? 32'b0 : rf[rs1_add];
assign rd2_data = (rs2_add == 5'b0) ? 32'b0 : rf[rs2_add];    

endmodule
