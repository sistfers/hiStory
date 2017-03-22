package com.mybatis.dao;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.log4j.Logger;

import com.mybatis.dto.CodeD;
import com.mybatis.dto.CodeM;



public class CodeMDao {
	private final String namespace
	="com.mybatis.dao.CodeMapper";
	
	//Mybatis Connection처리
    private SqlSessionFactory getSqlSessionFactory() {
    	String resource = "mybatis-config.xml";
    	InputStream inputStream;
    	try{
    		inputStream = Resources.getResourceAsStream(resource);
    	}catch(IOException e){
    		throw new IllegalArgumentException(e);
    	}
    	return new SqlSessionFactoryBuilder().build(inputStream);
    }
    
    static Logger logger = Logger.getLogger(CodeMDao.class);
    //단건 조회
    public CodeM selectCode(int cdId)
    {
		SqlSession session = this.getSqlSessionFactory().openSession();	
		logger.debug("session : "+session.toString());
		try {
			String statement = this.namespace+".selectCode";
			logger.debug("statement : "+statement);
			return (CodeM)session.selectOne(statement, cdId);
		} finally {
			session.close();
		}
    }

    //목록 조회
    public List<HashMap<String, Object>> selectCodeList(Map<String, Object> condition)
    {
		SqlSession session = this.getSqlSessionFactory().openSession();
		try {
			String statement = this.namespace+".selectCodeList";
			logger.debug("statement : "+statement);
			logger.debug("condition : "+condition.toString());
			return session.selectList(statement, condition);
		} finally {
			session.close();
		}    	
    }    
    
//    //목록 조회
//    public List<CodeM> selectCodeList(Map<String, Object> condition)
//    {
//		SqlSession session = this.getSqlSessionFactory().openSession();
//		try {
//			String statement = this.namespace+".selectCodeList";
//			logger.debug("statement : "+statement);
//			logger.debug("condition : "+condition.toString());
//			return session.selectList(statement, condition);
//		} finally {
//			session.close();
//		}    	
//    }
    
    //코드조회
    public List<CodeD> selectCodes(Map<String, Object> condition)
    {
		SqlSession session = this.getSqlSessionFactory().openSession();
		try {
			String statement = this.namespace+".selectCodes";
			logger.debug("statement : "+statement);
			logger.debug("condition : "+condition.toString());
			return session.selectList(statement, condition);
		} finally {
			session.close();
		}      	
    }

    //등록수정
    public int upsertCode(CodeM codeM )
    {
    	SqlSession session = this.getSqlSessionFactory().openSession();
    	int flag =0;
    	try {
			String statement = this.namespace+".upsertCode";
			logger.debug("statement : "+statement);
			logger.debug("condition : "+codeM.toString());
			flag  = session.update(statement, codeM);
			if(flag>0)session.commit();
			else session.rollback();
			
		} finally {
			session.close();
		}   
    	return flag;
    }

    
    
}
