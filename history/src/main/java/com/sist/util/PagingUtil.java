package com.sist.util;

public class PagingUtil {
	public static String renderPaging(  int     maxNum_i, int     currPageNoIn_i, int     rowsPerPage_i,int     bottomCount_i,String  url_i,String  scriptName_i      ) 
	{
	    int maxNum=0 ;      	//�� ����
	    int currPageNo=1;   	//���� ������ ��ȣ  : page_num
	    int rowPerPage=10;   	//���������� ������ ��� : page_size
	    int bottomCount=10; 	//�ٴڿ� ������ ������ ��: 10
	     
	    maxNum=maxNum_i ;  
	    currPageNo=currPageNoIn_i;   
	    rowPerPage=rowsPerPage_i;    
	    bottomCount=bottomCount_i;  
	    
	    String url=url_i;           					//ȣ�� URL
	    String scriptName=scriptName_i;		//ȣ�� �ڹٽ�ũ��Ʈ
	    
	    int maxPageNo   =( (maxNum-1) / rowPerPage ) +1;
	    int startPageNo   =( (currPageNo-1)/bottomCount ) * bottomCount +1;//
	    int endPageNo    =( (currPageNo-1)/bottomCount +1 )*bottomCount;
	    int nowBlockNo   =( (currPageNo-1)/bottomCount) + 1;
	    int maxBlockNo   =( (maxNum -1)/bottomCount ) +1;
	    
	    int inx                = 0;
	    StringBuilder html =new StringBuilder();
	    if( currPageNo > maxPageNo)
	    { 
	        return "";
	    }
	   
	    html.append("<table border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">   \n");
	    html.append("   <tr>                                                                                                                                \n");
	    html.append("       <td class=\"list_num\">                                                                                                \n");   
		    // <<
		    if(nowBlockNo > 1 &&  nowBlockNo<= maxBlockNo)
		    {
		        html.append("       <a href=\"javascript:" + scriptName + "( '" + url + "', 1 );\">                                       \n");
		        html.append("           <<        \n");
		        html.append("       </a>                                                                                                                    \n");  
		    }
		    
		    // <
		    if(startPageNo > bottomCount)
		    {
		        html.append("       <a href=\"javascript:" + scriptName + "( '" + url + "'," + (startPageNo-1) + ");\">              \n");
		        html.append("           <                                                                                                                       \n");
		        html.append("       </a>&nbsp;                                                                                                              \n");
		    }
	    
		    // 1 2 3 ... 10
		    for(inx = startPageNo; inx<=maxPageNo && inx<=endPageNo;inx++)
		    {
		        if( inx == currPageNo ) 
		        {
		            html.append("   <b>" + inx + "</b>&nbsp;&nbsp;                                                                                   \n");
		        }
		        else 
		        {
		            html.append("   <a href=\"javascript:" + scriptName + "('" + url + "'," + inx + ");\" class=\"num_text\">" + inx + "</a>&nbsp;&nbsp;    \n");
		        }
		    }
	    
	    	//>
			if(maxPageNo >= inx)
			{
			      html.append("       <a href=\"javascript:" + scriptName + "('" + url + "'," + ((nowBlockNo*bottomCount)+1) + ");\">                         \n");
			      html.append("           >                       \n");
			      html.append("       </a>                                                                                                                    \n");                       
			}
	    
			//>>
		  if ( maxPageNo >= inx ) 
		  {
			html.append("       <a href=\"javascript:" + scriptName + "('" + url + "'," + maxPageNo + ");\">                                            \n");
			html.append("           >>        \n");
			html.append("       </a>                                                                                                                    \n");
		  } 
		  
	    html.append("       </td>                                                                                                                       \n");        
	    html.append("   </tr>                                                                                                                           \n");
	    html.append("</table>                                                                                                                           \n");

	    return html.toString();     
	}
}
