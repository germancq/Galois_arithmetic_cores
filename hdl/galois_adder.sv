/**
 * File              : galois_adder.sv
 * Author            : German C.Quiveu <germancq@dte.us.es>
 * Date              : 17.06.2026
 * Last Modified Date: 17.06.2026
 * Last Modified By  : German C.Quiveu <germancq@dte.us.es>
 */

module galois_adder #(
    parameter N = 8
) (
    input  [N-1:0] a,
    input  [N-1:0] b,
    output [N-1:0] s
);

  assign s = a ^ b;

endmodule : galois_adder
