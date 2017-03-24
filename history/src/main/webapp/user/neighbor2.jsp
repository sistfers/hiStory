<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<style type="text/css">
*:focus {
  outline: 0;
}
*, *:before, *:after {
  box-sizing: border-box;
}

::-webkit-input-placeholder {
  font-family: 'Podkova', serif;
}
:-moz-placeholder {
  font-family: 'Podkova', serif;
}
::-moz-placeholder {
  font-family: 'Podkova', serif;
}
:-ms-input-placeholder {
  font-family: 'Podkova', serif;
}

html, html body {
  position: absolute;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
  width: 100vw;
  height: 100vh;
  overflow: auto;
}

#aside {
  position: absolute;
  position: fixed;
  z-index: 100;
  right: 0;
  width: 10%;
  min-width: 15em;
  height: 50%;
  top: 0;
  bottom: 0;
  margin: 0;
  margin-top: 20%;
  min-height:25em;
  border-radius: .5em;
  pointer-events: none;
  -webkit-transition: all 0.45s ease-in;
  transition: all 0.45s ease-in;
  -webkit-transform: translateX(calc(100% - .75em));
          transform: translateX(calc(100% - .75em));
}

#buyaside {
  position: absolute;
  position: fixed;
  z-index: 0;
  right: 0;
  width: 10%;
  min-width: 15em;
  height: 50%;
  top: 0;
  bottom: 0;
  margin: 0;
  margin-top: 32%;
  min-height:25em;
  border-radius: .5em;
  pointer-events: none;
  -webkit-transition: all 0.45s ease-in;
  transition: all 0.45s ease-in;
}

#art {
  position: relative;
  width: 100%;
  height: 100%;
}
/*박스 색상 */
#art .box {
  overflow: hidden;
  position: relative;
  width: 100%;
  height: 100%;
  background-color: #333333;
}
#art .box .content {
  overflow-y: auto;
  padding: 1em;
  margin-left: 2em;
  height: 100%;
}
#art .spacer {
  position: absolute;
  left: -2em;
  top: 45%;
  width: 4em;
  height: 4em;
  z-index: -1;
  border-radius: 100%;
  mix-blend-mode: darken;
  box-shadow: 0 0 0 0 rgba(17, 141, 240, 0.5), 0 0 0 0 #fff;
  -webkit-transition: all 0.6s ease-out;
  transition: all 0.6s ease-out;
}
#art .spacer:after {
  display: inline-block;
}
#art .opener {
  position: absolute;
  position: absolute;
  left: -.75em;
  top: calc(45% + .25em);
  font-size: 2em;
  width: 1.5em;
  height: 1.5em;
  display: inline-block;
  line-height: 1.4;
  pointer-events: all;
  background-color: black;
  background-position: center center;
  background-blend-mode: overlay;
  background-size: 100% 100%;
  text-align: center;
  vertical-align: middle;
  border-radius: 100%;
  -webkit-transition: all 0.3s ease-in-out;
  transition: all 0.3s ease-in-out;
}
#art .opener:hover {
  box-shadow: 0.1em 0 0 rgba(0, 0, 0, 0.2);
  -webkit-transform: translateX(-25%);
          transform: translateX(-25%);
  -webkit-transition: all 0.3s ease-in-out;
  transition: all 0.3s ease-in-out;
}
#art .opener:focus {
  -webkit-transform: scale(0.9);
          transform: scale(0.9);
  -webkit-transition: all 0.3s ease-in-out;
  transition: all 0.3s ease-in-out;
}
/* 여기색상이 < 이거색상 */
#art .opener:before, #art .opener:after {
  content: '';
  position: absolute;
  background-color: #fff;
  width: .2em;
  height: .656em;
  left: .6em;
  -webkit-transition: all 0.3s;
  transition: all 0.3s;
}
#art .opener:before {
  -webkit-transform: rotate(45deg);
          transform: rotate(45deg);
  top: .25em;
}
#art .opener:after {
  -webkit-transform: rotate(-45deg);
          transform: rotate(-45deg);
  bottom: .25em;
}

