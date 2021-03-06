{* Assign a value to 'current_step' to display current style *}
{capture name="url_back"}
  {if isset($back) && $back}back={$back}{/if}
{/capture}
{if !isset($multi_shipping)}
  {assign var='multi_shipping' value='0'}
{/if}
{if !$opc && ((!isset($back) || empty($back)) || (isset($back) && preg_match("/[&?]step=/", $back)))}
  {if $current_step=='summary'}
    {$step_num = 1}
  {elseif $current_step=='login'}
    {$step_num = 2}
  {elseif $current_step=='address'}
    {$step_num = 2}
  {elseif $current_step=='shipping'}
    {$step_num = 2}
  {elseif $current_step=='payment'}
    {$step_num = 3}
  {/if}
  <ul id="order_step" class="nav nav-pills nav-justified mb-3">
    <li class="nav-item">
      {if $current_step=='summary' || $current_step=='payment' || $current_step=='shipping' || $current_step=='address' || $current_step=='login'}
        <a class="nav-link{if $step_num > 1} completed{elseif $step_num == 1} active{/if}" href="{$link->getPageLink('order', true)}">
          01. {l s='Summary'}
        </a>
      {else}
        <a class="nav-link" href="javascript:;">01. {l s='Summary'}</a>
      {/if}
    </li>
    <li class="nav-item">
      {if $current_step=='address' || $current_step=='payment' || $current_step=='shipping'}
        <a class="nav-link{if $step_num > 2} completed{elseif $step_num == 2} active{else} not-completed{/if}" href="{$link->getPageLink('order', true, NULL, "{$smarty.capture.url_back}&step=1{if $multi_shipping}&multi-shipping={$multi_shipping}{/if}")|escape:'html':'UTF-8'}">
          02. {l s='Address'}
        </a>
      {else}
        <a class="nav-link" href="javascript:;">02. {l s='Address'}</a>
      {/if}
    </li>
    <li class="nav-item">
      <a class="nav-link{if $step_num == 3} active{else} not-completed{/if}" href="javascript:;">03. {l s='Payment'}</a>
    </li>
  </ul>
{/if}
