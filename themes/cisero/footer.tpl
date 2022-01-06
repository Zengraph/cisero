  <footer id="footer" class="p-5 bg-black">
    {if isset($HOOK_FOOTER)}
      <div class="container">
        <div class="row">{$HOOK_FOOTER}</div>
      </div>
    {/if}

    {if !empty($ctheme.footer.copyright.display)}
      <div id="copyright-footer" role="contentinfo" class="container mt-5">
        {$ctheme.footer.copyright.html}
      </div>
    {/if}
  </footer>
