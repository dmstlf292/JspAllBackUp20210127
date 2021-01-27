package shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class OrderMgr {
	
	private DBConnectionMgr pool;
	
	public OrderMgr() {
		pool = DBConnectionMgr.getInstance();
	}	
	
	//Order Insert : 주문
	public void insertOrder(OrderBean order) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert tblOrder(id,productNo,quantity,date,state)"
					+ "values(?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, order.getId()); //주문 id
			pstmt.setInt(2, order.getProductNo()); // 주문상품번호
			pstmt.setInt(3, order.getQuantity()); // 주문 수량
			pstmt.setString(4, UtilMgr.getDay());
			//접수중(1), 접수(2), 입금확인(3), 배송준비(4), 배송중(5), 완료(6)
			pstmt.setString(5, "1");
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	//Order List : 주문 리스트
	public Vector<OrderBean> getOrderList(String id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<OrderBean> vlist = new Vector<OrderBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblOrder where id=? order by no desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrderBean order = new OrderBean();
				order.setNo(rs.getInt("no"));//주문번호
				order.setId(rs.getString("id"));//주문한 사람
				order.setProductNo(rs.getInt("productNo"));//주문상품번호
				order.setQuantity(rs.getInt("quantity"));//주문수량
				order.setDate(rs.getString("date"));//주문날짜
				order.setState(rs.getString("state"));//주문상태
				vlist.addElement(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//admin mode//
	
	//Order All List : 모든 고객의 주문 리스트
	public Vector<OrderBean> getOrderList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<OrderBean> vlist = new Vector<OrderBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblOrder order by no desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrderBean order = new OrderBean();
				order.setNo(rs.getInt("no"));// 주문번호
				order.setId(rs.getString("id"));// 주문id
				order.setProductNo(rs.getInt("productNo"));// 주문상품번호
				order.setQuantity(rs.getInt("quantity"));// 주문수량
				order.setDate(rs.getString("date"));// 주문날짜
				order.setState(rs.getString("state"));// 주문상태
				vlist.addElement(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//Order Detail : 주문 상세 정보
	public OrderBean getOrderDetail(int no/*주문번호*/) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		OrderBean order = new OrderBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblOrder where no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				order.setNo(rs.getInt("no"));// 주문번호
				order.setId(rs.getString("id"));// 주id
				order.setQuantity(rs.getInt("quantity"));// 주문수량
				order.setDate(rs.getString("date"));// 주문날짜
				order.setState(rs.getString("state"));// 주문상태
				order.setProductNo(rs.getInt("productNo"));// 주문상품
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return order;
	}
	
	//Order Update : 주문 상태 수정
	//접수중(1), 접수(2), 입금확인(3), 배송준비(4), 배송중(5), 완료(6)
	public boolean updateOrder(int no/*주문번호*/, String state/*주문상태*/){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tblOrder set state=? where no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, state);
			pstmt.setInt(2, no);
			if(pstmt.executeUpdate()==1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//Order Delete : 주문 삭제
	public boolean deleteOrder(int no){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from tblOrder where no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			if(pstmt.executeUpdate()==1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	
}
