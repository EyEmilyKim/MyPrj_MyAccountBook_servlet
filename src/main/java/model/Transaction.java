package model;

public class Transaction {
	private Integer seqno;
	private String inex;
	private String trans_date;
	private String cate_code;
	private String item;
	private Integer amount;
	private String meth_code;
	private String reg_date;
	
	public Integer getSeqno() {
		return seqno;
	}
	public void setSeqno(Integer seqno) {
		this.seqno = seqno;
	}
	public String getInex() {
		return inex;
	}
	public void setInex(String inex) {
		this.inex = inex;
	}
	public String getTrans_date() {
		return trans_date;
	}
	public void setTrans_date(String trans_date) {
		this.trans_date = trans_date;
	}
	public String getCate_code() {
		return cate_code;
	}
	public void setCate_code(String cate_code) {
		this.cate_code = cate_code;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public Integer getAmount() {
		return amount;
	}
	public void setAmount(Integer amount) {
		this.amount = amount;
	}
	public String getMeth_code() {
		return meth_code;
	}
	public void setMeth_code(String meth_code) {
		this.meth_code = meth_code;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	
}
