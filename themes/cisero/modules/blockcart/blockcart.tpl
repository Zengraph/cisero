<div id="cart_block" class="nav-link ps-1">
	<a href="{$link->getPageLink("$order_process", true)|escape:'html'}" title="{if $cart_qties > 0}{l s='View my shopping cart' mod='blockcart'}{else}{l s='Shopping cart empty' mod='blockcart'}{/if}" rel="nofollow"><span>{l s='Bag' mod='blockcart'}</span> <i class="fas fa-shopping-bag"></i>
		<span class="ajax_cart_quantity">{$cart_qties}</span>
		{if $cart_qties > 0}
			<span class="ajax_cart_total">
				{if $priceDisplay == 1}
					{convertPrice price=$cart->getOrderTotal(false)}
				{else}
					{convertPrice price=$cart->getOrderTotal(true)}
				{/if}
			</span>
		{/if}
	</a>
</div>

{counter name=active_overlay assign=active_overlay}
{if !$PS_CATALOG_MODE && $active_overlay == 1}
  {include file='./includes/popup.tpl'}
{/if}

{strip}
  {addJsDef CUSTOMIZE_TEXTFIELD=$CUSTOMIZE_TEXTFIELD}
  {addJsDef img_dir=$img_dir|escape:'quotes':'UTF-8'}
  {addJsDef generated_date=$smarty.now|intval}
  {addJsDef ajax_allowed=$ajax_allowed|boolval}
  {addJsDef hasDeliveryAddress=(isset($cart->id_address_delivery) && $cart->id_address_delivery)}

  {addJsDefL name=customizationIdMessage}{l s='Customization #' mod='blockcart' js=1}{/addJsDefL}
  {addJsDefL name=removingLinkText}{l s='remove this product from my cart' mod='blockcart' js=1}{/addJsDefL}
  {addJsDefL name=freeShippingTranslation}{l s='Free shipping!' mod='blockcart' js=1}{/addJsDefL}
  {addJsDefL name=freeProductTranslation}{l s='Free!' mod='blockcart' js=1}{/addJsDefL}
  {addJsDefL name=delete_txt}{l s='Delete' mod='blockcart' js=1}{/addJsDefL}
  {addJsDefL name=toBeDetermined}{l s='To be determined' mod='blockcart' js=1}{/addJsDefL}
{/strip}