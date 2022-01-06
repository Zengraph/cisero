<li class="category_{$node.id}{if isset($last) && $last == 'true'} last{/if}">
	<a href="{$node.link|escape:'html':'UTF-8'}" {if isset($currentCategoryId) && $node.id == $currentCategoryId}class="selected"{/if} title="{$node.desc|strip_tags|trim|truncate:255:'...'|escape:'html':'UTF-8'}">{$node.name|escape:'html':'UTF-8'}</a>
</li>
