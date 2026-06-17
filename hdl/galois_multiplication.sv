/**
 * File              : galois_multiplication.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 17.06.2026
 * Last Modified Date: 17.06.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module galois_multiplication #(
    parameter N = 8
) (
    input [(2*N)-2:0] a,
    input [(2*N)-2:0] b,
    input [N:0] p,
    output [N-1:0] s
);


  logic [(2*N)-2:0] m_out[(N<<1)-2:0];
  genvar i;
  generate
    for (i = 0; i < N; i = i + 1) begin
      mux #(
          .N((2 * N) - 1)
      ) m_i (
          .a(0),
          .b(a << i),
          .sel(b[i]),
          .dout(m_out[i])
      );
    end
  endgenerate

  genvar j;
  generate
    for (j = 0; j < N - 1; j = j + 1) begin
      galois_adder #(
          .N((2 * N) - 1)
      ) g_i (
          .a(m_out[j<<1]),
          .b(m_out[(j<<1)+1]),
          .s(m_out[j+N])
      );
    end
  endgenerate

  polinomial_reduction #(
      .N(N)
  ) polinomial_inst (
      .a(m_out[(N<<1)-2]),
      .p(p),
      .s(s)
  );



endmodule : galois_multiplication

