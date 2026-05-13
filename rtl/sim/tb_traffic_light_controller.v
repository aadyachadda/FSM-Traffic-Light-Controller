`timescale 1ns/1ps

module tb_traffic_light_controller();

    // Inputs to UUT (Unit Under Test)
    reg clk;
    reg rst_n;

    // Outputs from UUT
    wire [2:0] light_NS;
    wire [2:0] light_EW;

    // Instantiate the Unit Under Test (UUT)
    traffic_light_controller uut (
        .clk(clk), 
        .rst_n(rst_n), 
        .light_NS(light_NS), 
        .light_EW(light_EW)
    );

    // Generate Clock: Toggle every 5ns (100MHz clock frequency)
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        rst_n = 0; // Apply reset at startup

        // Wait 20 ns for global reset to stabilize
        #20;
        rst_n = 1; // Release reset
        
        // Let the simulation run long enough to see multiple full state cycles
        #400;
        
        // Terminate Simulation cleanly
        $finish;
    end
      
    // Setup for dumping waveforms to view in GTKWave / EDA Playground
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_traffic_light_controller);
    end

endmodule
