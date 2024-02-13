<script>
  import { Block } from "@urbaninstitute/dataviz-components";
  /** @type string */
  export let chartId;
  /** @type string */
  export let title;
  /** @type string */
  export let label;
  /** @type {"iframe" | "webcomponent"} */
  export let embedStyle = "iframe";
</script>

<Block>
  <div class="chart-wrapper">
    <iframe
      {title}
      aria-label={label}
      id="datawrapper-chart-{chartId}"
      src="https://datawrapper.dwcdn.net/{chartId}/1/"
      scrolling="no"
      frameborder="0"
      style="width: 0; min-width: 100% !important; border: none;"
      height="400"
      data-external="1"
    /><script type="text/javascript">
      !(function () {
        "use strict";
        window.addEventListener("message", function (a) {
          if (void 0 !== a.data["datawrapper-height"]) {
            var e = document.querySelectorAll("iframe");
            for (var t in a.data["datawrapper-height"])
              for (var r = 0; r < e.length; r++)
                if (e[r].contentWindow === a.source) {
                  var i = a.data["datawrapper-height"][t] + "px";
                  e[r].style.height = i;
                }
          }
        });
      })();
    </script>
  </div>
</Block>

<style>
  .chart-wrapper {
    width: 100%;
    min-height: 400px;
    margin-bottom: var(--spacing-8);
  }
</style>
