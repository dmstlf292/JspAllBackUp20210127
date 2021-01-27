package upload;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import org.apache.tomcat.util.http.fileupload.FileUploadBase;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class FileloadMgr {
	
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Jsp/myapp/WebContent/upload/storage/";
	//업로드 파일명 인코딩
	public static final String ENCODING = "EUC-KR";
	//업로드 파일 크기
	public static final int MAXSIZE = 1024*1024*10;//10MB
	
	public FileloadMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//파일 저장 db2 (파일 업로드가 먼저 되고 저장이 되어야한다.) 
	//여기 이부분 중요!!!
	public void uploadFile(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			MultipartRequest multi = 
					new MultipartRequest(req,SAVEFOLDER,MAXSIZE, ENCODING, new DefaultFileRenamePolicy());
			
			//여기 이부분에서
			//DefaultFileRenamePolicy ??
			//MultipartRequest ??
			//그리고 return안해주는 이유는?
			String upFile=multi.getFilesystemName("upFile");
			File f=multi.getFile("upFile");
			long size = f.length();
			con = pool.getConnection();
			sql = "insert tblFileload(upFile, size) values (?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, upFile);
			pstmt.setLong(2, size);//int해도 관계는 없다.
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
		
	}
	
	//파일리스트
	public Vector<FileloadBean> listFile(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<FileloadBean> vlist = new Vector<FileloadBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblFileload";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				FileloadBean bean = new FileloadBean();
				bean.setNum(rs.getInt(1));
				bean.setUpFile(rs.getString(2));
				bean.setSize(rs.getInt(3));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
		
	//파일삭제(파일삭제는 여러개를 동시에 삭제, 여러개라서 배열을 쓴다!!) db2 이용
	public void deleteFile(int num[]) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			//for문 이용
			for (int i = 0; i < num.length; i++) {
				//num에 맞는 파일명을 가져온다.
				String upFile=getFile(num[i]);
				//table에 있는 값만 삭제가 아니라 실제 파일도 같이 삭제를 해야한다.
				File f=new File(SAVEFOLDER+upFile);
				if(f.exists()) //파일이 존재한다면
					f.delete();//파일을 삭제해라!!!
				sql = "delete from tblFileload where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num[i]);
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	//파일 가져오기(download)
	public String getFile(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String upFile=null;
		try {
			con = pool.getConnection();
			sql = "select upFile from tblFileload where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) upFile=rs.getString(1);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return upFile;
	}
	
}
