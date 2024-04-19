package shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map.Entry;

public class Model {
	Common common = new Common();
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null; 
	
	public ArrayList<HashMap<String, Object>> listQry(String qry, String[] qryNameArr, HashMap<Integer, Object> qryParamMap) throws SQLException, Exception{
		conn = common.DBConnection();
		stmt = conn.prepareStatement(qry);
		int index = 1;
		for(Entry<Integer, Object> e : qryParamMap.entrySet()){
			if(e.getValue() instanceof String) {
				stmt.setString(index, (String) e.getValue());
			}else {
				stmt.setInt(index, (Integer) e.getValue());				
			}
			index = index + 1;
		}
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		rs = stmt.executeQuery(); 
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			for(int i = 0; i < qryNameArr.length; i++) {
				m.put(qryNameArr[i], rs.getString(qryNameArr[i]));				
			}
			list.add(m);
		}
		System.out.println("list : " + list);
		return list;
	}
	
	public HashMap<String, Object> listOneQry(String qry, String[] qryNameArr, HashMap<Integer, Object> qryParamMap) throws Exception{
		conn = common.DBConnection();
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		stmt = conn.prepareStatement(qry);
		int index = 1;
		for(Entry<Integer, Object> e : qryParamMap.entrySet()){
			if(e.getValue() instanceof String) {
				stmt.setString(index, (String) e.getValue());
			}else {
				stmt.setInt(index, (Integer) e.getValue());				
			}
			index = index + 1;
		}
		rs = stmt.executeQuery(); 
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			for(int i = 0; i < qryNameArr.length; i++) {
				m.put(qryNameArr[i], rs.getString(qryNameArr[i]));				
			}
			list.add(m);
		}
		rs.close();
		stmt.close();
		conn.close();
		try {
		    Object item = list.get(0);
		} catch (IndexOutOfBoundsException e) {
			return null;
		}
		return list.get(0);
	}
	public int addQry(String qry, HashMap<Integer, Object> addMap) throws SQLException, Exception{
		conn = common.DBConnection();
		stmt = conn.prepareStatement(qry);
		int index = 1;
		for(Entry<Integer, Object> e : addMap.entrySet()){
			if(e.getValue() instanceof String) {
				stmt.setString(index, (String) e.getValue());
			}else {
				stmt.setInt(index, (Integer) e.getValue());				
			}
			index = index + 1;
		}
		int result =  stmt.executeUpdate();
		stmt.close();
		conn.close();
		return result;
	}
	
	public int updateQry(String qry, HashMap<Integer, Object> qryParamMap) throws Exception{
		conn = common.DBConnection();
		stmt = conn.prepareStatement(qry);
		int index = 1;
		for(Entry<Integer, Object> e : qryParamMap.entrySet()){
			if(e.getValue() instanceof String) {
				stmt.setString(index, (String) e.getValue());
			}else {
				stmt.setInt(index, (Integer) e.getValue());				
			}
			index = index + 1;
		}
		return stmt.executeUpdate();
	}
	public int deleteQry(String qry, String no) throws Exception{
		conn = common.DBConnection();
		stmt = conn.prepareStatement(qry);
		stmt.setString(1, no);
		return stmt.executeUpdate();
	}
}
