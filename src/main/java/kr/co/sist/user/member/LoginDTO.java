package kr.co.sist.user.member;

public class LoginDTO {

	private String id, password;

	public LoginDTO() {
		super();
	}

	public LoginDTO(String id, String password) {
		super();
		this.id = id;
		this.password = password;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public String toString() {
		return "LoginDTO [id=" + id + ", password=" + password + "]";
	}
	
	
	
}
