<div class="paiement_block">
  <div id="HOOK_TOP_PAYMENT">{$HOOK_TOP_PAYMENT}</div>
  {if $HOOK_PAYMENT}
    {if !$opc}
      <div id="order-detail-content" class="table_block table-responsive">
        <table id="cart_summary" class="table table-bordered">
          <tfoot>
          {if $use_taxes}
            {if $priceDisplay}
              <tr class="cart_total_price">
                <td colspan="4" class="text-right">{if $display_tax_label}{l s='Total products (tax excl.)'}{else}{l s='Total products'}{/if}</td>
                <td colspan="2" class="price" id="total_product">{displayPrice price=$total_products}</td>
              </tr>
            {else}
              <tr class="cart_total_price">
                <td colspan="4" class="text-right">{if $display_tax_label}{l s='Total products (tax incl.)'}{else}{l s='Total products'}{/if}</td>
                <td colspan="2" class="price" id="total_product">{displayPrice price=$total_products_wt}</td>
              </tr>
            {/if}
          {else}
            <tr class="cart_total_price">
              <td colspan="4" class="text-right">{l s='Total products'}</td>
              <td colspan="2" class="price" id="total_product">{displayPrice price=$total_products}</td>
            </tr>
          {/if}
          <tr class="cart_total_voucher" {if $total_wrapping == 0}style="display:none"{/if}>
            <td colspan="4" class="text-right">
              {if $use_taxes}
                {if $priceDisplay}
                  {if $display_tax_label}{l s='Total gift wrapping (tax excl.):'}{else}{l s='Total gift wrapping cost:'}{/if}
                {else}
                  {if $display_tax_label}{l s='Total gift wrapping (tax incl.)'}{else}{l s='Total gift wrapping cost:'}{/if}
                {/if}
              {else}
                {l s='Total gift wrapping cost:'}
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
            <tr class="cart_total_delivery">
              <td colspan="4" class="text-right">{l s='Total shipping'}</td>
              <td colspan="2" class="price" id="total_shipping">{l s='Free Shipping!'}</td>
            </tr>
          {else}
            {if $use_taxes && $total_shipping_tax_exc != $total_shipping}
              {if $priceDisplay}
                <tr class="cart_total_delivery" {if $shippingCost <= 0} style="display:none"{/if}>
                  <td colspan="4" class="text-right">{if $display_tax_label}{l s='Total shipping (tax excl.)'}{else}{l s='Total shipping'}{/if}</td>
                  <td colspan="2" class="price" id="total_shipping">{displayPrice price=$shippingCostTaxExc}</td>
                </tr>
              {else}
                <tr class="cart_total_delivery"{if $shippingCost <= 0} style="display:none"{/if}>
                  <td colspan="4" class="text-right">{if $display_tax_label}{l s='Total shipping (tax incl.)'}{else}{l s='Total shipping'}{/if}</td>
                  <td colspan="2" class="price" id="total_shipping" >{displayPrice price=$shippingCost}</td>
                </tr>
              {/if}
            {else}
              <tr class="cart_total_delivery"{if $shippingCost <= 0} style="display:none"{/if}>
                <td colspan="4" class="text-right">{l s='Total shipping'}</td>
                <td colspan="2" class="price" id="total_shipping" >{displayPrice price=$shippingCostTaxExc}</td>
              </tr>
            {/if}
          {/if}
          <tr class="cart_total_voucher" {if $total_discounts == 0}style="display:none"{/if}>
            <td colspan="4" class="text-right">
              {if $use_taxes}
                {if $priceDisplay}
                  {if $display_tax_label && $show_taxes}{l s='Total vouchers (tax excl.)'}{else}{l s='Total vouchers'}{/if}
                {else}
                  {if $display_tax_label && $show_taxes}{l s='Total vouchers (tax incl.)'}{else}{l s='Total vouchers'}{/if}
                {/if}
              {else}
                {l s='Total vouchers'}
              {/if}
            </td>
            <td colspan="2" class="price-discount price" id="total_discount">
              {if $use_taxes}
                {if $priceDisplay}
                  {displayPrice price=$total_discounts_tax_exc*-1}
                {else}
                  {displayPrice price=$total_discounts*-1}
                {/if}
              {else}
                {displayPrice price=$total_discounts_tax_exc*-1}
              {/if}
            </td>
          </tr>
          {if $use_taxes}
            {if $total_tax != 0 && $show_taxes}
              {if $priceDisplay != 0}
                <tr class="cart_total_price">
                  <td colspan="4" class="text-right">{if $display_tax_label}{l s='Total (tax excl.)'}{else}{l s='Total'}{/if}</td>
                  <td colspan="2" class="price" id="total_price_without_tax">{displayPrice price=$total_price_without_tax}</td>
                </tr>
              {/if}
              <tr class="cart_total_tax">
                <td colspan="4" class="text-right">{l s='Tax'}</td>
                <td colspan="2" class="price" id="total_tax" >{displayPrice price=$total_tax}</td>
              </tr>
            {/if}
            <tr class="cart_total_price">
              <td colspan="4" class="total_price_container text-right"><span>{l s='Total'}</span></td>
              <td colspan="2" class="price" id="total_price_container">
                <span id="total_price" data-selenium-total-price="{$total_price}">{displayPrice price=$total_price}</span>
              </td>
            </tr>
          {else}
            <tr class="cart_total_price">
              {if $voucherAllowed}
                <td colspan="2" id="cart_voucher" class="cart_voucher">
                  <div id="cart_voucher" class="table_block">
                    {if $voucherAllowed}
                      <form action="{if $opc}{$link->getPageLink('order-opc', true)}{else}{$link->getPageLink('order', true)}{/if}" method="post" id="voucher">
                        <fieldset>
                          <h4>{l s='Vouchers'}</h4>
                          <input type="text" id="discount_name" class="form-control" name="discount_name" value="{if isset($discount_name) && $discount_name}{$discount_name}{/if}">
                          <input type="hidden" name="submitDiscount">
                          <button type="submit" name="submitAddDiscount" class="btn btn-primary"><span>{l s='ok'}</span></button>
                          {if $displayVouchers}
                            <p id="title" class="title_offers">{l s='Take advantage of our offers:'}</p>
                            <div id="display_cart_vouchers">
                              {foreach from=$displayVouchers item=voucher}
                                <span onclick="$('#discount_name').val('{$voucher.name}');return false;" class="voucher_name">{$voucher.name}</span> - {$voucher.description} <br>
                              {/foreach}
                            </div>
                          {/if}
                        </fieldset>
                      </form>
                    {/if}
                  </div>
                </td>
              {/if}
              <td colspan="{if !$voucherAllowed}4{else}2{/if}" class="text-right total_price_container">
                <span>{l s='Total'}</span>
              </td>
              <td colspan="2" class="price total_price_container" id="total_price_container">
                <span id="total_price" data-selenium-total-price="{$total_price_without_tax}">{displayPrice price=$total_price_without_tax}</span>
              </td>
            </tr>
          {/if}
          </tfoot>

          {if count($discounts)}
            <tbody>
            {foreach from=$discounts item=discount name=discountLoop}
              {if $discount.value_real|floatval == 0}
                {continue}
              {/if}
              <tr class="cart_discount" id="cart_discount_{$discount.id_discount}">
                <td class="cart_discount_name" colspan="{if $PS_STOCK_MANAGEMENT}3{else}2{/if}">{$discount.name}</td>
                <td class="cart_discount_price">
                  <span class="price-discount">
                    {if $discount.value_real > 0}
                      {if !$priceDisplay}
                        {displayPrice price=$discount.value_real*-1}
                      {else}
                        {displayPrice price=$discount.value_tax_exc*-1}
                      {/if}
                    {/if}
                  </span>
                </td>
                <td class="cart_discount_delete">1</td>
                <td class="cart_discount_price">
                  <span class="price-discount">
                    {if $discount.value_real > 0}
                      {if !$priceDisplay}
                        {displayPrice price=$discount.value_real*-1}
                      {else}
                        {displayPrice price=$discount.value_tax_exc*-1}
                      {/if}
                    {/if}
                  </span>
                </td>
              </tr>
            {/foreach}
            </tbody>
          {/if}
        </table>
      </div>
    {/if}
    {if $opc}
      <div id="opc_payment_methods-content">
    {/if}
    <div id="HOOK_PAYMENT">
      {$HOOK_PAYMENT}
    </div>
    {if $opc}
      </div>
    {/if}
  {else}
    <div class="alert alert-warning">{l s='No payment modules have been installed.'}</div>
  {/if}
  {if !$opc}
  <p class="cart_navigation clearfix">
    <a href="{$link->getPageLink('order', true, NULL, "step=1")|escape:'html':'UTF-8'}" title="{l s='Previous'}" class="btn btn-lg btn-outline-dark">
      <i class="fa fa-chevron-left"></i>
      {l s='Continue shopping'}
    </a>
  </p>
  {else}
</div>
{/if}
</div> {* end HOOK_TOP_PAYMENT *}
