{if !$PS_CATALOG_MODE}
<div id="header_user">
	{if $logged}
		<a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false" rel="nofollow"><span>{$cookie->customer_firstname}</span> <i class="fa fa-user-alt"></i></a>
		<div class="dropdown-menu  p-5 p-sm-2 droplg">
			<a class="deflink dropdown-item" href="{$link->getPageLink('my-account', true)|escape:'html'}" title="{l s='View my customer account' mod='blockuserinfo'}" rel="nofollow" rel="nofollow">{l s='My account' mod='blockuserinfo'} <i class="fa fa-user-cog"></i></a>
			<a class="dropdown-item" href="{$link->getPageLink('addresses', true)|escape:'html':'UTF-8'}" title="{l s='Addresses' mod='blockuserinfo'}" rel="nofollow">{l s='My addresses' mod='blockuserinfo'}</a>
			{if $returnAllowed}
			<a class="dropdown-item" href="{$link->getPageLink('order-follow', true)|escape:'html':'UTF-8'}" title="{l s='Merchandise returns' mod='blockuserinfo'}" rel="nofollow">{l s='My merchandise returns' mod='blockuserinfo'}</a>
			{/if}
			<a class="dropdown-item" href="{$link->getPageLink('order-slip', true)|escape:'html':'UTF-8'}" title="{l s='Credit slips' mod='blockuserinfo'}" rel="nofollow">{l s='My credit slips' mod='blockuserinfo'}</a>
			<a class="dropdown-item" href="{$link->getPageLink('history', true)|escape:'html':'UTF-8'}" title="{l s='Orders' mod='blockuserinfo'}" rel="nofollow">{l s='Order history and details' mod='blockuserinfo'}</a>
			<a class="dropdown-item" href="{$link->getPageLink('identity', true)|escape:'html':'UTF-8'}" title="{l s='Information' mod='blockuserinfo'}" rel="nofollow">{l s='My personal information' mod='blockuserinfo'}</a>
			{if $voucherAllowed}
			<a class="dropdown-item" href="{$link->getPageLink('discount', true)|escape:'html':'UTF-8'}" title="{l s='Vouchers' mod='blockuserinfo' mod='blockuserinfo'}" rel="nofollow">{l s='My vouchers' mod='blockuserinfo'}</a>
			{/if}
			<hr class="dropdown-divider">
			<a class="deflink dropdown-item" href="{$link->getPageLink('index', true, NULL, "mylogout")|escape:'html'}" title="{l s='Log me out' mod='blockuserinfo'}" rel="nofollow">{l s='Disconnect' mod='blockuserinfo'}</a>
		</div>
	{else}
		<a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false" rel="nofollow"><span>{l s='Sign in' mod='blockuserinfo'}</span> <i class="fa fa-user-alt"></i></a>
		<div class="dropdown-menu p-5 p-sm-2">
			<div class="d-grid gap-2">
				<a class="btn btn-dark" href="{$link->getPageLink('my-account', true)|escape:'html'}"  title="{l s='Log in to your customer account' mod='blockuserinfo'}" rel="nofollow">
					{l s='Sign in' mod='blockuserinfo'} 
				</a>
				<a class="btn btn-light text-smaller text-start" href="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}?create_account=1" type="button">
					{l s='New ? create your account' mod='blockuserinfo'}
				</a>
			</div>
		</div>
	{/if}
</div>
{/if}