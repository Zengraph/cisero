{if !isset($addresses_style)}
  {$addresses_style.company = 'address_company'}
  {$addresses_style.vat_number = 'address_company'}
  {$addresses_style.firstname = 'address_name'}
  {$addresses_style.lastname = 'address_name'}
  {$addresses_style.address1 = 'address_address1'}
  {$addresses_style.address2 = 'address_address2'}
  {$addresses_style.city = 'address_city'}
  {$addresses_style.country = 'address_country'}
  {$addresses_style.phone = 'address_phone'}
  {$addresses_style.phone_mobile = 'address_phone_mobile'}
  {$addresses_style.alias = 'address_title'}
{/if}
{assign var='have_non_virtual_products' value=false}
{foreach $products as $product}
  {if $product.is_virtual == 0}
    {assign var='have_non_virtual_products' value=true}
    {break}
  {/if}
{/foreach}

{addJsDefL name=txtProduct}{l s='Product' js=1}{/addJsDefL}
{addJsDefL name=txtProducts}{l s='Products' js=1}{/addJsDefL}
{capture name=path}{l s='Your shopping cart'}{/capture}

{if $productNumber == 0}
  <div class="alert alert-warning">{l s='Your shopping cart is empty.'}</div>
{elseif $PS_CATALOG_MODE}
  <div class="alert alert-warning">{l s='This store has not accepted your new order.'}</div>
{else}
  <div id="emptyCartWarning" class="alert alert-warning unvisible">{l s='Your shopping cart is empty.'}</div>
  <h2>{l s='Payment Options'}</h2>

  <div id="HOOK_ADVANCED_PAYMENT">
    <div class="row">
      {* Should get a collection of "PaymentOption" object *}
      {assign var='adv_payment_empty' value=true}
      {foreach from=$HOOK_ADVANCED_PAYMENT item=pay_option key=key}
        {if $pay_option}
          {assign var='adv_payment_empty' value=false}
        {/if}
      {/foreach}
      {if $HOOK_ADVANCED_PAYMENT && !$adv_payment_empty}
      {foreach $HOOK_ADVANCED_PAYMENT as $advanced_payment_opt_list}
        {foreach $advanced_payment_opt_list as $paymentOption}
          <div class="col-xs-6 col-md-6">
            <p class="payment_module pointer-box">
              <a class="payment_module_adv">
                <img class="payment_option_logo" src="{$paymentOption->getLogo()}" alt="">
                  <span class="payment_option_cta">
                    {$paymentOption->getCallToActionText()}
                  </span>
                  <span class="pull-right payment_option_selected">
                    <i class="fa fa-check"></i>
                  </span>
              </a>

            </p>
            <div class="payment_option_form">
              {if $paymentOption->getForm()}
                {$paymentOption->getForm()}
              {else}
                <form method="{if $paymentOption->getMethod()}{$paymentOption->getMethod()}{else}POST{/if}" action="{$paymentOption->getAction()}">
                  {if $paymentOption->getInputs()}
                    {foreach from=$paymentOption->getInputs() item=value key=name}
                      <input type="hidden" name="{$name}" value="{$value}">
                    {/foreach}
                  {/if}
                </form>
              {/if}
            </div>
          </div>
        {/foreach}
      {/foreach}
    </div>
    {else}
    <div class="col-xs-12 col-md-12">
      <div class="alert alert-warning ">{l s='Unable to find any available payment option for your cart. Please contact us if the problem persists'}</div>
    </div>
    {/if}
  </div>

  {if $opc}
    {include file="$tpl_dir./order-carrier-advanced.tpl"}
  {/if}

  {if $is_logged AND !$is_guest}
    {include file="$tpl_dir./order-address-advanced.tpl"}
  {elseif $opc}
    {include file="$tpl_dir./order-opc-new-account-advanced.tpl"}
  {/if}

  {include file="$tpl_dir./shopping-cart.tpl" advancedpayment = 1 cannotModify = 1}

  {if $conditions AND $cms_id}
    {if $override_tos_display }
      {$override_tos_display}
    {else}
      <div class="row">
        <div class="col-xs-12 col-md-12">
          <h2>{l s='Terms and Conditions'}</h2>
          <div class="box">
            <div class="checkbox">
              <label for="cgv">
                <input type="checkbox" name="cgv" id="cgv" value="1" {if $checkedTOS}checked="checked"{/if}>
                <span class="label-text">{l s='I agree to the terms of service and will adhere to them unconditionally.'}</span>
              </label>
              <a href="{$link_conditions|escape:'html':'UTF-8'}" class="iframe" rel="nofollow">{l s='(Read the Terms of Service)'}</a>
            </div>
          </div>
        </div>
      </div>
    {/if}
  {/if}

  <p class="cart_navigation d-grid gap-2 d-md-flex justify-content-md-between mt-3">
	  {if $opc}
		{assign var='back_link' value=$link->getPageLink('index')}
	  {else}
		{assign var='back_link' value=$link->getPageLink('order', true, NULL, "step=1")}
	  {/if}
	  <a href="{$back_link|escape:'html':'UTF-8'}" title="{l s='Previous'}" class="btn btn-lg btn-outline-dark">
		<i class="fa fa-chevron-left"></i>
		{l s='Continue shopping'}
	  </a>
	  <button data-show-if-js="" style="" id="confirmOrder" type="button" class="btn btn-lg btn-dark standard-checkout"><span>{l s='Order With Obligation To Pay'}</span></button>
  </p>

{/if}
