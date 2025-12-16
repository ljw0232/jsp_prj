package day1127;

public class DataDTO {
	
	private String name;
	private int myAge;
	
	public DataDTO() {
		System.out.println("DataDTO의 기본 생성자");
	}

	public DataDTO(String name, int myAge) {
		System.out.println("DataDTO의 인자 있는 생성자");
		this.name = name;
		this.myAge = myAge;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name;
	}
	
	public void setMyAge(int myAge) {
		this.myAge = myAge;
	}
	
	public int getMyAge() {
		return myAge;
	}
	
	@Override
	public String toString() {
		return "DataDTO [name=" + name + ", myAge=" + myAge + "]";
	}
	
}
