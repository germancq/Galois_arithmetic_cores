/**
 * File              : matrix_multiplication.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 17.06.2026
 * Last Modified Date: 17.06.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module matrix_multiplication #(
    parameter N = 8,
    parameter COL_A = 4,
    parameter ROW_A = 4,
    parameter COL_B = 1
) (
    input  [N-1:0] a[(ROW_A*COL_A)-1:0],
    input  [N-1:0] b[(COL_A*COL_B)-1:0],
    input  [  N:0] p,
    output [N-1:0] s[(ROW_A*COL_B)-1:0]
);


  genvar i;
  genvar j;
  genvar k;
  generate
    for (i = 0; i < ROW_A; i = i + 1) begin
      logic [N-1:0] A_row[COL_A-1:0];
      for (k = 0; k < COL_A; k = k + 1) begin
        assign A_row[k] = a[(i*COL_A)+k];
      end


      for (j = 0; j < COL_B; j = j + 1) begin
        logic [N-1:0] B_col[COL_A-1:0];
        for (k = 0; k < COL_A; k = k + 1) begin
          assign B_col[k] = b[(k*COL_B)+j];
        end

        row_x_column #(
            .N(N),
            .ELEM_SIZE(COL_A)
        ) rc3 (
            .a(A_row),
            .b(B_col),
            .p(p),
            .s(s[(COL_B*i)+j])
        );
      end
    end

  endgenerate

endmodule : matrix_multiplication

