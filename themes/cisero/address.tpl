{capture name=path}
  <a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}">{l s='My account'}</a>
  <span class="navigation-pipe">{$navigationPipe}</span>
  <a href="{$link->getPageLink('addresses', true)|escape:'html':'UTF-8'}">{l s='My addresses'}</a>
  {if !empty($id_address)}{l s='Edit address'}{else}{l s='Add a new address'}{/if}
{/capture}

<div class="box">
  <h1 class="page-subheading">{l s='Your address'}</h1>
  <p>
    <b>
      {if isset($id_address) && (isset($smarty.post.alias) || isset($address->alias))}
        {l s='Modify address'}
        {if isset($smarty.post.alias)}
          "{$smarty.post.alias}"
        {else}
          {if isset($address->alias)}"{$address->alias|escape:'html':'UTF-8'}"{/if}
        {/if}
      {else}
        {l s='To add a new address, please fill out the form below.'}
      {/if}
    </b>
  </p>
  {include file="$tpl_dir./errors.tpl"}
  <p class="required"><sup>*</sup>{l s='Required field'}</p>
  <form action="{$link->getPageLink('address', true)|escape:'html':'UTF-8'}" method="post" class="std" id="add_address">
    {assign var="stateExist" value=false}
    {assign var="postCodeExist" value=false}
    {assign var="dniExist" value=false}
    {assign var="homePhoneExist" value=false}
    {assign var="mobilePhoneExist" value=false}
    {assign var="atLeastOneExists" value=false}
    {assign var="phoneIsRequired" value=(isset($required_fields) && (in_array('phone', $required_fields) || in_array('phone_mobile', $required_fields)))}
    {foreach from=$ordered_adr_fields item=field_name}
      {if $field_name eq 'company'}
        <div class="input-group mb-3">
		  <span class="input-group-text">{l s='Company'}{if isset($required_fields) && in_array($field_name, $required_fields)} <sup>*</sup>{/if}</span>
          <input class="form-control validate" data-validate="{$address_validation.$field_name.validate}" type="text" id="company" name="company" value="{if isset($smarty.post.company)}{$smarty.post.company}{else}{if isset($address->company)}{$address->company|escape:'html':'UTF-8'}{/if}{/if}" {if isset($required_fields) && in_array($field_name, $required_fields)}required{/if}>
        </div>
      {/if}
      {if $field_name eq 'vat_number'}
        <div id="vat_area">
          {if isset($vat_display) && $vat_display >= 3}
            <div class="checkbox">
              <label for="vat-exemption">
                <input
                        type="checkbox"
                        name="vat_exemption"
                        id="vat-exemption"
                        value="1"
                        {if (isset($address->vat_exemption) && $address->vat_exemption)
                        || (isset($address->vat_number) && strlen($address->vat_number))}
                          checked="checked"
                        {/if}
                >
                <span class="label-text">
                {l s='Yes, I qualify for VAT Relief!'}
                </span>
              </label>
            </div>
            <p id="vat-exemption-hint" class="help-block" style="display: none;">
              {l s='You\'ll get asked to verify your qualification.'}
            </p>
          {/if}
          <div id="vat_number">
            <div class="input-group mb-3">
              <label for="vat-number">{l s='VAT number'}{if isset($required_fields) && in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
              <input type="text" class="form-control validate" data-validate="{$address_validation.$field_name.validate}" id="vat-number" name="vat_number" value="{if isset($smarty.post.vat_number)}{$smarty.post.vat_number}{else}{if isset($address->vat_number)}{$address->vat_number|escape:'html':'UTF-8'}{/if}{/if}" {if isset($required_fields) && in_array($field_name, $required_fields)}required{/if}>
            </div>
          </div>
        </div>
      {/if}
      {if $field_name eq 'dni'}
        {assign var="dniExist" value=true}
        <div class="required input-group mb-3 dni">
          <label for="dni">{l s='Identification number'} <sup>*</sup></label>
          <input class="form-control" data-validate="{$address_validation.$field_name.validate}" type="text" name="dni" id="dni" value="{if isset($smarty.post.dni)}{$smarty.post.dni}{else}{if isset($address->dni)}{$address->dni|escape:'html':'UTF-8'}{/if}{/if}">
          <p class="help-block">{l s='DNI / NIF / NIE'}</p>
        </div>
      {/if}
      {if $field_name eq 'firstname'}		
		<div class="required input-group mb-3">
			<span class="input-group-text">{l s='First name'} <sup>*</sup></span>
			<input class="is_required validate form-control" data-validate="{$address_validation.$field_name.validate}" type="text" name="firstname" id="firstname" value="{if isset($smarty.post.firstname)}{$smarty.post.firstname}{else}{if isset($address->firstname)}{$address->firstname|escape:'html':'UTF-8'}{/if}{/if}" required>
		</div>
      {/if}
      {if $field_name eq 'lastname'}
        <div class="required input-group mb-3">
		  <span class="input-group-text">{l s='Last name'} <sup>*</sup></span>
          <input class="is_required validate form-control" data-validate="{$address_validation.$field_name.validate}" type="text" id="lastname" name="lastname" value="{if isset($smarty.post.lastname)}{$smarty.post.lastname}{else}{if isset($address->lastname)}{$address->lastname|escape:'html':'UTF-8'}{/if}{/if}" required>
        </div>
      {/if}
      {if $field_name eq 'address1'}
        <div class="required input-group mb-3">
		  <span class="input-group-text">{l s='Address'} <sup>*</sup></span>
          <input class="is_required validate form-control" data-validate="{$address_validation.$field_name.validate}" type="text" id="address1" name="address1" value="{if isset($smarty.post.address1)}{$smarty.post.address1}{else}{if isset($address->address1)}{$address->address1|escape:'html':'UTF-8'}{/if}{/if}" required>
        </div>
      {/if}
      {if $field_name eq 'address2'}
        <div class="required input-group mb-3">
		 <span class="input-group-text">{l s='Address (Line 2)'}{if isset($required_fields) && in_array($field_name, $required_fields)} <sup>*</sup>{/if}</span>		  
		 <input class="validate form-control" data-validate="{$address_validation.$field_name.validate}" type="text" id="address2" name="address2" value="{if isset($smarty.post.address2)}{$smarty.post.address2}{else}{if isset($address->address2)}{$address->address2|escape:'html':'UTF-8'}{/if}{/if}" {if isset($required_fields) && in_array($field_name, $required_fields)}required{/if}>
        </div>
      {/if}
      {if $field_name eq 'postcode'}
        {assign var="postCodeExist" value=true}
        <div class="required postcode input-group mb-3 unvisible">
          <span class="input-group-text">{l s='Zip/Postal Code'} <sup>*</sup></span>
          <input class="is_required validate form-control" data-validate="{$address_validation.$field_name.validate}" type="text" id="postcode" name="postcode" value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{else}{if isset($address->postcode)}{$address->postcode|escape:'html':'UTF-8'}{/if}{/if}">
        </div>
      {/if}
      {if $field_name eq 'city'}
        <div class="required input-group mb-3">
		  <span class="input-group-text">{l s='City'} <sup>*</sup></span>
          <input class="is_required validate form-control" data-validate="{$address_validation.$field_name.validate}" type="text" name="city" id="city" value="{if isset($smarty.post.city)}{$smarty.post.city}{else}{if isset($address->city)}{$address->city|escape:'html':'UTF-8'}{/if}{/if}" maxlength="64" required>
        </div>
        {* if customer hasn't update his layout address, country has to be verified but it's deprecated *}
      {/if}
      {if $field_name eq 'Country:name' || $field_name eq 'country' || $field_name eq 'Country:iso_code'}
        <div class="required input-group mb-3">
          <span class="input-group-text">{l s='Country'} <sup>*</sup></span>
          <select id="id_country" class="form-control" name="id_country" required>{$countries_list}</select>
        </div>
      {/if}
      {if $field_name eq 'State:name'}
        {assign var="stateExist" value=true}
        <div class="required id_state input-group mb-3">
          <span class="input-group-text">{l s='State'} <sup>*</sup></span>
          <select name="id_state" id="id_state" class="form-control">
            <option value="">-</option>
          </select>
        </div>
      {/if}
      {if $field_name eq 'phone'}
        {assign var="homePhoneExist" value=true}
        {assign var="isRequired" value=(isset($required_fields) && in_array($field_name, $required_fields))}
        <div class="input-group phone-number mb-3">
         <span class="input-group-text">{l s='Home phone'}
            {if $isRequired}
              <sup>*</sup>
            {elseif isset($one_phone_at_least) && $one_phone_at_least && !$phoneIsRequired}
              <sup>**</sup>
            {/if}
          </span>
          <input class="{if isset($one_phone_at_least) && $one_phone_at_least}is_required{/if} validate form-control" data-validate="{$address_validation.phone.validate}" type="tel" id="phone" name="phone" value="{if isset($smarty.post.phone)}{$smarty.post.phone}{else}{if isset($address->phone)}{$address->phone|escape:'html':'UTF-8'}{/if}{/if}">
        </div>
      {/if}
      {if $field_name eq 'phone_mobile'}
        {assign var="mobilePhoneExist" value=true}
        {assign var="isRequired" value=(isset($required_fields) && in_array($field_name, $required_fields))}
        <div class="{if isset($one_phone_at_least) && $one_phone_at_least}required {/if}input-group mb-3">
         <span class="input-group-text">{l s='Mobile phone'}
            {if $isRequired}
              <sup>*</sup>
            {elseif isset($one_phone_at_least) && $one_phone_at_least && !$phoneIsRequired}
              <sup>**</sup>
            {/if}
          </span>
          <input class="validate form-control" data-validate="{$address_validation.phone_mobile.validate}" type="tel" id="phone_mobile" name="phone_mobile" value="{if isset($smarty.post.phone_mobile)}{$smarty.post.phone_mobile}{else}{if isset($address->phone_mobile)}{$address->phone_mobile|escape:'html':'UTF-8'}{/if}{/if}">
        </div>
      {/if}
      {if (($field_name eq 'phone') || ($field_name eq 'phone_mobile')) && !isset($atLeastOneExists) && isset($one_phone_at_least) && $one_phone_at_least && !$phoneIsRequired}
        {assign var="atLeastOneExists" value=true}
        <div class="alert alert-info required" role="alert">** {l s='You must register at least one phone number.'}</div>
      {/if}
    {/foreach}
    {if !$postCodeExist}
      <div class="required postcode form-group unvisible">
        <label for="postcode">{l s='Zip/Postal Code'} <sup>*</sup></label>
        <input class="is_required validate form-control" data-validate="{$address_validation.postcode.validate}" type="text" id="postcode" name="postcode" value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{else}{if isset($address->postcode)}{$address->postcode|escape:'html':'UTF-8'}{/if}{/if}">
      </div>
    {/if}
    {if !$stateExist}
      <div class="required id_state form-group unvisible">
        <label for="id_state">{l s='State'} <sup>*</sup></label>
        <select name="id_state" id="id_state" class="form-control">
          <option value="">-</option>
        </select>
      </div>
    {/if}
    {if !$dniExist}
      <div class="required dni form-group unvisible">
        <label for="dni">{l s='Identification number'} <sup>*</sup></label>
        <input class="is_required form-control" data-validate="{$address_validation.dni.validate}" type="text" name="dni" id="dni" value="{if isset($smarty.post.dni)}{$smarty.post.dni}{else}{if isset($address->dni)}{$address->dni|escape:'html':'UTF-8'}{/if}{/if}">
        <p class="help-block">{l s='DNI / NIF / NIE'}</p>
      </div>
    {/if}
    {if !$homePhoneExist}
      <div class="form-group phone-number">
        <label for="phone">{l s='Home phone'}</label>
        <input class="{if isset($one_phone_at_least) && $one_phone_at_least}is_required{/if} validate form-control" data-validate="{$address_validation.phone.validate}" type="tel" id="phone" name="phone" value="{if isset($smarty.post.phone)}{$smarty.post.phone}{else}{if isset($address->phone)}{$address->phone|escape:'html':'UTF-8'}{/if}{/if}">
      </div>
    {/if}
    {if !$mobilePhoneExist}
      <div class="{if isset($one_phone_at_least) && $one_phone_at_least}required {/if}form-group">
        <label for="phone_mobile">{l s='Mobile phone'}{if isset($one_phone_at_least) && $one_phone_at_least} <sup>**</sup>{/if}</label>
        <input class="validate form-control" data-validate="{$address_validation.phone_mobile.validate}" type="tel" id="phone_mobile" name="phone_mobile" value="{if isset($smarty.post.phone_mobile)}{$smarty.post.phone_mobile}{else}{if isset($address->phone_mobile)}{$address->phone_mobile|escape:'html':'UTF-8'}{/if}{/if}">
      </div>
    {/if}
    {if isset($one_phone_at_least) && $one_phone_at_least && !$atLeastOneExists && !$phoneIsRequired}
      <p class="alert alert-info required" role="alert">** {l s='You must register at least one phone number.'}</p>
    {/if}
	<div class="input-group mb-3">
      <span class="input-group-text">{l s='Additional information'}</span>
      <textarea class="validate form-control" data-validate="{$address_validation.other.validate}" id="other" name="other" cols="26" rows="3" >{if isset($smarty.post.other)}{$smarty.post.other}{else}{if isset($address->other)}{$address->other|escape:'html':'UTF-8'}{/if}{/if}</textarea>
    </div>
    <div class="required form-group mb-3" id="adress_alias">
      <label for="alias" class="form-label">{l s='Please assign an address title for future reference.'} <sup>*</sup></label>
      <input type="text" id="alias" class="is_required validate form-control" data-validate="{$address_validation.alias.validate}" name="alias" value="{if isset($smarty.post.alias)}{$smarty.post.alias}{elseif isset($address->alias)}{$address->alias|escape:'html':'UTF-8'}{elseif !$select_address}{l s='My address'}{/if}" required>
    </div>
    <div class="submit2">
      {if isset($id_address)}<input type="hidden" name="id_address" value="{$id_address|intval}">{/if}
      {if isset($back)}<input type="hidden" name="back" value="{$back}">{/if}
      {if isset($mod)}<input type="hidden" name="mod" value="{$mod}">{/if}
      {if isset($select_address)}<input type="hidden" name="select_address" value="{$select_address|intval}">{/if}
      <input type="hidden" name="token" value="{$token}">
      <button type="submit" name="submitAddress" id="submitAddress" class="btn btn-lg btn-dark mb-3">
        <span>
          {l s='Save'}
          <i class="icon icon-chevron-right"></i>
        </span>
      </button>
    </div>
  </form>
</div>

<nav>
	<button type="button" class="btn btn-outline-dark">
      <a href="{$link->getPageLink('addresses', true)|escape:'html':'UTF-8'}">
        {if $isRtl}&rarr;{else}&larr;{/if} {l s='Back to your addresses'}
      </a>
	</button>
</nav>

{strip}
  {if isset($smarty.post.id_state) && $smarty.post.id_state}
    {addJsDef idSelectedState=$smarty.post.id_state|intval}
  {elseif isset($address->id_state) && $address->id_state}
    {addJsDef idSelectedState=$address->id_state|intval}
  {else}
    {addJsDef idSelectedState=false}
  {/if}
  {if isset($smarty.post.id_country) && $smarty.post.id_country}
    {addJsDef idSelectedCountry=$smarty.post.id_country|intval}
  {elseif isset($address->id_country) && $address->id_country}
    {addJsDef idSelectedCountry=$address->id_country|intval}
  {else}
    {addJsDef idSelectedCountry=false}
  {/if}
  {if isset($countries)}
    {addJsDef countries=$countries}
  {/if}
  {if isset($vatnumber_ajax_call) && $vatnumber_ajax_call}
    {addJsDef vatnumber_ajax_call=$vatnumber_ajax_call}
  {/if}
{/strip}