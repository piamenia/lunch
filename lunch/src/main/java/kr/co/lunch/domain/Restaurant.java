package kr.co.lunch.domain;

public class Restaurant {
	private int rstcode, distance, tasty, price;
	private double totalscore;
	private String rstname, foodstyle, description, membercode;
	public int getRstcode() {
		return rstcode;
	}
	public void setRstcode(int rstcode) {
		this.rstcode = rstcode;
	}
	public int getDistance() {
		return distance;
	}
	public void setDistance(int distance) {
		this.distance = distance;
	}
	public int getTasty() {
		return tasty;
	}
	public void setTasty(int tasty) {
		this.tasty = tasty;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public double getTotalscore() {
		return totalscore;
	}
	public void setTotalscore(double totalscore) {
		this.totalscore = totalscore;
	}
	public String getRstname() {
		return rstname;
	}
	public void setRstname(String rstname) {
		this.rstname = rstname;
	}
	public String getFoodstyle() {
		return foodstyle;
	}
	public void setFoodstyle(String foodstyle) {
		this.foodstyle = foodstyle;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getMembercode() {
		return membercode;
	}
	public void setMembercode(String membercode) {
		this.membercode = membercode;
	}
	@Override
	public String toString() {
		return "Restaurant [rstcode=" + rstcode + ", distance=" + distance + ", tasty=" + tasty + ", price=" + price
				+ ", totalscore=" + totalscore + ", rstname=" + rstname + ", foodstyle=" + foodstyle + ", description="
				+ description + ", membercode=" + membercode + "]";
	}
	
}
