/**
 * File              : row_x_column.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 17.06.2026
 * Last Modified Date: 17.06.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module row_x_column #(
    parameter N = 8,
    parameter ELEM_SIZE = 4
) (
    input  [N-1:0] a[ELEM_SIZE-1:0],
    input  [N-1:0] b[ELEM_SIZE-1:0],
    input  [  N:0] p,
    output [N-1:0] s
);


  logic [N-1:0] mult_out[(ELEM_SIZE<<1)-2:0];

  genvar i;
  generate
    for (i = 0; i < ELEM_SIZE; i = i + 1) begin
      galois_multiplication #(
          .N(N)
      ) g_m_i (
          .a(a[i]),
          .b(b[i]),
          .p(p),
          .s(mult_out[i])
      );
    end
  endgenerate

  genvar j;
  generate
    for (j = 0; j < ELEM_SIZE - 1; j = j + 1) begin
      galois_adder #(
          .N(N)
      ) g_i (
          .a(mult_out[j<<1]),
          .b(mult_out[(j<<1)+1]),
          .s(mult_out[j+ELEM_SIZE])
      );
    end
  endgenerate

  assign s = mult_out[(ELEM_SIZE<<1)-2];


endmodule : row_x_column

