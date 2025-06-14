`timescale 1ns/1ps

module ripple_adder_tb;

    reg clk;
    reg [7:0] a, b;
    reg cin;
    wire [7:0] sum;
    wire cout;

    // Instantiate the design under test
    ripple_adder uut (
        .clk(clk),
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    // Clock generation (100 MHz)
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Display heading
        $display("Time\tclk\ta\t\tb\t\tcin\t|\tsum\t\tcout");
        $display("-------------------------------------------------------------");

        // Monitor changes in signals
        $monitor("%0t\t%b\t%h\t%h\t%b\t|\t%h\t%b", 
                 $time, clk, a, b, cin, sum, cout);

        // Dump waveform for GTKWave
         $fsdbDumpfile("novas.fsdb");
         $fsdbDumpvars(0, ripple_adder_tb);

        // Wait for a few clock edges
        #(10);

        // Test cases applied on rising clock edges
        @(posedge clk); a = 8'h00; b = 8'h00; cin = 0;
        @(posedge clk); a = 8'h01; b = 8'h01; cin = 0;
        @(posedge clk); a = 8'h55; b = 8'hAA; cin = 0;
        @(posedge clk); a = 8'hFF; b = 8'h01; cin = 0;
        @(posedge clk); a = 8'hFF; b = 8'hFF; cin = 1;
        @(posedge clk); a = 8'h3C; b = 8'hC3; cin = 0;

        // Finish simulation after one more clock cycle
        @(posedge clk); 
        #5 $finish;
    end

endmodule