#toggle {
  display: inline;
  width: 0;
  height: 0;
  -webkit-appearance: none;
  -moz-appearance: none;
}

#toggle:after {
  content: '';
  display: block;
  position: fixed;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
  opacity: 0;
  border-radius: 100%;
  pointer-events: none;
  z-index: -1;
  -webkit-transform: translateX(95%);
          transform: translateX(95%);
  box-shadow: inset 0 0 0 0 transparent;
  -webkit-transition: all 0.6s ease-out;
  transition: all 0.6s ease-out;
}
#toggle:checked:after {
  opacity: 1;
  z-index: 99;
  border-radius: 0%;
  pointer-events: all;
  -webkit-transform: translateX(0%);
          transform: translateX(0%);
  -webkit-transition: all 0.9s ease-in;
  transition: all 0.9s ease-in;
  box-shadow: inset 10em 0 0em 150em rgba(0, 0, 0, 0.5);
} 
#toggle:checked + #aside {
  pointer-events: all;
  -webkit-transform: translateY(0%);
          transform: translateY(0%);
  -webkit-transition: all 0.6s ease-in 0.3s;
  transition: all 0.6s ease-in 0.3s;
}
#toggle:checked + #aside .spacer {
  box-shadow: 0 0 0 100em rgba(17, 141, 240, 0.95), 0 0 0 40em #fff;
  -webkit-transition: all 1.2s ease-in;
  transition: all 1.2s ease-in;
}
#toggle:checked + #aside .opener {
  background-color: black;
  -webkit-transition: all 0.3s ease-in-out 0.3s;
  transition: all 0.3s ease-in-out 0.3s;
}
#toggle:checked + #aside .opener:hover {
  box-shadow: 0 0 0 0.5em rgba(0, 0, 0, 0.2);
  -webkit-transform: rotate(360deg) scale(0.8);
          transform: rotate(360deg) scale(0.8);
  -webkit-transition: all 0.3s ease-in-out 0.3s;
  transition: all 0.3s ease-in-out 0.3s;
}
#toggle:checked + #aside .opener:before, #toggle:checked + #aside .opener:after {
  -webkit-transition: all 0.6s 0.3s;
  transition: all 0.6s 0.3s;
}
#toggle:checked + #aside .opener:before {
  -webkit-transform: rotate(-45deg) translate(-40%, 25%);
          transform: rotate(-45deg) translate(-40%, 25%);
}
#toggle:checked + #aside .opener:after {
  -webkit-transform: rotate(45deg) translate(-40%, -25%);
          transform: rotate(45deg) translate(-40%, -25%);
}


#nav ul {
  display: block;
  margin: 1em 0;
}
#nav ul li {
  line-height: 1.6;
}
/*목록 글자색*/
#nav ul li a {
  display: inline-block;
  height: 100%;
  line-height: 1.3;
  color: white;
  padding: .5em;
  margin-left: -.5em;
  text-transform: capitalize;
}
#nav ul li a:before {
  display: inline-block;
  margin-right: .5em;
  width: 1em;
}
/*목록 마우스 오버 색 */
#nav ul li a:hover {
  background-color: rgba(0, 0, 0, 0.2);
  border-radius: .5em;
}

p {
  margin-bottom: 1.5em;
}

h1 {
  font-size: 1.5em;
  margin-bottom: .5em;
}

b {
  font-weight: bold;
}

i {
  font-style: italic;
}

a {
  color: #118DF0;
  text-decoration: none;
}
a:hover {
  text-decoration: underline;
}

small {
  font-size: .9em;
  color: rgba(0, 0, 0, 0.7);
}

</style>
</head>
<body>


