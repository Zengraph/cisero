{capture name=path}{l s='Your shopping cart'}{/capture}
<h1 id="cart_title" class="page-heading">{l s='Shopping-cart summary'}
{if isset($advancedpayment) AND $advancedpayment == 1}
{else}
  {if !isset($empty) && !$PS_CATALOG_MODE}
    <div class="heading-counter badge text-wrap rounded-pill bg-secondary float-lg-end">
		{l s='Your shopping cart contains:'} <span id="summary_products_quantity">{$productNumber} {if $productNumber == 1}{l s='product'}{else}{l s='products'}{/if}</span>
    </div>
  {/if}
{/if}
</h1>
{hook h='displayCartTop'}
{if isset($account_created)}
  <div class="alert alert-success">
    {l s='Your account has been created.'}
  </div>
{/if}

{assign var='current_step' value='summary'}
{include file="$tpl_dir./order-steps.tpl"}
{include file="$tpl_dir./errors.tpl"}

{if isset($empty)}
  <div class="alert alert-warning">{l s='Your shopping cart is empty.'}</div>
{elseif $PS_CATALOG_MODE}
  <div class="alert alert-warning">{l s='This store has not accepted your new order.'}</div>
{else}
  <div id="emptyCartWarning" class="alert alert-warning unvisible">{l s='Your shopping cart is empty.'}</div>
  {* if isset($lastProductAdded) AND $lastProductAdded}
    <div class="cart_last_product" style="display: none;">
      <div class="cart_last_product_header">
        <div class="left">{l s='Last product added'}</div>
      </div>
      <a class="cart_last_product_img" href="{$link->getProductLink($lastProductAdded.id_product, $lastProductAdded.link_rewrite, $lastProductAdded.category, null, null, $lastProductAdded.id_shop)|escape:'html':'UTF-8'}">
        <img src="{$link->getImageLink($lastProductAdded.link_rewrite, $lastProductAdded.id_image, 'small')|escape:'html':'UTF-8'}" alt="{$lastProductAdded.name|escape:'html':'UTF-8'}">
      </a>
      <div class="cart_last_product_content">
        <p class="product-name">
          <a href="{$link->getProductLink($lastProductAdded.id_product, $lastProductAdded.link_rewrite, $lastProductAdded.category, null, null, null, $lastProductAdded.id_product_attribute)|escape:'html':'UTF-8'}">
            {$lastProductAdded.name|escape:'html':'UTF-8'}
          </a>
        </p>
        {if isset($lastProductAdded.attributes) && $lastProductAdded.attributes}
          <small>
            <a href="{$link->getProductLink($lastProductAdded.id_product, $lastProductAdded.link_rewrite, $lastProductAdded.category, null, null, null, $lastProductAdded.id_product_attribute)|escape:'html':'UTF-8'}">
              {$lastProductAdded.attributes|escape:'html':'UTF-8'}
            </a>
          </small>
        {/if}
      </div>
    </div>
  {/if *}
  {assign var='total_discounts_num' value="{if $total_discounts != 0}1{else}0{/if}"}
  {assign var='use_show_taxes' value="{if $use_taxes && $show_taxes}2{else}0{/if}"}
  {assign var='total_wrapping_taxes_num' value="{if $total_wrapping != 0}1{else}0{/if}"}
  {* eu-legal *}
  {hook h="displayBeforeShoppingCartBlock"}
  <div id="order-detail-content" class="table_block">
    <table id="cart_summary" class="table table-bordered {if $PS_STOCK_MANAGEMENT}stock-management-on{else}stock-management-off{/if}">
      <thead>
      <tr class="text-center align-middle">
        <th class="cart_product">{l s='Product'}</th>
        <th class="cart_description">{l s='Description'}</th>
        {if $PS_STOCK_MANAGEMENT}
          {assign var='col_span_subtotal' value='3'}
          <th class="cart_avail text-center">{l s='Availability'}</th>
        {else}
          {assign var='col_span_subtotal' value='2'}
        {/if}
        <th class="cart_unit">{l s='Unit price'}</th>
        <th class="cart_quantity text-center">{l s='Qty'}</th>
        <th class="cart_delete">&nbsp;</th>
        <th class="cart_total">{l s='Total'}</th>
      </tr>
      </thead>
      <tfoot>
      {assign var='rowspan_total' value=2+$total_discounts_num+$total_wrapping_taxes_num}

      {if $use_taxes && $show_taxes && $total_tax != 0}
        {assign var='rowspan_total' value=$rowspan_total+1}
      {/if}

      {if $priceDisplay != 0}
        {assign var='rowspan_total' value=$rowspan_total+1}
      {/if}

      {if $total_shipping_tax_exc <= 0 && (!isset($isVirtualCart) || !$isVirtualCart) && $free_ship}
        {assign var='rowspan_total' value=$rowspan_total+1}
      {else}
        {if $use_taxes && $total_shipping_tax_exc != $total_shipping}
          {if $priceDisplay && $total_shipping_tax_exc > 0}
            {assign var='rowspan_total' value=$rowspan_total+1}
          {elseif $total_shipping > 0}
            {assign var='rowspan_total' value=$rowspan_total+1}
          {/if}
        {elseif $total_shipping_tax_exc > 0}
          {assign var='rowspan_total' value=$rowspan_total+1}
        {/if}
      {/if}

      {if $use_taxes}
        {if $priceDisplay}
          <tr class="cart_total_price">
            <td rowspan="{$rowspan_total}" colspan="3" id="cart_voucher" class="cart_voucher">
              {if $voucherAllowed}
                <form action="{if $opc}{$link->getPageLink('order-opc', true)}{else}{$link->getPageLink('order', true)}{/if}" method="post" id="voucher" class="row g-3 align-items-end">
				  <div class="col-auto">
                    <h4>{l s='Vouchers'}</h4>
                    <input type="text" class="discount_name form-control" id="discount_name" name="discount_name" value="{if isset($discount_name) && $discount_name}{$discount_name}{/if}">
                    <input type="hidden" name="submitDiscount">
				  </div>
				  <div class="col-auto">
                    <button type="submit" name="submitAddDiscount" class="btn btn-primary"><span>{l s='OK'}</span></button>
                  </div>
                </form>
                {if $displayVouchers}
                  <p id="title" class="title-offers mt-2 mb-1">{l s='Take advantage of our exclusive offers:'}</p>
                  <div id="display_cart_vouchers">
                    {foreach $displayVouchers as $voucher}
                      {if $voucher.code != ''}<span class="voucher_name" data-code="{$voucher.code|escape:'html':'UTF-8'}">{$voucher.code|escape:'html':'UTF-8'}</span> - {/if}{$voucher.name}<br>
                    {/foreach}
                  </div>
                {/if}
              {/if}
            </td>
            <td colspan="{$col_span_subtotal}" class="text-{if $isRtl}start{else}end{/if}">{if $display_tax_label}{l s='Total products (tax excl.)'}{else}{l s='Total products'}{/if}</td>
            <td id="total_product" class="price text-{if $isRtl}start{else}end{/if}">{displayPrice price=$total_products}</td>
          </tr>
        {else}
          <tr class="cart_total_price">
            <td rowspan="{$rowspan_total}" colspan="3" id="cart_voucher" class="cart_voucher">
              {if $voucherAllowed}
			    <h4>{l s='Vouchers'}</h4>
                <form action="{if $opc}{$link->getPageLink('order-opc', true)}{else}{$link->getPageLink('order', true)}{/if}" method="post" id="voucher" class="row g-3">
                  <div class="col-auto">
                    <input type="text" class="discount_name form-control" id="discount_name" name="discount_name" value="{if isset($discount_name) && $discount_name}{$discount_name}{/if}">
                  </div>
				  <div class="col-auto">
				    <input type="hidden" name="submitDiscount">
                    <button type="submit" name="submitAddDiscount" class="btn btn-outline-secondary mb-3">{l s='OK'}</button>
				  </div>
                </form>
                {if $displayVouchers}
                  <p id="title" class="title-offers">{l s='Take advantage of our exclusive offers:'}</p>
                  <div id="display_cart_vouchers">
                    {foreach $displayVouchers as $voucher}
                      {if $voucher.code != ''}<span class="voucher_name" data-code="{$voucher.code|escape:'html':'UTF-8'}">{$voucher.code|escape:'html':'UTF-8'}</span> - {/if}{$voucher.name}<br>
                    {/foreach}
                  </div>
                {/if}
              {/if}
            </td>
            <td colspan="{$col_span_subtotal}" class="text-{if $isRtl}start{else}end{/if}">{if $display_tax_label}{l s='Total products (tax incl.)'}{else}{l s='Total products'}{/if}</td>
            <td id="total_product" class="price text-{if $isRtl}start{else}end{/if}">{displayPrice price=$total_products_wt}</td>
          </tr>
        {/if}
      {else}
        <tr class="cart_total_price">
          <td rowspan="{$rowspan_total}" colspan="2" id="cart_voucher" class="cart_voucher">
            {if $voucherAllowed}
              <form action="{if $opc}{$link->getPageLink('order-opc', true)}{else}{$link->getPageLink('order', true)}{/if}" method="post" id="voucher">
                <fieldset>
                  <h4>{l s='Vouchers'}</h4>
                  <input type="text" class="discount_name form-control" id="discount_name" name="discount_name" value="{if isset($discount_name) && $discount_name}{$discount_name}{/if}">
                  <input type="hidden" name="submitDiscount">
                  <button type="submit" name="submitAddDiscount" class="btn btn-primary">
                    <span>{l s='OK'}</span>
                  </button>
                </fieldset>
              </form>
              {if $displayVouchers}
                <p id="title" class="title-offers">{l s='Take advantage of our exclusive offers:'}</p>
                <div id="display_cart_vouchers">
                  {foreach $displayVouchers as $voucher}
                    {if $voucher.code != ''}<span class="voucher_name" data-code="{$voucher.code|escape:'html':'UTF-8'}">{$voucher.code|escape:'html':'UTF-8'}</span> - {/if}{$voucher.name}<br>
                  {/foreach}
                </div>
              {/if}
            {/if}
          </td>
          <td colspan="{$col_span_subtotal}" class="text-{if $isRtl}start{else}end{/if}">{l s='Total products'}</td>
          <td id="total_product" class="price text-{if $isRtl}start{else}end{/if}">{displayPrice price=$total_products}</td>
        </tr>
      {/if}
      <tr{if $total_wrapping == 0} style="display: none;"{/if}>
        <td colspan="3" class="text-{if $isRtl}start{else}end{/if}">
          {if $use_taxes}
            {if $display_tax_label}{l s='Total gift wrapping (tax incl.)'}{else}{l s='Total gift-wrapping cost'}{/if}
          {else}
            {l s='Total gift-wrapping cost'}
          {/if}
        </td>
        <td colspan="2" class="price-discount price" id="total_wrapping">
          {if $use_taxes}
            {if $priceDisplay}
              {displayPrice price=$total_wrapping_tax_exc}
            {else}
              {displayPrice price=$total_wrapping}
            {/if}
          {else}
            {displayPrice price=$total_wrapping_tax_exc}
          {/if}
        </td>
      </tr>
      {if $total_shipping_tax_exc <= 0 && (!isset($isVirtualCart) || !$isVirtualCart) && $free_ship}
        <tr class="cart_total_delivery{if !$opc && (!isset($cart->id_address_delivery) || !$cart->id_address_delivery)} unvisible{/if}">
          <td colspan="{$col_span_subtotal}" class="text-{if $isRtl}start{else}end{/if}">{l s='Total shipping'}</td>
          <td id="total_shipping" class="price text-{if $isRtl}start{else}end{/if}">{l s='Free shipping!'}</td>
        </tr>
      {else}
        {if $use_taxes && $total_shipping_tax_exc != $total_shipping}
          {if $priceDisplay}
            <tr class="cart_total_delivery{if $total_shipping_tax_exc <= 0} unvisible{/if}">
              <td colspan="{$col_span_subtotal}" class="text-{if $isRtl}start{else}end{/if}">{if $display_tax_label}{l s='Total shipping (tax excl.)'}{else}{l s='Total shipping'}{/if}</td>
              <td id="total_shipping" class="price text-{if $isRtl}start{else}end{/if}">{displayPrice price=$total_shipping_tax_exc}</td>
            </tr>
          {else}
            <tr class="cart_total_delivery{if $total_shipping <= 0} unvisible{/if}">
              <td colspan="{$col_span_subtotal}" class="text-{if $isRtl}start{else}end{/if}">{if $display_tax_label}{l s='Total shipping (tax incl.)'}{else}{l s='Total shipping'}{/if}</td>
              <td id="total_shipping" class="price text-{if $isRtl}start{else}end{/if}">{displayPrice price=$total_shipping}</td>
            </tr>
          {/if}
        {else}
          <tr class="cart_total_delivery{if $total_shipping_tax_exc <= 0} unvisible{/if}">
            <td colspan="{$col_span_subtotal}" class="text-{if $isRtl}start{else}end{/if}">{l s='Total shipping'}</td>
            <td id="total_shipping" class="price text-{if $isRtl}start{else}end{/if}">{displayPrice price=$total_shipping_tax_exc}</td>
          </tr>
        {/if}
      {/if}
      <tr class="shipping_error" style="display:none">
          <td colspan="{$col_span_subtotal+2}" class="text-left" style="width: 1px;"></td>
      </tr>
      <tr class="cart_total_voucher{if $total_discounts == 0} unvisible{/if}">
        <td colspan="{$col_span_subtotal}" class="text-{if $isRtl}start{else}end{/if}">
          {if $display_tax_label}
            {if $use_taxes && $priceDisplay == 0}
              {l s='Total vouchers (tax incl.)'}
            {else}
              {l s='Total vouchers (tax excl.)'}
            {/if}
          {else}
            {l s='Total vouchers'}
          {/if}
        </td>
        <td colspan="2" class="price-discount price" id="total_discount">
          {if $use_taxes && $priceDisplay == 0}
            {assign var='total_discounts_negative' value=$total_discounts * -1}
          {else}
            {assign var='total_discounts_negative' value=$total_discounts_tax_exc * -1}
          {/if}
          {displayPrice price=$total_discounts_negative}
        </td>
      </tr>
      {if $use_taxes && $show_taxes && $total_tax != 0 }
        {if $priceDisplay != 0}
          <tr class="cart_total_price">
            <td colspan="{$col_span_subtotal}" class="text-{if $isRtl}start{else}end{/if}">{if $display_tax_label}{l s='Total (tax excl.)'}{else}{l s='Total'}{/if}</td>
            <td colspan="2" class="price" id="total_price_without_tax">{displayPrice price=$total_price_without_tax}</td>
          </tr>
        {/if}
        <tr class="cart_total_tax">
          <td colspan="{$col_span_subtotal}" class="text-{if $isRtl}start{else}end{/if}">{l s='Tax'}</td>
          <td colspan="2" class="price" id="total_tax">{displayPrice price=$total_tax}</td>
        </tr>
      {/if}
      <tr class="cart_total_price">
        <td colspan="{$col_span_subtotal}" class="total_price_container text-{if $isRtl}start{else}end{/if}">
          <span>{l s='Total'}</span>
          <div class="hookDisplayProductPriceBlock-price">
            {hook h="displayCartTotalPriceLabel"}
          </div>
        </td>
        {if $use_taxes}
          <td id="total_price_container" class="text-{if $isRtl}start{else}end{/if}">
            <span id="total_price">{displayPrice price=$total_price}</span>
          </td>
        {else}
          <td id="total_price_container" class="text-{if $isRtl}start{else}end{/if}">
            <span id="total_price">{displayPrice price=$total_price_without_tax}</span>
          </td>
        {/if}
      </tr>
      </tfoot>
      <tbody>
      {assign var='odd' value=0}
      {assign var='have_non_virtual_products' value=false}
      {foreach $products as $product}
        {if $product.is_virtual == 0}
          {assign var='have_non_virtual_products' value=true}
        {/if}
        {assign var='productId' value=$product.id_product}
        {assign var='productAttributeId' value=$product.id_product_attribute}
        {assign var='quantityDisplayed' value=0}
        {assign var='odd' value=($odd+1)%2}
        {assign var='ignoreProductLast' value=isset($customizedDatas.$productId.$productAttributeId) || count($gift_products)}
        {* Display the product line *}
        {include file="$tpl_dir./shopping-cart-product-line.tpl" productLast=$product@last productFirst=$product@first}
        {* Then the customized datas ones*}
        {if isset($customizedDatas.$productId.$productAttributeId[$product.id_address_delivery])}
          {foreach $customizedDatas.$productId.$productAttributeId[$product.id_address_delivery] as $id_customization=>$customization}
            <tr
              id="product_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}"
              class="product_customization_for_{$product.id_product}_{$product.id_product_attribute}_{$product.id_address_delivery|intval}{if $odd} odd{else} even{/if} customization">
              <td></td>
              <td colspan="3">
                {foreach $customization.datas as $type => $custom_data}
                  {if $type == $CUSTOMIZE_FILE}
                    <div class="customizationUploaded">
                      <ul class="customizationUploaded">
                        {foreach $custom_data as $picture}
                          <li><img src="{$pic_dir}{$picture.value}_small" alt="" class="customizationUploaded"></li>
                        {/foreach}
                      </ul>
                    </div>
                  {elseif $type == $CUSTOMIZE_TEXTFIELD}
                    <ul class="typedText">
                      {foreach $custom_data as $textField}
                        <li>
                          {if $textField.name}
                            {$textField.name}
                          {else}
                            {l s='Text #'}{$textField@index+1}
                          {/if}
                          : {$textField.value}
                        </li>
                      {/foreach}
                    </ul>
                  {/if}
                {/foreach}
              </td>
              <td class="cart_quantity" colspan="1">
                {if isset($cannotModify) AND $cannotModify == 1}
                  <span>{if $quantityDisplayed == 0 AND isset($customizedDatas.$productId.$productAttributeId)}{$customizedDatas.$productId.$productAttributeId|@count}{else}{$product.cart_quantity-$quantityDisplayed}{/if}</span>
                {else}
                  <input type="hidden" value="{$customization.quantity}" name="quantity_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}_hidden">
                  <input type="text" value="{$customization.quantity}" class="cart_quantity_input form-control text-center" name="quantity_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}">
                  <div class="cart_quantity_button clearfix">
                    {if $product.minimal_quantity < ($customization.quantity -$quantityDisplayed) OR $product.minimal_quantity <= 1}
                      <a
                        id="cart_quantity_down_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}"
                        class="cart_quantity_down btn btn-default button-minus"
                        href="{$link->getPageLink('cart', true, NULL, "add=1&amp;id_product={$product.id_product|intval}&amp;ipa={$product.id_product_attribute|intval}&amp;id_address_delivery={$product.id_address_delivery}&amp;id_customization={$id_customization}&amp;op=down&amp;token={$token_cart}")|escape:'html':'UTF-8'}"
                        rel="nofollow"
                        title="{l s='Subtract'}">
                        <i class="fa fa-fw fa-minus"></i>
                      </a>
                    {else}
                      <a
                        id="cart_quantity_down_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}"
                        class="cart_quantity_down btn btn-default button-minus disabled"
                        href="#"
                        title="{l s='Subtract'}">
                        <i class="fa fa-fw fa-minus"></i>
                      </a>
                    {/if}
                    <a
                      id="cart_quantity_up_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}"
                      class="cart_quantity_up btn btn-default button-plus"
                      href="{$link->getPageLink('cart', true, NULL, "add=1&amp;id_product={$product.id_product|intval}&amp;ipa={$product.id_product_attribute|intval}&amp;id_address_delivery={$product.id_address_delivery}&amp;id_customization={$id_customization}&amp;token={$token_cart}")|escape:'html':'UTF-8'}"
                      rel="nofollow"
                      title="{l s='Add'}">
                      <i class="fa fa-fw fa-plus"></i>
                    </a>
                  </div>
                {/if}
              </td>
              <td class="cart_delete text-center">
                {if isset($cannotModify) AND $cannotModify == 1}
                {else}
                  <a
                    id="{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}"
                    class="cart_quantity_delete"
                    href="{$link->getPageLink('cart', true, NULL, "delete=1&amp;id_product={$product.id_product|intval}&amp;ipa={$product.id_product_attribute|intval}&amp;id_customization={$id_customization}&amp;id_address_delivery={$product.id_address_delivery}&amp;token={$token_cart}")|escape:'html':'UTF-8'}"
                    rel="nofollow"
                    title="{l s='Delete'}">
                    <i class="fa fa-trash-alt"></i>
                  </a>
                {/if}
              </td>
              <td>
              </td>
            </tr>
            {assign var='quantityDisplayed' value=$quantityDisplayed+$customization.quantity}
          {/foreach}

          {* If it exists also some uncustomized products *}
          {if $product.quantity-$quantityDisplayed > 0}{include file="$tpl_dir./shopping-cart-product-line.tpl" productLast=$product@last productFirst=$product@first}{/if}
        {/if}
      {/foreach}
      {assign var='last_was_odd' value=$product@iteration%2}
      {foreach $gift_products as $product}
        {assign var='productId' value=$product.id_product}
        {assign var='productAttributeId' value=$product.id_product_attribute}
        {assign var='quantityDisplayed' value=0}
        {assign var='odd' value=($product@iteration+$last_was_odd)%2}
        {assign var='ignoreProductLast' value=isset($customizedDatas.$productId.$productAttributeId)}
        {assign var='cannotModify' value=1}
        {* Display the gift product line *}
        {include file="$tpl_dir./shopping-cart-product-line.tpl" productLast=$product@last productFirst=$product@first}
      {/foreach}
      </tbody>

      {if sizeof($discounts)}
        <tbody>
        {foreach $discounts as $discount}
          {if ($discount.value_real|floatval == 0 && $discount.free_shipping != 1) || ($discount.value_real|floatval == 0 && $discount.code == '')}
            {continue}
          {/if}
          <tr class="cart_discount" id="cart_discount_{$discount.id_discount}">
            <td class="cart_discount_name" colspan="{if $PS_STOCK_MANAGEMENT}3{else}2{/if}">{$discount.name}</td>
            <td class="cart_discount_price">
              <span class="price-discount">
                {if !$priceDisplay}{displayPrice price=$discount.value_real*-1}{else}{displayPrice price=$discount.value_tax_exc*-1}{/if}
              </span>
            </td>
            <td class="cart_discount_delete">1</td>
            <td class="price_discount_del text-center">
              {if strlen($discount.code)}
                <a
                  href="{if $opc}{$link->getPageLink('order-opc', true)}{else}{$link->getPageLink('order', true)}{/if}?deleteDiscount={$discount.id_discount}"
                  class="price_discount_delete"
                  title="{l s='Delete'}">
                  <i class="fa fa-trash-alt"></i>
                </a>
              {/if}
            </td>
            <td class="cart_discount_price">
              <span class="price-discount price">{if !$priceDisplay}{displayPrice price=$discount.value_real*-1}{else}{displayPrice price=$discount.value_tax_exc*-1}{/if}</span>
            </td>
          </tr>
        {/foreach}
        </tbody>
      {/if}
    </table>
  </div>

  {if $show_option_allow_separate_package}
    <div class="checkbox">
      <label for="allow_seperated_package" class="inline">
        <input type="checkbox" name="allow_seperated_package" id="allow_seperated_package" {if $cart->allow_seperated_package}checked="checked"{/if} autocomplete="off">
        <span class="label-text">{l s='Send available products first'}</span>
      </label>
    </div>
  {/if}

  <div id="HOOK_SHOPPING_CART">{$HOOK_SHOPPING_CART}</div>
  <p class="cart_navigation d-grid gap-2 d-md-flex justify-content-md-between mt-3">
    <a href="{if (isset($smarty.server.HTTP_REFERER) && ($smarty.server.HTTP_REFERER == $link->getPageLink('order', true) || $smarty.server.HTTP_REFERER == $link->getPageLink('order-opc', true) || strstr($smarty.server.HTTP_REFERER, 'step='))) || !isset($smarty.server.HTTP_REFERER)}{$link->getPageLink('index')}{else}{$smarty.server.HTTP_REFERER|regex_replace:'/[\?|&]content_only=1/':''|escape:'html':'UTF-8'|secureReferrer}{/if}" class="btn btn-lg btn-outline-dark" title="{l s='Continue shopping'}">
		<i class="fa fa-chevron-left"></i> {l s='Continue shopping'} 
	</a>
    {if !$opc}
      <a  href="{if $back}{$link->getPageLink('order', true, NULL, 'step=1&amp;back={$back}')|escape:'html':'UTF-8'}{else}{$link->getPageLink('order', true, NULL, 'step=1')|escape:'html':'UTF-8'}{/if}" class="btn btn-lg btn-dark standard-checkout" title="{l s='Proceed to checkout'}">
		{l s='Proceed to checkout'} <i class="fa fa-chevron-right"></i>
      </a>
    {/if}
  </p>
  <div class="clear"></div>
  <div class="cart_navigation_extra">
    <div id="HOOK_SHOPPING_CART_EXTRA">{if isset($HOOK_SHOPPING_CART_EXTRA)}{$HOOK_SHOPPING_CART_EXTRA}{/if}</div>
  </div>
  {strip}
    {addJsDef deliveryAddress=$cart->id_address_delivery|intval}
    {addJsDefL name=txtProduct}{l s='product' js=1}{/addJsDefL}
    {addJsDefL name=txtProducts}{l s='products' js=1}{/addJsDefL}
  {/strip}
{/if}