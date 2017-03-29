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
        	//alert(node.data()[0].item.text);
        	$.ajax({
				type : "POST",
				url : "do_search.hi",
				dataType : "html", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
				data : {
					"search_word" : node.data()[0].item.text,
				},
				success : function(data) {
					// 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.
					var searchList = $.parseJSON(searchList);
					alert("성공  !! TOT_CNT: " +searchList.get(0).get("TOT_CNT"));

				},
				complete : function(data) {
					// 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
					// TODO
				},
				error : function(xhr, status, error) {
					alert("에러발생");
				}
			});
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