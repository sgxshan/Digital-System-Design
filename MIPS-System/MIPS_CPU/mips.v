//--------------------------------------------------------------
// mips.v
// David_Harris@hmc.edu and Sarah_Harris@hmc.edu 23 October 2005
// Single-cycle MIPS processor
//--------------------------------------------------------------

// files needed for simulation:
//  mipsttest.v
//  mipstop.v
//  mipsmem.v
//  mips.v
//  mipsparts.v

// single-cycle MIPS processor
module mips(input         clk, reset,
            output [31:0] pc,
            input  [31:0] instr,
            output        memwrite,
            output [31:0] memaddr,
            output [31:0] memwritedata,
            input  [31:0] memreaddata);

  wire        enlh, signext, shiftl16, memtoreg, branch;
  wire        pcsrc, zero;
  wire        alusrc, regdst, regwrite, jump;
  wire [3:0]  alucontrol;

  // Instantiate Controller
  controller c(.op         (instr[31:26]), 
			      .funct      (instr[5:0]), 
					.zero       (zero),
					.enlh       (enlh),
               .signext    (signext), 
               .shiftl16   (shiftl16), 
               .memtoreg   (memtoreg), 
					.memwrite   (memwrite), 
					.pcsrc      (pcsrc),
               .alusrc     (alusrc), 
					.regdst     (regdst), 
					.regwrite   (regwrite), 
					.jump       (jump),
               .alucontrol (alucontrol));

  // Instantiate Datapath
  datapath dp( .clk        (clk), 
			      .reset      (reset), 
					.signext    (signext), 
					.enlh       (enlh),
					.shiftl16   (shiftl16), 
					.memtoreg   (memtoreg), 
					.pcsrc      (pcsrc),
               .alusrc     (alusrc), 
					.regdst     (regdst), 
					.regwrite   (regwrite), 
					.jump       (jump),
               .alucontrol (alucontrol),
               .zero       (zero), 
					.pc         (pc), 
					.instr      (instr),
               .aluout     (memaddr), 
					.writedata  (memwritedata), 
					.readdata   (memreaddata));

endmodule


module controller(input  [5:0] op, funct,
                  input        zero,
                  output       signext,
						output       enlh,
                  output       shiftl16,
                  output       memtoreg, memwrite,
                  output       pcsrc, alusrc,
                  output       regdst, regwrite,
                  output       jump,
                  output [3:0] alucontrol);

  wire [2:0] aluop;
  wire       branch;

  maindec md( .op    (op), 
				  .enlh  (enlh),
			     .signext   (signext), 
			     .shiftl16  (shiftl16), 
			     .memtoreg  (memtoreg), 
				  .memwrite  (memwrite), 
				  .branch    (branch),
              .alusrc    (alusrc), 
				  .regdst    (regdst), 
				  .regwrite  (regwrite), 
				  .jump      (jump),
              .aluop     (aluop));

  aludec  ad( .funct      (funct), 
			     .aluop      (aluop), 
				  .alucontrol (alucontrol));

  assign pcsrc = branch & zero;

endmodule


module maindec(input  [5:0] op,
					output       enlh,
               output       signext,
               output       shiftl16,
               output       memtoreg, memwrite,
               output       branch, alusrc,
               output       regdst, regwrite,
               output       jump,
               output [2:0] aluop);

  reg [12:0] controls;

  assign {enlh, signext, shiftl16, regwrite, regdst, 
			 alusrc, branch, memwrite,
          memtoreg, jump, aluop} = controls;

  always @(*)
    case(op)
      6'b000000: controls <= 13'b0001100000011; // Rtype
      6'b100011: controls <= 13'b0101010010000; // LW
      6'b101011: controls <= 13'b0100010100000; // SW
      6'b000100: controls <= 13'b0100001000001; // BEQ
      6'b001000, 
      6'b001001: controls <= 13'b0101010000000; // ADDI, ADDIU: only difference is exception
      6'b001101: controls <= 13'b0001010000010; // ORI
      6'b001111: controls <= 13'b0011010000000; // LUI
      6'b000010: controls <= 13'b0000000010000; // J
		6'b001100: controls <= 13'b0001010000101; // ANDI
		6'b100001: controls <= 13'b1101010010000; // LH
      default:   controls <= 13'bxxxxxxxxxxxxx; // ???
    endcase

endmodule

