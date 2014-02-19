// Evaluator for Lego formulas
package lego;

import java.lang.reflect.Field;
import java.util.Stack;

import lego.parser.*;

// data structure to store values of free variables
class Env {
	Stack<VarVal> vars; 
	
	Env() {
		vars = new Stack<VarVal>();
	}
	
	public VarVal pop() throws Exception {
		if (vars.empty()) {
			throw new Exception ("Stack is empty, no one variable to fetch");
		}		
		return vars.pop();
	}
	
	public void push(Var varName, int value) { 
		vars.push( new VarVal(varName, value));
	}
	
	public VarVal peek() throws Exception {
		return vars.peek();
	}
	
	/**
	 * Returns a deep copy of the stack
	 * for local scopes to work with
	 *  
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Stack<VarVal> stackCopy() {
		return (Stack<VarVal>) vars.clone();
	}
}

public class Eval {
	
  
	public static boolean eval(Formula f) {
		Env env = new Env(); 
		return eval(f, env);
	}
	
    public static boolean eval(Formula f, Env env) {
    	Boolean result = null;
    	
        try
        {
            Class<? extends Formula> fClass = f.getClass();

            if (f instanceof Atomic) { //determines top level of parse tree
            
            	String op = fClass.getDeclaredField("rel_op").get(f).toString();
            	Exp e1 = (Exp) fClass.getDeclaredField("e1").get(f);
            	Exp e2 = (Exp) fClass.getDeclaredField("e2").get(f);
            	
            	int v1 = ((Integer) evalExp(e1, env)).intValue();
            	int v2 = ((Integer) evalExp(e2, env)).intValue();
            	
            	if (op.equals(">")) { result = (v1 > v2)? true : false; }
            	else if (op.equals(">=")) { result = (v1 >= v2)? true : false; }
            	else if (op.equals("=")) { result = (v1 == v2)? true : false; }
            	
            } else if (f instanceof Unary) {
            	Formula fInternal = (Formula) f.getClass().getDeclaredField("f").get(f); 
            	result = eval(fInternal, env);
            	if (result.booleanValue() == true) {
            		result = false;
            	} else {
            		result = true;
            	}
            	
            } else if (f instanceof Binary) {
            	String op = fClass.getDeclaredField("bin_conn").get(f).toString();
            	Formula f1 = (Formula) f.getClass().getDeclaredField("f1").get(f);
            	Formula f2 = (Formula) f.getClass().getDeclaredField("f2").get(f);
            	Boolean b1 = eval(f1, env);
            	Boolean b2 = eval(f2, env);

            	if (op.equals("&&")) { result = (b1 && b2)? true : false; }
            	else if (op.equals("||")) { result = (b1 || b2)? true : false; }
            	else if (op.equals("->")) { result = (!b1 || b2)? true : false; }
            	else if (op.equals("<->")) { result = (b1.compareTo(b2)==0)? true : false; }
            	
            } else if (f instanceof Quantified) {
            	String quant = fClass.getDeclaredField("quant").get(f).toString();
            	Var var = (Var) fClass.getDeclaredField("var").get(f);
            	Domain dom = (Domain) fClass.getDeclaredField("dom").get(f);
            	int range = dom.to.n - dom.from.n + 1;
            	Formula f1 = (Formula) f.getClass().getDeclaredField("f").get(f);
            	
            	boolean resultPrev;
            	
            	if (quant.equals("forall")) { //loop through each sub proof
            		resultPrev = true; //prevent && series from always failing
            		for (int i = 0; i < range; i++) {
            			env.push(var, dom.from.n + i);
            			result = (eval(f1, env))? true : false;
            			if (!(result && resultPrev)) { return false; }
            			env.pop();
            			resultPrev = result;
            		}
        		} else if (quant.equals("exists")) {  //loop through each sub proof
        			resultPrev = false; //prevent || series from always passing
        			for (int i = 0; i < range; i++ ) {
        				env.push(var, dom.from.n + i);
        				result = (eval(f1, env))? true : false;
            			if (result || resultPrev) { return true; } 
            			env.pop();
            			resultPrev = result;
            		}
        		}
            }
        } catch (NoSuchFieldException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
    	return result;
    }
    
    /**
     * Evaluate an expression, which it and its result could be
     * an integer, a variable, expression bin_op expression, 
     * or another expression
     * 
     * @param expr
     * @return
     * @throws Exception 
     */
    public static Object evalExp (Exp expr, Env env) throws Exception {
    	
    	if (expr instanceof Int) {
    		return expr.getClass().getDeclaredField("n").get(expr);
    	}
    	else if (expr instanceof Var) {
    		String varName = expr.toString();
    		Stack<VarVal> localStack = env.stackCopy();
    		while (!localStack.empty()) {
    			VarVal var = localStack.pop();
    			if (varName.equals(var.getVarName())) {	return var.getValue();}
    		}
    		throw new Exception("Variable " + varName + " undefined");
    	}
    	else if (expr instanceof BinExp) {
    		String op = expr.getClass().getDeclaredField("bin_op").get(expr).toString();
    		Exp e1 = (Exp) expr.getClass().getDeclaredField("e1").get(expr);
    		Exp e2 = (Exp) expr.getClass().getDeclaredField("e2").get(expr);
    		Integer evalE1 = (Integer) evalExp(e1, env);
    		Integer evalE2 = (Integer) evalExp(e2, env);
    		
    		if (op.equals("+")) { return (evalE1 + evalE2); }
    		else if (op.equals("-")) { return (evalE1 - evalE2); }
    		else if (op.equals("*")) { return (evalE1 * evalE2); }
    		else if (op.equals("/")) { 
    			if (evalE2 == 0) { 
    				throw new Exception ("Division by zero in " + evalE1 + " / " + evalE2);
    			}
    			return (evalE1 / evalE2); }
    		else if (op.equals("mod")) { 
    			if (evalE2 == 0) { 
    				throw new Exception ("Mod by zero in " + evalE1 + " % " + evalE2);
    			}
    			return (evalE1 % evalE2); }
    	}
    	else if (expr instanceof Exp) {
    		return evalExp(expr, env); //how do you get in here?
    	}
    	throw new Exception("Unknown expression format");
    }
}