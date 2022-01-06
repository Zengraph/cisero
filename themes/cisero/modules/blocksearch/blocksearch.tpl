<div id="search_block_top">
	<form method="get" action="{$link->getPageLink('search', true)|escape:'html'}" class="form input-group" id="searchbox">
		<input type="hidden" name="controller" value="search" />
		<input type="hidden" name="orderby" value="position" />
		<input type="hidden" name="orderway" value="desc" />
		<input type="text" class="form-control form-control-md" id="search_query_block" placeholder="{l s='Search entire store...'}" name="search_query" value="{$search_query|escape:'html':'UTF-8'|stripslashes}" />
		<button type="submit" class="input-group-text"><i class="fa fa-search"></i></button>
	</form>
</div>

{include file="$self/blocksearch-instantsearch.tpl"}