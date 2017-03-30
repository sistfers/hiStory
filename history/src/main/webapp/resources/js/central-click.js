/**
 * central-click.js
 */
d3.svg.BubbleChart.define("central-click", function (options) {
  var self = this;

  self.setup = (function (node) {
    var original = self.setup;
    return function (node) {
      var fn = original.apply(this, arguments);
      self.event.on("click", function(node) {
        if (node.selectAll("text.central-click")[0].length === 1) {
        	//alert(node.data()[0].item.text); 제일 큰 동그라미 검색어 들고오는 것
        	var frm = document.do_search;
    		frm.search_word.value = node.data()[0].item.text;
    		console.log("frm.page_num.value=" + frm.search_word.value);
    		frm.action = "/main/do_search.hi";
    		frm.submit();
        	/*$.ajax({	아작스로 리스트 받아올 때 사용
				type : "POST",
				url : "/main/do_search.hi",
				dataType : "html", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
				data : {
					"search_word" : node.data()[0].item.text,
				},
				success : function(data) {
					// 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.
					console.log(data);
					var searchList = $.parseJSON(data);
					for (var i = 0; i < searchList.length; i++) {
					    var counter = searchList[i];
					    console.log(counter.WDATE);
					}
//					alert("성공  !! TOT_CNT: " + aaa);

				},
				complete : function(data) {
					// 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
					// TODO
				},
				error : function(xhr, status, error) {
					alert("에러발생");
				}
			});*/
        }
      });
      return fn;
    };
  })();

  self.reset = (function (node) {
    var original = self.reset;
    return function (node) {
      var fn = original.apply(this, arguments);
      node.select("text.central-click").remove();
      return fn;
    };
  })();

  self.moveToCentral = (function (node) {
    var original = self.moveToCentral;
    return function (node) {
      var fn = original.apply(this, arguments);
      var transition = self.getTransition().centralNode;
      transition.each("end", function() {
        node.append("text").classed({"central-click": true})
          .attr(options.attr)
          .style(options.style)
          .attr("x", function (d) {return d.cx;})
          .attr("y", function (d) {return d.cy;})
          .text(options.text)
          .style("opacity", 0).transition().duration(self.getOptions().transitDuration / 2).style("opacity", "0.8");
      });
      return fn;
    };
  })();
});