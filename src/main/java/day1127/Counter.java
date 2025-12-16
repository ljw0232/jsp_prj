package day1127;

public class Counter {
	
	private int cnt;
	
	public Counter() {
		System.out.println("기본 생성자");
		cnt = 0; // 초기화
	} // Counter
	
	public int getCnt() {
		return cnt;
	} // getCnt
	
	public void setCnt(int cnt) {
		this.cnt += cnt; // 누적합
	} // setCnt
	
	
	
}
