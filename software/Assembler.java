/*
Written by Chris Junior Tchapmou
January 10 2026
*/

package software;
import java.util.*;
import java.io.*;

public class Assembler {
	private static final String INPUTFILE = ""; //put assembly file name here
	private static final String OUTPUTFILE =""; //put machine code output file here
	private static int lineNum = 0;
	
	private static ArrayList<Branch> labels = new ArrayList<Branch>();
	public static void main(String args[]) {
		Scanner fileReader;
		PrintWriter writer;
		try {
			writer = new PrintWriter(new FileOutputStream (new File(OUTPUTFILE)));
		}
		catch (Exception e) {
			System.out.println("Output file not found");
			return;
		}
		try {
			fileReader = new Scanner(new File(INPUTFILE));
		}
		catch(Exception e){
			System.out.println("Input file not found");
            writer.close();
			return;
		}
		int instruction = 0;
		while(fileReader.hasNext()) { // scans for labels first
			String nextLine = fileReader.nextLine();
			String[] tokens = nextLine.split(" ");
			if(nextLine.equals("")) {
				continue;
			}
			instruction++;
			for(int i = 0; i < tokens.length; i++) {
				if(tokens[i].indexOf(":") == 0) {
					labels.add(new Branch(tokens[i].substring(1),instruction));
				}
			}
			
		}
		
		
		try {
			fileReader = new Scanner(new File(INPUTFILE));
		}
		catch(Exception e){
			System.out.println("Input file not found");
            writer.close();
			return;
		}
		instruction = 0;
		String line;
		while(fileReader.hasNextLine()) {
			lineNum++;
			line = fileReader.nextLine();
			if(line.equals("")) {
				continue;
			}
			instruction++;
			try {
			writer.println(parse(line,instruction));
		}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		fileReader.close();
		writer.close();
	}
	
	public static String parse(String line, int instruction) throws Exception{ //parses a line of assembly code into machine code
		String[] tokens = line.split("\\s");
		int tokenSize = tokens.length;
		if(tokenSize == 0) {
			return "";
		}
		boolean RType = tokens[0].equals("add")||tokens[0].equals("sub")||tokens[0].equals("and")||tokens[0].equals("or")||tokens[0].equals("xor")||tokens[0].equals("slog")||tokens[0].equals("sari")||tokens[0].equals("iltu")||tokens[0].equals("ilt")||tokens[0].equals("eq")||tokens[0].equals("neq");
		boolean IType = tokens[0].equals("addi")||tokens[0].equals("andi")||tokens[0].equals("ori")||tokens[0].equals("xori")||tokens[0].equals("slogi")||tokens[0].equals("sarii")||tokens[0].equals("iltui")||tokens[0].equals("ilti")||tokens[0].equals("eqi")||tokens[0].equals("neqi");
		boolean memType = tokens[0].equals("lw")||tokens[0].equals("sw")||tokens[0].equals("li")||tokens[0].equals("lui");
		boolean branchType = tokens[0].equals("bt")||tokens[0].equals("bf");
		
		if(RType) {
			if(tokenSize < 4) {
				throw new Exception("Line " + lineNum + " Incorrect operand amount");
			}
			String opcode = "";
			switch(tokens[0]) {
			case "add":
				opcode = "00000";
				break;
			case "sub":
				opcode = "00001";
				break;
			case "and":
				opcode = "00010";
				break;
			case "or":
				opcode = "00011";
				break;
			case "xor":
				opcode = "00100";
				break;
			case "slog":
				opcode = "00101";
				break;
			case "sari":
				opcode = "00110";
				break;
			case "iltu":
				opcode = "00111";
				break;
			case "ilt":
				opcode = "01000";
				break;
			case "eq":
				opcode = "01001";
				break;
			case "neq":
				opcode = "01010";
				break;
			}
			String reg1;
			String reg2;
			String rd;
			try {
				reg1 = convertToBinary(Integer.parseInt(tokens[1].replace(",", "")),5);
				reg2 = convertToBinary(Integer.parseInt(tokens[2].replace(",", "")),5);
				rd = convertToBinary(Integer.parseInt(tokens[3].replace(",", "")),5);
			}
			catch (Exception e) {
				throw new Exception("Line " + lineNum + " Error in operands");
			}
			return "000000000000" + reg2 + reg1 + rd + opcode;
		}
		
		
		
		if(IType) {
			if(tokenSize < 4) {
				throw new Exception("Incorrect operand amount");
			}
			String opcode = "";
			switch(tokens[0]) {
			case "addi":
				opcode = "01011";
				break;
			case "andi":
				opcode = "01100";
				break;
			case "ori":
				opcode = "01101";
				break;
			case "xori":
				opcode = "01110";
				break;
			case "slogi":
				opcode = "01111";
				break;
			case "sarii":
				opcode = "10000";
				break;
			case "iltui":
				opcode = "10001";
				break;
			case "ilti":
				opcode = "10010";
				break;
			case "eqi":
				opcode = "10011";
				break;
			case "neqi":
				opcode = "10100";
				break;
			}
			String reg1;
			String imm;
			String rd;
			try {
				reg1 = convertToBinary(Integer.parseInt(tokens[1].replace(",", "")),5);
				imm = convertToBinary(Integer.parseInt(tokens[2].replace(",", "")),17);
				rd = convertToBinary(Integer.parseInt(tokens[3].replace(",", "")),5);
			}
			catch (Exception e) {
				throw new Exception("Line " + lineNum + " Error in operands");
			}
			return imm + reg1 + rd + opcode;
		}
		
		
		
		if(memType) {
			if(tokenSize < 3) {
				throw new Exception("Line " + lineNum + " Incorrect operand amount");
			}
			String opcode = "";
			switch(tokens[0]) {
			case "lw":
				opcode = "10101";
				break;
			case "sw":
				opcode = "10110";
				break;
			case "li":
				opcode = "11011";
				break;
			case "lui":
				opcode = "11100";
				break;
			}
			String imm;
			String rd;
			try {
				imm = convertToBinary(Integer.parseInt(tokens[2].replace(",", "")),17);
				rd = convertToBinary(Integer.parseInt(tokens[1].replace(",", "")),5);
			}
			catch (Exception e) {
				throw new Exception("Line " + lineNum + " Error in operands");
			}
			return imm + "00000" + rd + opcode;
		}
		
		
		if(branchType) {
			if(tokenSize < 3) {
				throw new Exception("Line " + lineNum + " Incorrect operand amount");
			}
			String opcode = "";
			switch(tokens[0]) {
			case "bt":
				opcode = "10111";
				break;
			case "bf":
				opcode = "11000";
				break;
			}
			String imm = "";
			String reg1 = "";
			boolean labelExists = false;
			int offset = 0;
			for(int i = 0; i < labels.size(); i++) {
				if(tokens[2].equals(labels.get(i).name)) {
					labelExists = true;
					offset = labels.get(i).line - lineNum;
				}
			}
			if(!labelExists) {
				throw new Exception("Line " + lineNum + " Label does not exist");
			}
			try {
				reg1 = convertToBinary(Integer.parseInt(tokens[1].replace(",", "")),5);
				imm = convertToBinary(offset,17);
			}
			catch(Exception e) {
				throw new Exception("Line " + lineNum + " Error in operands");
			}
			return imm + reg1 + "00000" + opcode;
		}
		
		if(tokens[0].equals("jal")) {
			if(tokenSize < 3) {
				throw new Exception("Line " + lineNum + " Incorrect operand amount");
			}
			boolean labelExists = false;
			int offset = 0;
			for(int i = 0; i < labels.size(); i++) {
				if(tokens[2].equals(labels.get(i).name)) {
					labelExists = true;
					offset = labels.get(i).line - instruction;
				}
			}
			if(!labelExists) {
				throw new Exception("Line " + lineNum + " Label does not exist");
			}
			String imm;
			String rd;
			try {
				imm = convertToBinary(offset,17);
				rd = convertToBinary(Integer.parseInt(tokens[1].replace(",", "")),5);
			}
			catch(Exception e) {
				throw new Exception("Line " + lineNum + " Error in operands");
			}
			return imm + "00000" + rd + "11001";
		}
		
		
		if(tokens[0].equals("jalr")) {
			if(tokenSize < 4) {
				throw new Exception("Line " + lineNum + " Incorrect operand amount");
			}
			String reg1;
			String imm;
			String rd;
			try {
				reg1 = convertToBinary(Integer.parseInt(tokens[1].replace(",", "")),5);
				imm = convertToBinary(Integer.parseInt(tokens[2].replace(",", "")),17);
				rd = convertToBinary(Integer.parseInt(tokens[3].replace(",", "")),5);
			}
			catch (Exception e) {
				throw new Exception("Line " + lineNum + " Error in operands");
			}
			return imm + reg1 + rd + "11010";
		}
		
		if(tokens[0].equals("ebreak")) {
			return "00000000000000000000000000011111";
		}
		
		
		throw new Exception("Line " + lineNum + " Malformed statement");
	}
	
	public static String convertToBinary(int num, int size) { // converts an integer to a binary string of given size
		String binaryNum = "";
		if(num>=0) {
			for(int i = 0; i < size; i++) {
				if(num%2==0) {
					binaryNum = "0" + binaryNum;
				}
				else {
					binaryNum = "1" + binaryNum;
				}
				num/=2;
			}
		}
		else {
			binaryNum = Integer.toBinaryString(num).substring(32-size);
		}
		return binaryNum;
	}

}
