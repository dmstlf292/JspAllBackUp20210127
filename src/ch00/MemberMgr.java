package ch00;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import com.mysql.fabric.xmlrpc.base.Member;

public class MemberMgr {
	private DBConnectionMgr pool;
	public MemberMgr() {
		pool=DBConnectionMgr.getInstance();
	}
	
	public boolean loginMember(String id, String pwd) {//select db1
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "select id from tblMember where id=? and pwd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();// 중요
			flag=rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	public boolean checkId(String id) {//select db1
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "select id from tblMember where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();// 중요
			flag=rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	public Vector<ZipcodeBean> searchZipcode(String area3){//select db1
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ZipcodeBean> vlist = new Vector<ZipcodeBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblZipcode where area3 like ?";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();// 중요
			while(rs.next()) {
				ZipcodeBean bean = new ZipcodeBean();
				bean.setZipcode(rs.getString(1));
				bean.setArea1(rs.getString(2));
				bean.setArea2(rs.getString(3));
				bean.setArea3(rs.getString(4));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public boolean insertMember(MemberBean bean) {//insert->db2, 회원가입!!!
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "insert tblMember(id,pwd,name,gender,birthday,email,zipcode,address,hobby,job) values(?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,bean.getId());
			pstmt.setString(2,bean.getPwd());
			pstmt.setString(3,bean.getName());
			pstmt.setString(4,bean.getGender());
			pstmt.setString(5,bean.getBirthday());
			pstmt.setString(6,bean.getEmail());
			pstmt.setString(7,bean.getZipcode());
			pstmt.setString(8,bean.getAddress());
			//////////////////////////////////////////
			String lists[]= {"facebook","instagram","youtube","google","twitter"};
			String hobby[]=bean.getHobby();
			char hb[]= {'0','0','0','0','0'};//list 를 선택시 1 또는 0이라고 표현
			for (int i = 0; i < hobby.length; i++) {
				for (int j = 0; j < lists.length; j++) {
					if(hobby[i].equals(lists[j])) {
						hb[j]='1';
						break;
					}
				}
			}
			pstmt.setString(9, new String(hb));//"10101"
			//////////////////////////////////////////
			pstmt.setString(10, bean.getJob());
			//int cnt = pstmt.executeUpdate();
			if(pstmt.executeUpdate()==1) flag=true;// 중요
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//회원정보 가져오기(레코드 1개씩) db1이용---->회원정보 수정하기 위해서 먼저 가져오는게 우선이다!!
	//취미를 DB에서는 문자열로 입력되어 있는데, 빈즈는 배열이므로 신경쓰기!!!
	public MemberBean getMember(String id) {//select db1
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean = new MemberBean();//db1에서는 여기가 추가
		Object obj=bean;//db1에서는 여기가 추가
		try {
			con = pool.getConnection();
			sql = "select * from tblMember where id=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();// 중요
			
			if(rs.next()) {//여기 if문 추가함!!!, bean 담은거를 Mgr에서 bean 꺼내와야한다!!!!!
				bean.setId(rs.getString("id"));
				bean.setPwd(rs.getString("pwd"));
				bean.setName(rs.getString("name"));
				bean.setGender(rs.getString("gender"));
				bean.setBirthday(rs.getString("birthday"));
				bean.setEmail(rs.getString("email"));
				bean.setZipcode(rs.getString("zipcode"));
				bean.setAddress(rs.getString("address"));
				
				///////////////아래 배열부분 추가하기////////////////////////////
				String hobby=rs.getString("hobby");//----------------추가
				String hobbys[]=new String[5];//---------------------추가
				for (int i = 0; i < hobbys.length; i++) {
					hobbys[i]=hobby.substring(i,i+1);
				}
				bean.setHobby(hobbys);//-----------------------------추가
				/////////////////////////////////////////////
				
				bean.setJob(rs.getString("job"));
			
			}//if문
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean; //bean 꼭 해줘야함!!!
	}
	
	
	
	
	
	
	
	//회원정보 수정하기 (update!!!!!!!, db2) --> 회원가입과 거의 비슷함
	public boolean updateMember(MemberBean bean) {//update db2
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "update tblMember set pwd=?, name=?, gender=?, birthday=?, email=?, zipcode=?, address=?, hobby=?, job=?, where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,bean.getPwd());
			pstmt.setString(2,bean.getName());
			pstmt.setString(3,bean.getGender());
			pstmt.setString(4,bean.getBirthday());
			pstmt.setString(5,bean.getEmail());
			pstmt.setString(6,bean.getZipcode());
			pstmt.setString(7,bean.getAddress());
			//////////////////////////////////////////
			/* String lists[]= {"facebook","instagram","youtube","google","twitter"}; */
			String hobby[]=bean.getHobby();
			char hb[]= {'0','0','0','0','0'};
			String lists[]= {"facebook","instagram","youtube","google","twitter"};
			for (int i = 0; i < hobby.length; i++) {
				for (int j = 0; j < lists.length; j++) {
					if(hobby[i].equals(lists[j])) {
						hb[j]='1';
						break;
					}
				}
			}
			//////////////////////////////////////////
			pstmt.setString(8, new String(hb));
			pstmt.setString(9, bean.getJob());
			pstmt.setString(10,bean.getId());

			if(pstmt.executeUpdate()==1) flag=true;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

	//회원탈퇴하기(delete-db2)
	public void deleteMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from tblMember where id=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			/* int cnt = pstmt.executeUpdate(); */
			pstmt.executeUpdate();//여기 추가함, upgrade
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
}


















