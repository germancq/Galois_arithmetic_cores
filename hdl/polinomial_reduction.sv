/**
 * File              : polinomial_reduction.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 17.06.2026
 * Last Modified Date: 17.06.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module polinomial_reduction #(
    parameter N = 8
) (
    input [(2*N)-2:0] a,
    input [(2*N)-2:0] p,
    output [N-1:0] s
);

  logic [(2*N)-2:0] m_out[N-1:0];
  logic [(2*N)-2:0] polinomials[N-1:0];
  assign polinomials[N-1] = a;

  genvar i;
  generate
    for (i = N - 2; i >= 0; i = i - 1) begin

      mux #(
          .N((2 * N) - 1)
      ) m_i (
          .a(0),
          .b(p << (i)),
          .sel(polinomials[i+1][N+i]),
          .dout(m_out[i])
      );

      galois_adder #(
          .N((2 * N) - 1)
      ) g_i (
          .a(polinomials[i+1]),
          .b(m_out[i]),
          .s(polinomials[i])
      );
    end
  endgenerate

  assign s = polinomials[0];


endmodule : polinomial_reduction

