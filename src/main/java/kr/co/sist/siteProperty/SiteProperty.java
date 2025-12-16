package kr.co.sist.siteProperty;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.sist.dao.DbConn;

public class SiteProperty {
	
	public static SitePropertyVO spVO;
	// static 영역에 클래스가 사용되면 한 번만 자동 호출되는 영역
	static {
		DbConn db = DbConn.getInstance("jdbc/dbcp");
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn();
			// site_property 테이블에 여러 개의 데이터를 넣어 놓으면 에러가 발생하기 때문에 where절을 추가하여
			// 그때그때 용도에 맞는 번호를 입력하는 방법으로 데이터를 매번 수정하지 않고 사용할 수 있다.
			String selectSiteInfo = "select protocol, server_name, context_root, manage_path, key, title from site_property where num = 1";
			
			pstmt = con.prepareStatement(selectSiteInfo);
			rs = pstmt.executeQuery();
			
			// 조회된 결과를 
			if(rs.next()) {
				spVO = new SitePropertyVO(
						rs.getString("protocol"),
						rs.getString("server_name"),
						rs.getString("context_root"),
						rs.getString("manage_path"),
						rs.getString("key"),
						rs.getString("title"));
				
			} // end if
		} catch(SQLException se) {
			se.printStackTrace();
		} // end try ~ catch
		
	} // static
	
	
	
	
} // class