<!-- 앞에 튀어나와있는 < 이부분  -->
<input type="checkbox" name="toggle" id="toggle" />
<aside id="aside">
      <article id="art">
            <div class="box">
                  <span class="spacer"></span>
                  <div class="content">
                        <nav id="nav">
                              <ul>
                                    <li><a href="#" class="fa fa-home">home</a></li>
                                    <li><a href="#" class="fa fa-amazon">products</a></li>
                                    <li><a href="#" class="fa fa-male">men</a></li>
                                    <li><a href="#" class="fa fa-female">women</a></li>
                                    <li><a href="#" class="fa fa-child">kids</a></li>
                                    <li><a href="#" class="fa fa-umbrella">accessoires</a></li>
                                    <li><a href="#" class="fa fa-map-o">terms & conditions</a></li>
                                    <li><a href="#" class="fa fa-registered">imprint</a></li>
                              </ul>
                        </nav>
                        
                     
                  </div>
            </div>
            <!-- 앞에 <이거부분 -->
            <label class="opener" for="toggle" title="Toggle aside menu…"></label>
      </article>
</aside>
<aside id="buyaside" class="buyaside">
   <img alt="" src="77.png">
</aside>

<!-- 이부분은 그냥 본문 -->
<main id="main">
      <section>
            <header>
                  <h2>Aside Menu Concept w/ punched-out toggle</h2>
            </header>
            <article>
                  <p>
                        <span class="desc">A concept for a side menu with transparent half-rounded punched-out button. Also I added a natural feeling to it via several transitions (eg. <i>box-shadow</i> for the chopped background, <i>translate</i> and <i>scale</i> <i>transforms</i> for the button and the menu slide). Also there is <b>no use</b> of any <i>javascript</i> to keep it compatible, a nice performance and reduction of overhead and flexibility. <small>(…and as a challenge for me)</small><br>I hope you enjoy it a lot and <a href="http://codepen.io/iGadget">like my profile or follow me</a></span>
                        <span>Culpa, aperiam illum harum molestias. Accusamus, aliquam, eaque! Dignissimos numquam, aliquid. Omnis eius exercitationem doloremque facilis debitis modi, beatae, fuga alias velit vitae blanditiis unde ex! Veniam totam illum ipsam, quos tenetur officiis vel ducimus architecto blanditiis ad qui a eaque nesciunt neque exercitationem, possimus, nisi beatae, maiores recusandae deserunt iste nam quisquam nihil. Eius magnam nemo quod cumque sit dicta reprehenderit itaque inventore harum aliquid ab iusto, minima dolorum dolor expedita earum, omnis est debitis illo laborum. Vitae, minus non minima accusamus eaque, libero rerum neque quo, obcaecati ducimus adipisci fugit ut doloremque sunt magnam cumque soluta at molestias commodi ea. Libero nihil at aut. Voluptatibus libero, earum quae in assumenda vitae quo impedit consequatur iusto blanditiis culpa, aliquam? A velit dolorem totam tempore sequi commodi enim doloribus, ex sapiente perferendis eveniet officiis. Dolores vel hic, corrupti similique ut delectus quae laboriosam molestias molestiae nam architecto qui deserunt excepturi!</span>
                        <span>Autem enim, illum cupiditate nostrum doloremque, odio quia provident maxime. Labore iusto repellendus aut eius, reprehenderit numquam veniam earum nostrum sint laborum, itaque odio voluptate voluptatibus, perferendis cum explicabo voluptatem quisquam laboriosam. Aperiam vel amet necessitatibus dolor excepturi nihil tempore possimus perspiciatis labore, soluta ullam harum, ex itaque porro magni veritatis repellat. Rerum autem nobis quo beatae animi eveniet, at, amet accusantium, aspernatur quia sint repudiandae, asperiores illo. Corporis iusto minima, debitis maxime! Nam quidem, nesciunt autem delectus accusamus odio earum accusantium doloribus quisquam consectetur minus ut ex id nulla incidunt, necessitatibus nemo nobis sunt? Ipsam earum provident eligendi ipsum deserunt nostrum ex, quasi aspernatur, dolores iusto, fugiat magni culpa mollitia atque! Doloribus modi, voluptates enim possimus provident impedit aspernatur, qui repudiandae aliquam assumenda. Iure facere dolorem neque odio omnis quia provident voluptas dolorum cupiditate architecto blanditiis placeat mollitia obcaecati quod pariatur repudiandae vero accusantium sint facilis, consequuntur! Possimus, in.</span>
                        <span>Quaerat reiciendis, eius quibusdam dolore culpa, maxime recusandae dolorem unde enim ab dolorum, explicabo. Quod dolor eveniet laudantium cum, explicabo dolorem vitae magni consequuntur enim modi blanditiis, ex et officiis quibusdam! Voluptates non consectetur, at reprehenderit et est eum blanditiis rem, asperiores iusto nobis porro ex in aperiam! Doloremque perferendis ipsa tenetur deserunt sint excepturi, consectetur pariatur quibusdam accusamus vel reprehenderit dolore at ducimus, molestias reiciendis, eaque sit ut alias. Neque sed, sequi expedita illum, magnam odit accusantium recusandae in, omnis libero incidunt minima exercitationem necessitatibus unde est dicta consectetur quidem architecto. Commodi, quas aliquid facere ea doloribus qui error accusamus. Ad quam tenetur, necessitatibus repudiandae. Voluptates debitis veniam optio nihil laboriosam qui aspernatur voluptatum odit ipsa. Voluptates nobis quidem at culpa corrupti unde impedit officia temporibus fugit expedita distinctio tenetur sunt facilis quibusdam, perspiciatis laudantium. Temporibus non, delectus laboriosam ipsa veritatis ipsum perspiciatis ut nisi amet est maxime, accusamus.</span>
                        <span>Temporibus rem voluptatum aperiam quisquam aut architecto id delectus fugiat maxime, minima doloremque voluptate quae aliquid unde cupiditate magnam laudantium autem ex alias totam quia. Cumque sunt expedita repellat cupiditate labore nisi sed ea omnis similique voluptas doloremque, consequatur sequi, quibusdam, officiis neque ab explicabo modi optio voluptatem vero dolore. Porro quos laborum nam explicabo sequi repudiandae, nobis eveniet dignissimos sit harum dicta ex, praesentium quisquam error quaerat. Dolores fugiat quam doloribus quas, aut molestias cumque iste nobis numquam quibusdam! Maiores odit consequatur dolore quae rem repellat corporis optio esse similique at quibusdam, cupiditate, deserunt magnam. Labore ad, ullam voluptas aut. Nisi maxime tempora blanditiis distinctio corrupti! Fuga tenetur sequi deserunt illum quos dolores facilis obcaecati sunt dolorem reiciendis, corporis accusamus, blanditiis quibusdam harum? Alias tempora molestias eveniet, libero! Repudiandae error voluptas assumenda omnis ipsam deserunt iusto, tenetur ab repellendus deleniti beatae alias molestias aliquid modi, officiis, fuga. Iusto, modi.</span>
                        <span>Dolorum ratione quidem impedit saepe quas soluta quos ipsam nam in cumque animi laboriosam, sit accusamus omnis minus, aliquid provident maxime incidunt pariatur adipisci iste labore! Aperiam veritatis quas dolore, doloremque ut! Nemo eaque temporibus eius eligendi reiciendis, ut voluptatibus aliquam fugiat laudantium accusantium, placeat aperiam eum ipsum eos ad earum delectus cum expedita rem alias magnam! Consectetur voluptate natus eligendi quis voluptatibus molestias quia asperiores unde inventore perferendis voluptas blanditiis, ipsa nesciunt numquam iure necessitatibus qui, doloremque odit! Consectetur sed totam dignissimos, pariatur eos accusantium. Sequi earum fugiat, quia. Blanditiis corporis quos quaerat, laborum fuga ducimus labore placeat quisquam consequuntur vero magnam autem, eligendi ut nihil aut a saepe consequatur inventore praesentium sint cum repellendus ex iste dolorum nostrum. Iure provident laudantium delectus, voluptates expedita pariatur, commodi tempora, architecto unde dicta porro odit blanditiis? Dolores impedit ipsum optio cum voluptas neque voluptatibus. Saepe voluptatem nisi, aliquam, debitis similique quas.</span>
                  </p>
            </article>
      </section>
</main>

<script type="text/javascript">
$(document).ready(function() {

   $("#toggle").click(function(){
   if($("#toggle").prop("checked")) {
   
      $("#buyaside").css('margin-top','45%');
   
   }else{
      
         $("#buyaside").css('margin-top','32%');
   
   }
   });
   
});

</script>
</body>
</html>