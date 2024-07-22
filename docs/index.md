# 首页



<div id="rcorners2" >

<div id="rcorners1" class="date-display">
    <p class="p1"></p>
</div>

<style>
    .date-display {
        color: #4351AF;
    }
</style>
<script defer>
    function format(newDate) {
        const day = newDate.getDay();
        const y = newDate.getFullYear();
        const m = newDate.getMonth() + 1 < 10 ? `0${newDate.getMonth() + 1}` : newDate.getMonth() + 1;
        const d = newDate.getDate() < 10 ? `0${newDate.getDate()}` : newDate.getDate();
        const h = newDate.getHours() < 10 ? `0${newDate.getHours()}` : newDate.getHours();
        const min = newDate.getMinutes() < 10 ? `0${newDate.getMinutes()}` : newDate.getMinutes();
        const s = newDate.getSeconds() < 10 ? `0${newDate.getSeconds()}` : newDate.getSeconds();
        const dict = {1: "一", 2: "二", 3: "三", 4: "四", 5: "五", 6: "六", 0: "天"};
        
        return `${y}年${m}月${d}日 ${h}:${min}:${s} 星期${dict[day]}`;
    }

    const timerId = setInterval(() => {
        const newDate = new Date();
        const p1 = document.querySelector(".p1");
        if (p1) {
            p1.textContent = format(newDate);
        }
    }, 1000);
</script>

  <ul>
    <li>这是我的文档的首页。请随意探索并找到您所需的信息。</li>
    <li>通过主题和目录以打开文章</li>
    <ul>
      <li>Mac/PC端 请在上方标签栏选择主题 在左侧目录选择文章</li>
      <li>移动端 请点击左上角图标选择主题和文章</li>
    </ul>
    <li>请搜索关键词以打开文章</li>
    <li>
      如遇到网页卡顿/打开文章后无法显示图片的情况，请使用科学上网
    </li>
  </ul>
</div> 