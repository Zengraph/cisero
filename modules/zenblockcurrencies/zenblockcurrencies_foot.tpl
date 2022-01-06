<div id="currencies_block_foot" class="col-auto order-last">
	<form id="setCurrency_foot" action="{$request_uri}" method="post" class="btn-group">
		<button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
			{$blockcurrencies_sign} {$blockcurrencies_name}
		</button>
		<ul class="dropdown-menu">
		  {foreach from=$currencies key=k item=f_currency}
			{if $cookie->id_currency != $f_currency.id_currency}
				<li>
					<a class="dropdown-item" href="javascript:setCurrency({$f_currency.id_currency});" title="{$f_currency.name}" rel="nofollow">{$f_currency.sign} {$f_currency.name}</a>
				</li>
			{/if}
		  {/foreach}
		</ul>
	</form>
</div>