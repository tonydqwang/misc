package lego.parser;

public class VarVal {
	Var var;
	String name;
	Integer val;
	
	public VarVal(Var variable, int value) {
		this.var = variable;
		this.val = value;
	}
	
	public Integer getValue() {
		return val;
	}
	
	public String getVarName() {
		if (name == null) { // late instantiation
			name = var.s;
		}
		return name;
	}
}