module aludec(input      [5:0] funct,
              input      [2:0] aluop,
              output reg [3:0] alucontrol);

  always @(*)
    case(aluop)
      3'b000: alucontrol <= 4'b0010;  // add
      3'b001: alucontrol <= 4'b1010;  // sub
      3'b010: alucontrol <= 4'b0001;  // or
		3'b101: alucontrol <= 4'b0000; //  and
      default: case(funct)          // RTYPE
          6'b100000,
          6'b100001: alucontrol <= 4'b0010; // ADD, ADDU: only difference is exception
          6'b100010,
          6'b100011: alucontrol <= 4'b1010; // SUB, SUBU: only difference is exception
          6'b100100: alucontrol <= 4'b0000; // AND
          6'b100101: alucontrol <= 4'b0001; // OR
			 6'b100111: alucontrol <= 4'b0100; // NOR
          6'b101010: alucontrol <= 4'b1011; // SLT
          default:   alucontrol <= 4'bxxxx; // ???
        endcase
    endcase
endmodule

module datapath(input         clk, reset,
					 input         enlh,
                input         signext,
                input         shiftl16,
                input         memtoreg, pcsrc,
                input         alusrc, regdst,
                input         regwrite, jump,
                input  [3:0]  alucontrol,
                output        zero,
                output [31:0] pc,
                input  [31:0] instr,
                output [31:0] aluout, writedata,
                input  [31:0] readdata);

  wire [4:0]  writereg;
  wire [15:0]  halfword;
  wire [31:0]  lhresult;
  wire [31:0]  out;
  wire [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
  wire [31:0] signimm, signimmsh, shiftedimm;
  wire [31:0] srca, srcb;
  wire [31:0] result;
  wire        shift;

  // next PC logic
  flopr #(32) pcreg (.clk   (clk), 
			            .reset (reset), 
						   .d     (pcnext), 
						   .q     (pc));

  adder       pcadd1 (.a (pc), 
			             .b (32'b100), 
						 	 .y (pcplus4));

  sl2         immsh (.a (signimm), 
			            .y (signimmsh));
				 
  adder       pcadd2 (.a (pcplus4), 
			             .b (signimmsh), 
							 .y (pcbranch));

  mux2 #(32)  pcbrmux(.d0  (pcplus4), 
			             .d1  (pcbranch), 
							 .s   (pcsrc), 
							 .y   (pcnextbr));

  mux2 #(32)  pcmux (.d0   (pcnextbr), 
			            .d1   ({pcplus4[31:28], instr[25:0], 2'b00}), 
                     .s    (jump), 
							.y    (pcnext));

  // register file logic
  regfile     rf(.clk     (clk), 
			        .we      (regwrite), 
					  .ra1     (instr[25:21]),
					  .ra2     (instr[20:16]), 
					  .wa      (writereg),
                 .wd      (result), 
					  .rd1     (srca), 
					  .rd2     (writedata));

					  
//loadhalf
//split 32 bits readdata to two 16 bits data and select one of them
  mux2 #(16)  lhsplit(.d0 (readdata[15:0]), 
			            .d1 (readdata[31:16]), 
							.s  (aluout[1]), 
							.y  (halfword));
							
//extend the 16 bits data to 32 bits with sign extend							
  sign_zero_ext  lhsze(.a      (halfword), 
			            .signext (signext),
			            .y       (lhresult));	
							
//judge whether load half word or load word
  mux2 #(32)  lhres(.d0 (readdata[31:0]), 
			            .d1 (lhresult),
							.s  (enlh),   //enable load half
							.y  (out));

//				  
  mux2 #(5)   wrmux(.d0  (instr[20:16]), 
			           .d1  (instr[15:11]), 
						  .s   (regdst), 
						  .y   (writereg));

  mux2 #(32)  resmux(.d0 (aluout), 
			            .d1 (out), 
							.s  (memtoreg), 
							.y  (result));

							
  sign_zero_ext  sze(.a       (instr[15:0]), 
			            .signext (signext),
			            .y       (signimm[31:0]));

  shift_left_16 sl16(.a         (signimm[31:0]), 
			            .shiftl16  (shiftl16),
			            .y         (shiftedimm[31:0]));

  // ALU logic
  mux2 #(32)  srcbmux(.d0 (writedata), 
			             .d1 (shiftedimm[31:0]), 
							 .s  (alusrc), 
							 .y  (srcb));

  alu         alu( .a       (srca), 
			          .b       (srcb), 
						 .alucont (alucontrol),
						 .result  (aluout), 
						 .zero    (zero));
endmodule
