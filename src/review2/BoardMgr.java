package review2;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import review2.BoardMgr;
import review2.BoardBean;
import review2.DBConnectionMgr;
import review2.UtilMgr;

public class BoardMgr {
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Jsp/myapp/WebContent/review2/fileupload/";
	public static final String ENCTYPE = "EUC-KR";
	public static int MAXSIZE = 10*1024*1024;//10MB
	
	public BoardMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//Board Insert-->ok
		public void insertBoard(HttpServletRequest req) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				/////파일업로드//////////////////////////
				File dir = new File(SAVEFOLDER);
				if(!dir.exists())
					dir.mkdirs();
				
				MultipartRequest multi = 
						new MultipartRequest(req, SAVEFOLDER,MAXSIZE,ENCTYPE
								,new DefaultFileRenamePolicy());
				
				String tfilename = null;
				int tfilesize = 0;
				if(multi.getFilesystemName("tfilename")!=null) {
					//게시물에 파일 업로드
					tfilename = multi.getFilesystemName("tfilename");
					tfilesize = (int)multi.getFile("tfilename").length();
				}
				String tcontent = multi.getParameter("tcontent");//게시물 내용
				String tcontentType = multi.getParameter("tcontentType");//내용타입
				if(tcontentType.equals("TEXT")) {
					tcontent = UtilMgr.replace(tcontent, "<", "&lt;");
				}
				//답변을 위한 ref 설정
				int tref = getMaxTnum()+1;
				/////////////////////////////////////
				con = pool.getConnection();
				sql = "insert testBoard(tname,tcontent,tsubject,tref,tpos,tdepth,";
				sql += "tregdate,tpass,tcount,tip,tfilename,tfilesize)";
				sql += "values(?, ?, ?, ?, 0, 0, now(), ?, 0, ?, ?, ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("tname"));
				pstmt.setString(2, tcontent);
				pstmt.setString(3, multi.getParameter("tsubject"));
				pstmt.setInt(4, tref);
				pstmt.setString(5, multi.getParameter("tpass"));
				pstmt.setString(6, multi.getParameter("tip"));
				pstmt.setString(7, tfilename);
				pstmt.setInt(8, tfilesize);
				pstmt.executeUpdate();

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
		//Board Max Num : num의 최대값-->다시 확인
		public int getMaxTnum() {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int maxTnum = 0;
			try {
				con = pool.getConnection();
				sql = "select max(tnum) from testBoard";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) maxTnum = rs.getInt(1);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return maxTnum;
		}
	
