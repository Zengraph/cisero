<div class="col blockcategories_footer">
	<h4 class="title_block">{l s='Categories' mod='blockcategories'}</h4>
	<div class="category_footer" style="float:left;clear:none;width:{$widthColumn}%">
		<div style="float:left" class="list">
			<ul class="list-unstyled tree {if $isDhtml}dhtml{/if}">

			{foreach from=$blockCategTree.children item=child name=blockCategTree}
				{if $smarty.foreach.blockCategTree.last}
					{include file="$branche_tpl_path" node=$child last='true'}
				{else}
					{include file="$branche_tpl_path" node=$child}
				{/if}

				{if ($smarty.foreach.blockCategTree.iteration mod $numberColumn) == 0 AND !$smarty.foreach.blockCategTree.last}
			</ul>
		</div>
	</div>
	<div class="category_footer" style="float:left;clear:none;width:{$widthColumn}%">
			<div style="float:left" class="list">
			<ul class="list-unstyled tree {if $isDhtml}dhtml{/if}">
				{/if}
				{/foreach}
			</ul>
		</div>
	</div>
</div>
