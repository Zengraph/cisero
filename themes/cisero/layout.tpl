{assign var='left_column_size' value=0}{assign var='right_column_size' value=0}
{if isset($HOOK_LEFT_COLUMN) && $HOOK_LEFT_COLUMN|trim && !$hide_left_column}{$left_column_size=3}{/if}
{if isset($HOOK_RIGHT_COLUMN) && $HOOK_RIGHT_COLUMN|trim && !$hide_right_column}{$right_column_size=3}{/if}
{if !empty($display_header)}{include file="$tpl_dir./header.tpl" HOOK_HEADER=$HOOK_HEADER}{/if}
{if !empty($template)}{$template}{/if}
{if !isset($content_only) || !$content_only}
	</main>{* #center_column *}
    {if isset($right_column_size) && !empty($right_column_size)}
      <aside id="right_column" class="col-xs-12 col-lg-{$right_column_size|intval}" role="navigation complementary">{$HOOK_RIGHT_COLUMN}</aside>
    {/if}
    </div>{* .row *}
  </div>{* #columns*}
  {if !empty($display_footer)}{include file="$tpl_dir./footer.tpl"}{/if}
{/if}
  </main>
{include file="$tpl_dir./global.tpl"}
</body>
</html>
