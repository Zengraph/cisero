{if !$opc}
  {assign var='current_step' value='address'}
  {capture name=path}{l s='Addresses'}{/capture}
  {assign var="back_order_page" value="order.php"}
  <h1 class="page-heading">{l s='Addresses'}</h1>
  {include file="$tpl_dir./order-steps.tpl"}
  {include file="$tpl_dir./errors.tpl"}
  <form action="{$link->getPageLink($back_order_page, true)|escape:'html':'UTF-8'}" method="post">
{else}
  {assign var="back_order_page" value="order-opc.php"}
  <h1 class="page-heading step-num"><span>1</span> {l s='Addresses'}</h1>
  <div id="opc_account" class="opc-main-block">
    <div id="opc_account-overlay" class="opc-overlay" style="display: none;"></div>
{/if}
<div class="addresses clearfix">
  <div class="gap-2 d-md-flex justify-content-md-between mb-3">
    <div class="">
      <div class="address_delivery select selector1">
        <label for="id_address_delivery" class="form-label">{if $cart->isVirtualCart()}{l s='Choose a billing address:'}{else}{l s='Choose a delivery address:'}{/if}</label>
        <select name="id_address_delivery" id="id_address_delivery" class="form-select">
          {foreach from=$addresses key=k item=address}
            <option value="{$address.id_address|intval}"{if $address.id_address == $cart->id_address_delivery} selected="selected"{/if}>
              {$address.alias|escape:'html':'UTF-8'}
            </option>
          {/foreach}
        </select>
        <span class="waitimage"></span>
      </div>
      <div class="checkbox addressesAreEquals"{if $cart->isVirtualCart()} style="display:none;"{/if}>
        <label for="addressesAreEquals">
          <input type="checkbox" name="same" id="addressesAreEquals" value="1"{if $cart->id_address_invoice == $cart->id_address_delivery || $addresses|@count == 1} checked="checked"{/if}>
          <span class="label-text">{l s='Use the delivery address as the billing address.'}</span>
        </label>
      </div>
    </div>
    <div class="d-flex align-items-center">
      <div id="address_invoice_form" class="select mb-1 selector1"{if $cart->id_address_invoice == $cart->id_address_delivery} style="display: none;"{/if}>
        {if $addresses|@count > 1}
          <label for="id_address_invoice" class="strong form-label">{l s='Choose a billing address:'}</label>
          <select name="id_address_invoice" id="id_address_invoice" class="address_select form-control">
          {section loop=$addresses step=-1 name=address}
             <option value="{$addresses[address].id_address|intval}"{if $addresses[address].id_address == $cart->id_address_invoice && $cart->id_address_delivery != $cart->id_address_invoice} selected="selected"{/if}>
               {$addresses[address].alias|escape:'html':'UTF-8'}
             </option>
          {/section}
          </select><span class="waitimage"></span>
        {else}
           <a href="{$link->getPageLink('address', true, NULL, "back={$back_order_page}?step=1&select_address=1{if $back}&mod={$back}{/if}")|escape:'html':'UTF-8'}" title="{l s='Add'}" class="btn btn-outline-dark">
             <span>
               {l s='Add a new address'}
               <i class="fa fa-chevron-right"></i>
             </span>
           </a>
        {/if}
      </div>
    </div>
  </div>
  <div class="d-grid gap-2 d-md-flex justify-content-md-between mb-3">
    <div class="card flex-fill bg-light"{if $cart->isVirtualCart()} style="display:none;"{/if}>
      <ul class="card-body address" id="address_delivery">
      </ul>
    </div>
    <div class="card flex-fill bg-light">
      <ul class="card-body address box" id="address_invoice">
      </ul>
    </div>
  </div>
  <p class="address_add submit">
    <a href="{$link->getPageLink('address', true, NULL, "back={$back_order_page}?step=1{if $back}&mod={$back}{/if}")|escape:'html':'UTF-8'}" title="{l s='Add'}" class="btn btn-outline-dark">
      <span>{l s='Add a new address'} <i class="fa fa-chevron-right"></i></span>
    </a>
  </p>
</div>
{if !$opc}
  </form>
{else}
  </div> {*  end opc_account *}
{/if}
{strip}
  {if !$opc}
    {addJsDef orderProcess='order'}
    {addJsDefL name=txtProduct}{l s='product' js=1}{/addJsDefL}
    {addJsDefL name=txtProducts}{l s='products' js=1}{/addJsDefL}
    {addJsDefL name=CloseTxt}{l s='Submit' js=1}{/addJsDefL}
  {/if}
  {capture}{if $back}&mod={$back|urlencode}{/if}{/capture}
  {capture name=addressUrl}{$link->getPageLink('address', true, NULL, 'back='|cat:$back_order_page|cat:'?step=1'|cat:$smarty.capture.default)|escape:'quotes':'UTF-8'}{/capture}
  {addJsDef addressUrl=$smarty.capture.addressUrl}
  {capture}{'&multi-shipping=1'|urlencode}{/capture}
  {addJsDef addressMultishippingUrl=$smarty.capture.addressUrl|cat:$smarty.capture.default}
  {capture name=addressUrlAdd}{$smarty.capture.addressUrl|cat:'&id_address='}{/capture}
  {addJsDef addressUrlAdd=$smarty.capture.addressUrlAdd}
  {addJsDef formatedAddressFieldsValuesList=$formatedAddressFieldsValuesList}
  {addJsDef opc=$opc|boolval}
  {capture}<h3 class="page-subheading">{l s='Your billing address' js=1}</h3>{/capture}
  {addJsDefL name=titleInvoice}{$smarty.capture.default|@addcslashes:'\''}{/addJsDefL}
  {capture}<h3 class="page-subheading">{l s='Your delivery address' js=1}</h3>{/capture}
  {addJsDefL name=titleDelivery}{$smarty.capture.default|@addcslashes:'\''}{/addJsDefL}
  {capture}<a class="btn btn-dark mt-3" href="{$smarty.capture.addressUrlAdd}" title="{l s='Update' js=1}"><span>{l s='Update' js=1}</span></a>{/capture}
  {addJsDefL name=liUpdate}{$smarty.capture.default|@addcslashes:'\''}{/addJsDefL}
{/strip}
{include file="$tpl_dir./order-carrier.tpl"}