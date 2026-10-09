module ALU_32bit #(parameter n = 32)(
    input wire [n-1:0] a,
    input wire [n-1:0] b,
    input wire [n-1:0] alu_control,
    output reg [n-1:0] result,
    output wire zero,
    output reg carry,
    output wire overflow,
    output wire negative 
);
    wire [n-1:0] choose;
    wire [n-1:0] sub_result, logic_result;
    wire sub_bout;
    wire [n-1:0] a_log_right, a_ari_right, a_left; 
    wire [n-1:0] b_log_right, b_ari_right, b_left;
    wire sub_m = alu_control[0];
    wire slt, sltu, eq;
    
    fullsub32bit #(n) fa1(
        .a(a),
        .b(b),
        .m(sub_m),
        .result(sub_result),
        .bout(sub_bout)
    );

    logicgate #(n) lg(
        .a(a),
        .b(b),
        .choose(alu_control),
        .result(logic_result)
    );

    workshift #(n) wsa(
        .in_signed(a),
        .in_unsigned(a),
        .out_right(a_log_right),
        .out_arith_right(a_ari_right),
        .out_left(a_left)
    );

    workshift #(n) wsb(
        .in_signed(b),
        .in_unsigned(b),
        .out_right(b_log_right),
        .out_arith_right(b_ari_right),
        .out_left(b_left)
    ); 

    comparator da(
        .a(a),
        .b(b),
        .eq(eq),
        .slt(slt),
        .sltu(sltu)
    );

    always @(*) begin
        carry = 1'b0;
        case (alu_control)
            32'b00000000: begin
                result = sub_result;
                carry = sub_result[0]; // Sửa lại gán carry hợp lý hơn
            end 
            32'b00000001: begin
                result = sub_result;
                carry = sub_result[0];
            end
            32'b00000010: result = logic_result; 
            32'b00000011: result = logic_result; 
            32'b00000100: result = logic_result; 
            32'b00000101: result = logic_result; 
            32'b00000110: result = logic_result; 
            32'b00000111: result = logic_result; 
            32'b00001000: result = logic_result; 
            32'b00001001: result = logic_result; 
            32'b00001010: result = a_log_right;
            32'b00001011: result = a_ari_right;
            32'b00001100: result = a_left;
            32'b00001101: result = b_log_right;
            32'b00001110: result = b_ari_right; // Sửa lỗi thiếu số 0 ở binary
            32'b00001111: result = b_left;
            32'b00010000:  result = { {n-1{1'b0}}, eq };
            32'b00010001:  result = { {n-1{1'b0}}, slt };
            32'b00010010:  result = { {n-1{1'b0}}, sltu };
            default: begin
                result = {n{1'b0}};
                carry  = 1'b0;
            end
        endcase    
    end

    assign zero     = (result == {n{1'b0}});
    assign negative = result[n-1];
    assign overflow = (a[n-1] ^ b[n-1] ^ alu_control[0]) & (a[n-1] ^ result[n-1]);

endmodule

module logicgate #(parameter n = 32)(
    input wire [n-1:0] a, b,
    input wire [n-1:0] choose,
    output reg [n-1:0] result
);
    always @(*) begin
        case (choose)
            32'b00000010: result = a & b;
            32'b00000011: result = a | b;
            32'b00000100: result = a ^ b;
            32'b00000101: result = ~a;
            32'b00000110: result = ~b;
            32'b00000111: result = ~(a & b);
            32'b00001000: result = ~(a | b);
            32'b00001001: result = ~(a ^ b);
            default:      result = {n{1'b0}};
        endcase
    end
endmodule

module workshift #(parameter n = 32)(
    input wire signed [n-1:0] in_signed,
    input wire [n-1:0] in_unsigned,
    output wire [n-1:0] out_right,
    output wire [n-1:0] out_arith_right,
    output wire [n-1:0] out_left
); 
    assign out_left = in_unsigned << 1;
    assign out_right = in_unsigned >> 1;
    assign out_arith_right = $signed(in_signed) >>> 1;
endmodule

module fullsub32bit #(parameter n = 32)(
    input wire [n-1:0] a, b,
    input wire m,
    output wire [n-1:0] result,
    output wire bout
);
    wire [n:0] carry;
    assign carry[0] = m;
    wire [n-1:0] b_xor;
    assign b_xor = b ^ {n{m}};
    
    genvar i;
    generate
        for (i = 0; i < n; i = i + 1) begin : gen_adder
            full_adder fa(
                .a(a[i]),
                .b(b_xor[i]),
                .cin(carry[i]),
                .sum(result[i]),
                .carry(carry[i+1])
            ); 
        end
    endgenerate
    assign bout = carry[n];
endmodule

module full_adder (
    input wire a, b, cin,
    output wire sum, carry
);
  wire w [2:0];
  half_adder ha1 (.a(a),.b(b),.s(w[0]),.carry(w[1]));
  half_adder ha2(.a(w[0]),.b(cin),.s(sum),.carry(w[2]));
  assign carry = w[2] | w[1];
endmodule

module half_adder (
    input wire a, b,
    output reg s, carry
);
    always @(*) begin
        s = a ^ b;
        carry = a & b;
    end 
endmodule

module comparator #(parameter n = 32)(
    input wire [n-1:0] a,
    input wire [n-1:0] b,
    output wire eq, 
    output wire slt, 
    output wire sltu 
);
    assign eq = (a == b);


    `timescale 1ps/1ps

module tb;
    parameter n = 32;
    reg  [n-1:0] a, b;
    reg  [n-1:0] alu_control;
    wire [n-1:0] result;
    wire zero;
    wire carry;
    wire overflow;
    wire negative;         
    
    integer i, k, j, loi, signal;
    reg [n-1:0] ketqua;
    
    ALU_32bit #(n) alu1(
        .a(a),
        .b(b),
        .alu_control(alu_control),
        .result(result),
        .zero(zero),
        .carry(carry),
        .overflow(overflow),
        .negative(negative)
    );
     
    initial begin
        loi = 0; 
         
      for (i = 0; i < 19; i = i + 1) begin
        for (k = 0; k < 15; k = k + 1) begin
          for (j = 0; j <15; j = j + 1) begin
                    a = j;
                    b = k; 
                    alu_control = i;
                    signal = 0; 
                     
                    #5;     
                    case (alu_control)
                        32'b00000000: ketqua = a + b; 
                        32'b00000001: ketqua = a - b; 
                        32'b00000010: ketqua = a & b;
                        32'b00000011: ketqua = a | b; 
                        32'b00000100: ketqua = a ^ b; 
                        32'b00000101: ketqua = ~a;  
                        32'b00000110: ketqua = ~b; 
                        32'b00000111: ketqua = ~(a & b); 
                        32'b00001000: ketqua = ~(a | b);
                        32'b00001001: ketqua = ~(a ^ b);
                        32'b00001010: ketqua = a >> 1;
                        32'b00001011: ketqua = a >>> 1;
                        32'b00001100: ketqua = a << 1;
                        32'b00001101: ketqua = b >> 1;  // Đã sửa lỗi thiếu số 0
                        32'b00001110: ketqua = b >>> 1; // Đã sửa lỗi thiếu số 0
                        32'b00001111: ketqua = b << 1;
                        32'b00010000:  ketqua = { {n-1{1'b0}}, (a == b) };
                        32'b00010001:  ketqua = { {n-1{1'b0}}, ($signed(a) < $signed(b)) };
                        32'b00010010:  ketqua = { {n-1{1'b0}}, (a < b) };
                        default:      ketqua = {n{1'b0}};
                    endcase
                    
                    #5;
                    if (result != ketqua) begin
                        loi = loi + 1;  
                        signal = 1;  
                    end
                    
                    $display("||time=%0d|a=%b|b=%b|alu_control=%b|result=%b|ketqua=%b|signal=%0d||", $time, a, b, alu_control, result, ketqua, signal);
                end
            end
        end
        
        $display("SO LOI DUOC PHAT HIEN RA LA : %0d", loi);
        $finish; 
    end
     
endmodule
    assign slt = ($signed(a) < $signed(b));
    assign sltu = (a < b); 
endmodule
