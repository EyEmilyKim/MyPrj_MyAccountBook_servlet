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
	private String id;
	
	private Integer rownum; //DB검색 정렬을 위한 변수 
	private String cate_name; //list용 카테고리 이름
	private String meth_name; //list용 결제수단 이름
	
	public Integer getRownum() {
		return rownum;
	}
	public void setRownum(Integer rownum) {
		this.rownum = rownum;
	}
	public String getCate_name() {
		return cate_name;
	}
	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}
	public String getMeth_name() {
		return meth_name;
	}
	public void setMeth_name(String meth_name) {
		this.meth_name = meth_name;
	}
	
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
}
