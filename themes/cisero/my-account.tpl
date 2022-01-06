{capture name=path}{l s='My account'}{/capture}

<h1 class="page-heading col-lg-6 mx-auto">{l s='My account'}</h1>
{if isset($account_created)}
  <div class="alert alert-success">{l s='Your account has been created.'}</div>
{/if}
{hook h='displayMyAccountTop'}
<div id="my-account-menu" class="d-grid gap-3 col-lg-6 mb-5 mx-auto">
	<p>{l s='Welcome to your account. Here you can manage all of your personal information and orders.'}</p>
    {if $has_customer_an_address}
		<a class="btn btn-dark" href="{$link->getPageLink('address', true)|escape:'html':'UTF-8'}" title="{l s='Add my first address'}"><i class="fa fa-building"></i> <span>{l s='Add my first address'}</span></a>
    {/if}
		<a class="btn btn-dark" href="{$link->getPageLink('history', true)|escape:'html':'UTF-8'}" title="{l s='Orders'}"><i class="fa fa-list-ol"></i> <span>{l s='Order history and details'}</span></a>
    {if $returnAllowed}
		<a class="btn btn-dark" href="{$link->getPageLink('order-follow', true)|escape:'html':'UTF-8'}" title="{l s='Merchandise returns'}"><i class="fa fa-refresh"></i> <span>{l s='My merchandise returns'}</span></a>
    {/if}
	<a class="btn btn-dark" href="{$link->getPageLink('order-slip', true)|escape:'html':'UTF-8'}" title="{l s='Credit slips'}"><i class="fa fa-file"></i> <span>{l s='My credit slips'}</span></a>
	<a class="btn btn-dark" href="{$link->getPageLink('addresses', true)|escape:'html':'UTF-8'}" title="{l s='Addresses'}"><i class="fa fa-fw fa-building"></i> <span>{l s='My addresses'}</span></a>
	<a class="btn btn-dark" href="{$link->getPageLink('identity', true)|escape:'html':'UTF-8'}" title="{l s='Information'}"><i class="fa fa-user"></i> <span>{l s='My personal information'}</span></a>
	{if $voucherAllowed || isset($HOOK_CUSTOMER_ACCOUNT) && $HOOK_CUSTOMER_ACCOUNT !=''}
	    {if $voucherAllowed}
			<a class="btn btn-dark" href="{$link->getPageLink('discount', true)|escape:'html':'UTF-8'}" title="{l s='Vouchers'}"><i class="fa fa-barcode"></i> <span>{l s='My vouchers'}</span></a>
		{/if}
        {$HOOK_CUSTOMER_ACCOUNT}
	{/if}
</div>
{hook h='displayMyAccountBelow'}
<nav class="col-lg-6 mx-auto">
	<button type="button" class="btn btn-outline-dark">
		<a href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}"> {if $isRtl}&rarr;{else}&larr;{/if} {l s='Home'}</a>
	</button>
</nav>

