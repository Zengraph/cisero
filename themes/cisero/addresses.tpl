{capture name=path}<a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}">{l s='My account'}</a><span class="navigation-pipe">{$navigationPipe}</span><span class="navigation_page">{l s='My addresses'}</span>{/capture}

<h1 class="page-heading">{l s='My addresses'}</h1>

<p>{l s='Please configure your default billing and delivery addresses when placing an order. You may also add additional addresses, which can be useful for sending gifts or receiving an order at your office.'}</p>

{if !empty($multipleAddresses)}
  <div class="addresses">
    <p><strong>{l s='Your addresses are listed below.'}</strong></p>
    <p class="p-indent">{l s='Be sure to update your personal information if it has changed.'}</p>
    {assign var="adrs_style" value=$addresses_style}
    <div class="bloc_adresses mb-4">
      {foreach from=$multipleAddresses item=address name=myLoop}
      <div class="col-xs-12 col-sm-6 address card bg-light">
        <div class="card-body">
          <h3 class="page-subheading">{$address.object.alias}</h3>
          {foreach from=$address.ordered name=adr_loop item=pattern}
            {assign var=addressKey value=" "|explode:$pattern}
            <p>
              {foreach from=$addressKey item=key name="word_loop"}
                <span {if isset($addresses_style[$key])} class="{$addresses_style[$key]}"{/if}>
                  {$address.formated[$key|replace:',':'']|escape:'html':'UTF-8'}
                </span>
              {/foreach}
            </p>
          {/foreach}
          <p class="address_update">
            <a class="btn btn-outline-secondary" href="{$link->getPageLink('address', true, null, "id_address={$address.object.id|intval}")|escape:'html':'UTF-8'}" title="{l s='Update'}">
              <span>{l s='Update'} <i class="fa fa-refresh"></i></span>
            </a>
            <a class="btn btn-danger" href="{$link->getPageLink('address', true, null, "id_address={$address.object.id|intval}&delete")|escape:'html':'UTF-8'}" data-id="addresses_confirm" title="{l s='Delete'}">
              <span>{l s='Delete'} <i class="fa fa-remove"></i></span>
            </a>
          </p>
        </div>
      </div>
      {if $smarty.foreach.myLoop.index % 2 && !$smarty.foreach.myLoop.last}
    </div>
    <div class="bloc_adresses row">
      {/if}
      {/foreach}
    </div>
  </div>
{else}
  <div class="alert alert-warning">{l s='No addresses are available.'}</div>
{/if}

<div class="clearfix form-group">
  <a href="{$link->getPageLink('address', true)|escape:'html':'UTF-8'}" title="{l s='Add an address'}" class="btn btn-dark mb-5">
    <span><i class="fa fa-plus"></i> {l s='Add a new address'}</span>
  </a>
</div>

<nav>
	<button type="button" class="btn btn-outline-dark">
		<a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}">
			{if $isRtl}&rarr;{else}&larr;{/if} {l s='Back to your account'}
		</a>
	</button>
</nav>

{addJsDefL name=addressesConfirm}{l s='Are you sure?' js=1}{/addJsDefL}
