package shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map.Entry;

public class Model {
	public ArrayList<HashMap<String, Object>> listQry(Connection conn, ResultSet rs, PreparedStatement stmt, String qry, String[] qryNameArr) throws SQLException{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		stmt = conn.prepareStatement(qry);
		rs = stmt.executeQuery(); 
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			for(int i = 0; i < qryNameArr.length; i++) {
				m.put(qryNameArr[i], rs.getString(qryNameArr[i]));				
			}
			list.add(m);
		}
		return list;
	}
	public int addQry(Connection conn, ResultSet rs, PreparedStatement stmt, String qry, HashMap<Integer, Object> addMap) throws SQLException{
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
		return stmt.executeUpdate();
	}

}
