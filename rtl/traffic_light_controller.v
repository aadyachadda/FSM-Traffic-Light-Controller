// 2nd Year VLSI Project: FSM-Based Traffic Light Controller
// Style: Synthesis-friendly sequential design

module traffic_light_controller (
    input  wire       clk,      // System Clock
    input  wire       rst_n,    // Asynchronous Active-Low Reset
    output reg  [2:0] light_NS, // North-South Lights: [Red, Yellow, Green]
    output reg  [2:0] light_EW  // East-West Lights:   [Red, Yellow, Green]
);

    // State Encoding using Parameters (Binary Encoding)
    parameter S0_NS_G_EW_R = 2'b00, // NS Green, EW Red
              S1_NS_Y_EW_R = 2'b01, // NS Yellow, EW Red
              S2_NS_R_EW_G = 2'b10, // NS Red, EW Green
              S3_NS_R_EW_Y = 2'b11; // NS Red, EW Yellow

    // Time Delays for States (in clock cycles for simulation convenience)
    parameter GREEN_DELAY  = 4'd10,
              YELLOW_DELAY = 4'd3;

    // Internal State and Counter Registers
    reg [1:0] current_state, next_state;
    reg [3:0] delay_counter;

    // --- Block 1: State Register & Delay Counter (Sequential) ---
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= S0_NS_G_EW_R;
            delay_counter <= 4'd0;
        end else begin
            if (((current_state == S0_NS_G_EW_R || current_state == S2_NS_R_EW_G) && (delay_counter == GREEN_DELAY - 1)) ||
                ((current_state == S1_NS_Y_EW_R || current_state == S3_NS_R_EW_Y) && (delay_counter == YELLOW_DELAY - 1))) begin
                current_state <= next_state;
                delay_counter <= 4'd0; // Reset counter on state change
            end else begin
                delay_counter <= delay_counter + 1'b1;
            end
        end
    end

    // --- Block 2: Next State Logic (Combinational) ---
    always @(*) begin
        case (current_state)
            S0_NS_G_EW_R: next_state = S1_NS_Y_EW_R;
            S1_NS_Y_EW_R: next_state = S2_NS_R_EW_G;
            S2_NS_R_EW_G: next_state = S3_NS_R_EW_Y;
            S3_NS_R_EW_Y: next_state = S0_NS_G_EW_R;
            default:      next_state = S0_NS_G_EW_R;
        endcase
    end

    // --- Block 3: Output Logic (Combinational Moore Outputs) ---
    always @(*) begin
        // Light Bit Mapping: [Bit 2 = Red, Bit 1 = Yellow, Bit 0 = Green]
        case (current_state)
            S0_NS_G_EW_R: begin
                light_NS = 3'b001; // Green
                light_EW = 3'b100; // Red
            end
            S1_NS_Y_EW_R: begin
                light_NS = 3'b010; // Yellow
                light_EW = 3'b100; // Red
            end
            S2_NS_R_EW_G: begin
                light_NS = 3'b100; // Red
                light_EW = 3'b001; // Green
            end
            S3_NS_R_EW_Y: begin
                light_NS = 3'b100; // Red
                light_EW = 3'b010; // Yellow
            end
            default: begin
                light_NS = 3'b100; // Red Default
                light_EW = 3'b100;
            end
        endcase
    end

endmodule