		//Board Total Count : 총 게시물수, db1-->이게 문제인듯..?
				public int getTotalCount(String keyField, String keyWord) {
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					String sql = null;
					int totalCount = 0;
					try {
						con = pool.getConnection();
						if(keyWord.trim().equals("")||keyWord==null) {
							//검색이 아닌경우
							sql = "select count(*) from testBoard";
							pstmt = con.prepareStatement(sql);
						}else {
							//검색인 경우
							sql = "select count(*) from testBoard where " 
							+ keyField +" like ?";
							pstmt = con.prepareStatement(sql);
							pstmt.setString(1, "%"+keyWord+"%");
						}
						rs = pstmt.executeQuery();
						if(rs.next()) totalCount = rs.getInt(1);
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt, rs);
					}
					return totalCount;
				}
				
		//Board List : 검색 기능(keyField, keyWord)--->ok
		public Vector<BoardBean> getBoardList(String keyFileld, 
				String keyWord, int start, int cnt){
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				Vector<BoardBean> vlist= new Vector<BoardBean>();
				try {
					con = pool.getConnection();
					if(keyWord.trim().equals("")||keyWord==null) {
						//검색이 아닐때
						sql = "select * from testBoard order by tref desc, tpos limit ?,?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, start);
						pstmt.setInt(2, cnt);
					}else {
						//검색일때
						sql = "select * from testBoard where " + keyFileld 
								+ " like ? order by tref desc, tpos limit ?,?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, "%"+keyWord+"%");
						pstmt.setInt(2, start);
						pstmt.setInt(3, cnt);
					}
					rs = pstmt.executeQuery();
					while(rs.next()) {
					BoardBean bean = new BoardBean();
					bean.setTnum(rs.getInt("tnum"));
					bean.setTname(rs.getString("tname"));
					bean.setTsubject(rs.getString("tsubject"));
					bean.setTpos(rs.getInt("tpos"));
					bean.setTref(rs.getInt("tref"));
					bean.setTdepth(rs.getInt("tdepth"));
					bean.setTregdate(rs.getString("tregdate"));
					bean.setTcount(rs.getInt("tcount"));
					bean.setTfilename(rs.getString("tfilename"));
					vlist.addElement(bean);
				}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt, rs);
				}
				return vlist;
			}
				
		
	//Board Get : 한개의 게시물 리턴, 13개 컬럼 모두 리턴 (게시글 한개 클릭했을때 게시글 확인하는 메소드, read.jsp랑 연관)-->ok, 다시 확인하기
	public BoardBean getBoard(int tnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		BoardBean bean = new BoardBean();
		try {
			con = pool.getConnection();
			sql = "select * from testBoard where tnum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, tnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setTnum(rs.getInt("tnum"));
				bean.setTname(rs.getString("tname"));
				bean.setTsubject(rs.getString("tsubject"));
				bean.setTcontent(rs.getString("tcontent"));
				bean.setTpos(rs.getInt("tpos"));
				bean.setTref(rs.getInt("tref"));
				bean.setTdepth(rs.getInt("tdepth"));
				bean.setTregdate(rs.getString("tregdate"));
				bean.setTpass(rs.getString("tpass"));
				bean.setTip(rs.getString("tip"));
				bean.setTcount(rs.getInt("tcount"));
				bean.setTfilename(rs.getString("tfilename"));
				bean.setTfilesize(rs.getInt("tfilesize"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	//Count Up : 조회수 증가, update!!!
	public void upCount(int tnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update testBoard set tcount=tcount +1 where tnum =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, tnum);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	//Board Delete : 파일업로드 파일 삭제
	public void deleteBoard(int tnum, String tfilename) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			if(tfilename!=null&&!tfilename.equals("")) {
				File f =new File(SAVEFOLDER+tfilename);
				if(f.exists())
					UtilMgr.delete(SAVEFOLDER+tfilename);
			}
			con = pool.getConnection();
			sql = "delete from testBoard where tnum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, tnum);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;	
	}
	
	
	
	
	//Board Update : 파일 업로드 수정기능--->추가하기
	public void updateBoard(MultipartRequest multi) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			int tnum = Integer.parseInt(multi.getParameter("tnum"));
			String tname = multi.getParameter("tname");
			String tsubject = multi.getParameter("tsubject");
			String tcontent = multi.getParameter("tcontent");
			String tfilename = multi.getFilesystemName("tfilename");
			if(tfilename!=null&&!tfilename.equals("")) {
				//파일이 업로드 수정이 되면 기존에 파일은 삭제가 되어야 한다.
				BoardBean bean = getBoard(tnum);
				String tempfile = bean.getTfilename();
				if(tempfile!=null&&!tempfile.equals("")) {
					//기존에 파일 있다면
					File f = new File(SAVEFOLDER+tempfile);
					if(f.exists()) {
						UtilMgr.delete(SAVEFOLDER+tempfile);
					}
				}
				int tfilesize = (int)multi.getFile("tfilename").length();
				sql = "update testBoard set tname=?, tsubject=?, tcontent=?,"
						+ "tfilename=?, tfilesize=? where tnum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, tname);
				pstmt.setString(2, tsubject);
				pstmt.setString(3, tcontent);
				pstmt.setString(4, tfilename);
				pstmt.setInt(5, tfilesize);
				pstmt.setInt(6, tnum);
			} else {
				sql = "update testBoard set tname=?, tsubject=?, tcontent=? where tnum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, tname);
				pstmt.setString(2, tsubject);
				pstmt.setString(3, tcontent);
				pstmt.setInt(4, tnum);
			}
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}	
	
	
	//Board Reply : 답변글 입력
	
	//Board Reply Up : 답변글 위치값 조정
		public void post1000(){
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "insert testBoard(tname,tcontent,tsubject,tref,tpos,tdepth,tregdate,tpass,tcount,tip,tfilename,tfilesize)";
				sql+="values('aaa', 'bbb', 'ccc', 0, 0, 0, now(), '1111',0, '127.0.0.1', null, 0);";
				pstmt = con.prepareStatement(sql);
				for (int i = 0; i < 1000; i++) {
					pstmt.executeUpdate();
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
		
		public static void main(String[] args) {
			BoardMgr mgr = new BoardMgr();
			mgr.post1000();
		}
	
	
}