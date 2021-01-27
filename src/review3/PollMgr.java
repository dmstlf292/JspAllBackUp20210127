package review3;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;
import review3.PollItemBean;

public class PollMgr {
	private DBConnectionMgr pool;
	
	public PollMgr() {
		pool=DBConnectionMgr.getInstance();
	}
	
	//Max num(가장 최신의 투표 설문 리스트가 나타나도록!)-1
	public int getMaxNum(){//db1-select
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxNum=0;
		try {
			con = pool.getConnection();
			sql = "select max(tnum) from testPollList";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();//여긴 getMaxNum()에 아무런 값이 안들어가서 괄호안에 그대로 놔둔다.
			if(rs.next()) maxNum=rs.getInt(1);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxNum;
	}
	
	//Poll Insert (설문과 Item이 동시에 저장이 되게끔...)-1
	public boolean insertPoll (PollListBean plBean, PollItemBean piBean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "insert testPollList(tquestion,tsdate,tedate,twdate,type)"
					+ "values(?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, plBean.getTquestion());
			pstmt.setString(2, plBean.getTsdate());
			pstmt.setString(3, plBean.getTedate());
			//여기선 twdate 왜 안하지??
			pstmt.setInt(4, plBean.getType());
			int cnt = pstmt.executeUpdate();//여긴 손 대면 안된다.
			pstmt.close();
			/////////////////////////////////////////////////////
			if(cnt==1) {
				sql="insert testPollItem values(?,?,?,0)";
				pstmt = con.prepareStatement(sql);
				//for 문 돌려야한다, if 문 때문에, 여기 이부분 다시 공부하기
				int tlistNum=getMaxNum();//방금 저장된 설문 리스트 tnum 값
				String titem[]=piBean.getTitem();//item을 배열로 해야한다!!
				for (int i = 0; i < titem.length; i++) {
					if(titem[i]==null || titem[i].trim().equals(""))
						break;
					pstmt.setInt(1, tlistNum);
					pstmt.setInt(2, i);//자동증가가 아니라서..
					pstmt.setString(3,titem[i]);
					if(pstmt.executeUpdate()==1)
						flag=true;
				}
			}
		//////////////////////////////////////////////////////////
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//Poll List(설문폼)  2
	public Vector<PollListBean> getPollList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PollListBean> vlist = new Vector<PollListBean>();
		try {
			con = pool.getConnection();
			sql = "select * from testPollList order by tnum desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				PollListBean plBean = new PollListBean();
				plBean.setTnum(rs.getInt("tnum"));
				plBean.setTquestion(rs.getString("tquestion"));
				plBean.setTsdate(rs.getString("tsdate"));//DB 타입이 date이지만 String 가능
				plBean.setTedate(rs.getString("tedate"));
				vlist.addElement(plBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//Poll Read(설문폼의 설문 한개 가져오기)  2
	public PollListBean getPoll(int tnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		PollListBean plBean = new PollListBean();
		try {
			con = pool.getConnection();
			sql = "select tnum, tquestion, type, active from testPollList where tnum=?";
			pstmt = con.prepareStatement(sql);
			if(tnum==0)
				tnum=getMaxNum();
			pstmt.setInt(1, tnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				plBean.setTnum(rs.getInt(1));
				plBean.setTquestion(rs.getString(2));
				plBean.setType(rs.getInt(3));
				plBean.setActive(rs.getInt(4));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return plBean;	
	}
	
	//Poll Item List  2
	//listNum이 0이면 getMaxNum으로 세팅한다. num값이 넘어오지 않으면 가장 최신의 설문 list로 넘어가는것 
	public Vector<String> getItemList(int tlistNum){//list 배열 자체가 문자 string으로 되어 있어서!
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<String> vlist = new Vector<String>();
		try {
			con = pool.getConnection();
			sql = "select titem from testPollItem where tlistNum=?";
			pstmt = con.prepareStatement(sql);
			if(tlistNum==0) tlistNum=getMaxNum();
			pstmt.setInt(1, tlistNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vlist.addElement(rs.getString(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//Count Sum (설문 투표수(결과를 보기 위해서)->count)  !!!!!!!!!다시보기
	public int sumCount (int tlistNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int sum=0;
		try {
			con = pool.getConnection();
			sql = "select sum(count) from testPollItem where tlistNum=?";
			pstmt = con.prepareStatement(sql);
			//tlistNum 값이 0일 수 도 있다.
			if(tlistNum==0) tlistNum=getMaxNum();
			pstmt.setInt(1, tlistNum);
			rs = pstmt.executeQuery();
			if(rs.next()) sum=rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return sum;
	}

	//Poll Update (투표 실행)--3
	public boolean updatePoll(int tlistNum, String titemNum[]) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update testPollItem set count=count+1 "
					+"where tlistNum=? and titemNum=?";
			pstmt = con.prepareStatement(sql);
			//배열때문에 for문 돌리기
			if(tlistNum==0) tlistNum=getMaxNum();
			for (int i = 0; i < titemNum.length; i++) {
				pstmt.setInt(1, tlistNum);
				pstmt.setInt(2, Integer.parseInt(titemNum[i]));
				if(pstmt.executeUpdate()==1) 
					flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

	//Poll View (결과보기)--3
	public Vector<PollItemBean> getView(int tlistNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PollItemBean> vlist = new Vector<PollItemBean>();
		try {
			con = pool.getConnection();
			sql = "select titem, count from testPollItem where tlistNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, tlistNum==0?getMaxNum():tlistNum);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				PollItemBean piBean = new PollItemBean();
				String titem[]=new String[1];
				titem[0]=rs.getString("titem");
				piBean.setTitem(titem);
				piBean.setCount(rs.getInt("count"));
				vlist.addElement(piBean);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//Max Item Count : 아이템 중에서 가장 높은 투표수를 가진 값--3
	public int getMaxCount(int tlistNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxCnt=0;
		try {
			con = pool.getConnection();
			sql = "select max(count) from testPollItem where tlistNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, tlistNum==0?getMaxNum():tlistNum);
			rs = pstmt.executeQuery();
			if(rs.next()) maxCnt=rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxCnt;
	}
}