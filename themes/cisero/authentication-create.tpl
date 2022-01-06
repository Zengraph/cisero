<form action="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}" method="post" id="account-creation_form">
  {$HOOK_CREATE_ACCOUNT_TOP}
  <div class="account_creation">
    <h3 class="page-subheading">{l s='Your personal information'}</h3>
    <p class="required"><sup>*</sup>{l s='Required field'}</p>
	<div class="title-form input-group mb-3">	
		<label class="input-group-text">{l s='Title'}</label>
		<select id="id_gender" name="id_gender" class="form-select">
			<option value="">{l s='choose your title...'}</option>
			{foreach from=$genders key=k item=gender}
				<option value="{$gender->id}" {if isset($smarty.post.id_gender) && $smarty.post.id_gender == $gender->id}selected="selected"{/if}>{$gender->name}</option>
			{/foreach}
		</select>
	</div>
    <div class="input-group mb-3">
     <span class="input-group-text" id="email">{l s='Email'} <sup>*</sup></span>
      <input type="email" class="is_required validate form-control" data-validate="isEmail" id="email" name="email" value="{if isset($smarty.post.email)}{$smarty.post.email}{/if}" required>
    </div>
    <div class="input-group mb-3">
	  <span class="input-group-text" id="customer_firstname">{l s='First name'} <sup>*</sup></span>
      <input onkeyup="$('#firstname').val(this.value);" type="text" class="is_required validate form-control" data-validate="isName" id="customer_firstname" name="customer_firstname" value="{if isset($smarty.post.customer_firstname)}{$smarty.post.customer_firstname}{/if}" required>
    </div>
    <div class="input-group mb-3">
      <span class="input-group-text" id="customer_lastname">{l s='Last name'} <sup>*</sup></span>
      <input onkeyup="$('#lastname').val(this.value);" type="text" class="is_required validate form-control" data-validate="isName" id="customer_lastname" name="customer_lastname" value="{if isset($smarty.post.customer_lastname)}{$smarty.post.customer_lastname}{/if}" required>
    </div>
    <div class="input-group mb-3">
      <span class="input-group-text" id="passwd">{l s='Password'} <sup>*</sup></span>
      <input type="password" class="is_required validate form-control" data-validate="isPasswd" name="passwd" id="passwd" placeholder="{l s='Five characters minimum'}" required>
    </div>
    <div class="input-group date-select mb-3">
		<label class="input-group-text me-2">{l s='Date of Birth'}</label>
		<select id="days" name="days" class="form-select me-2">
			<option value="">{l s='day'}</option>
			{foreach from=$days item=day}
				<option value="{$day}" {if ($sl_day == $day)} selected="selected"{/if}>{$day}&nbsp;&nbsp;</option>
			{/foreach}
		</select>
		<select id="months" name="months" class="form-select me-2">
			<option value="">{l s='month'}</option>
			{foreach from=$months key=k item=month}
				<option value="{$k}" {if ($sl_month == $k)} selected="selected"{/if}>{l s=$month}&nbsp;</option>
            {/foreach}
		</select>
		<select id="years" name="years" class="form-select">
			<option value="">{l s='year'}</option>
				{foreach from=$years item=year}
					<option value="{$year}" {if ($sl_year == $year)} selected="selected"{/if}>{$year}&nbsp;&nbsp;</option>
				{/foreach}
		</select>
    </div>
    {if isset($newsletter) && $newsletter}
		<div class="form-check">
			<input class="form-check-input" type="checkbox" name="newsletter" id="newsletter" value="" {if isset($smarty.post.newsletter) AND $smarty.post.newsletter == 1} checked="checked"{/if}>
			<label class="form-check-label" for="newsletter">
				{l s='Sign up for our newsletter!'}{if array_key_exists('newsletter', $field_required)}<sup> *</sup>{/if}
			</label>
		</div>
    {/if}
    {if isset($optin) && $optin}
		<div class="form-check">
			<input class="form-check-input" type="checkbox" name="optin" id="optin" value="" {if isset($smarty.post.optin) AND $smarty.post.optin == 1} checked="checked"{/if}>
			<label class="form-check-label"  for="optin">
				{l s='Receive special offers from our partners!'}{if array_key_exists('optin', $field_required)}<sup> *</sup>{/if}
			</label>
      </div>
    {/if}
  </div>
  
  
  {if $b2b_enable}
    <div class="account_creation">
      <h3 class="page-subheading">{l s='Your company information'}</h3>
      <div class="form-group">
        <label for="">{l s='Company'}</label>
        <input type="text" class="form-control" id="company" name="company" value="{if isset($smarty.post.company)}{$smarty.post.company}{/if}">
      </div>
      <div class="form-group">
        <label for="siret">{l s='SIRET'}</label>
        <input type="text" class="form-control" id="siret" name="siret" value="{if isset($smarty.post.siret)}{$smarty.post.siret}{/if}">
      </div>
      <div class="form-group">
        <label for="ape">{l s='APE'}</label>
        <input type="text" class="form-control" id="ape" name="ape" value="{if isset($smarty.post.ape)}{$smarty.post.ape}{/if}">
      </div>
      <div class="form-group">
        <label for="website">{l s='Website'}</label>
        <input type="text" class="form-control" id="website" name="website" value="{if isset($smarty.post.website)}{$smarty.post.website}{/if}">
      </div>
    </div>
  {/if}

  {if isset($PS_REGISTRATION_PROCESS_TYPE) && $PS_REGISTRATION_PROCESS_TYPE}
    <div class="account_creation">
      <h3 class="page-subheading">{l s='Your address'}</h3>
      {foreach from=$dlv_all_fields item=field_name}
        {if $field_name eq "company"}
          {if !$b2b_enable}
            <div class="form-group">
              <label for="company">{l s='Company'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
              <input type="text" class="form-control" id="company" name="company" value="{if isset($smarty.post.company)}{$smarty.post.company}{/if}"{if in_array($field_name, $required_fields)} required{/if}>
            </div>
          {/if}
        {elseif $field_name eq "vat_number"}
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
                {l s='Yes, I qualify for VAT Relief!'}
              </label>
            </div>
            <p id="vat-exemption-hint" class="help-block" style="display: none;">
              {l s='You\'ll get asked to verify your qualification.'}
            </p>
          {/if}
          <div id="vat_number" style="display:none;">
            <div class="form-group">
              <label for="vat_number">{l s='VAT number'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
              <input type="text" class="form-control" id="vat_number" name="vat_number" value="{if isset($smarty.post.vat_number)}{$smarty.post.vat_number}{/if}"{if in_array($field_name, $required_fields)} required{/if}>
            </div>
          </div>
        {elseif $field_name eq "firstname"}
          <div class="required form-group">
            <label for="firstname">{l s='First name'} <sup>*</sup></label>
            <input type="text" class="form-control" id="firstname" name="firstname" value="{if isset($smarty.post.firstname)}{$smarty.post.firstname}{/if}" required>
          </div>
        {elseif $field_name eq "lastname"}
          <div class="required form-group">
            <label for="lastname">{l s='Last name'} <sup>*</sup></label>
            <input type="text" class="form-control" id="lastname" name="lastname" value="{if isset($smarty.post.lastname)}{$smarty.post.lastname}{/if}" required>
          </div>
        {elseif $field_name eq "address1"}
          <div class="required form-group">
            <label for="address1">{l s='Address'} <sup>*</sup></label>
            <input type="text" class="form-control" name="address1" id="address1" value="{if isset($smarty.post.address1)}{$smarty.post.address1}{/if}" required>
            <p class="help-block">{l s='Street address, P.O. Box, Company name, etc.'}</p>
          </div>
        {elseif $field_name eq "address2"}
          <div class="form-group is_customer_param">
            <label for="address2">{l s='Address (Line 2)'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
            <input type="text" class="form-control" name="address2" id="address2" value="{if isset($smarty.post.address2)}{$smarty.post.address2}{/if}"{if in_array($field_name, $required_fields)} required{/if}>
            <p class="help-block">{l s='Apartment, suite, unit, building, floor, etc...'}</p>
          </div>
        {elseif $field_name eq "postcode"}
          {assign var='postCodeExist' value=true}
          <div class="required postcode form-group">
            <label for="postcode">{l s='Zip/Postal Code'} <sup>*</sup></label>
            <input type="text" class="validate form-control" name="postcode" id="postcode" data-validate="isPostCode" value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{/if}">
          </div>
        {elseif $field_name eq "city"}
          <div class="required form-group">
            <label for="city">{l s='City'} <sup>*</sup></label>
            <input type="text" class="form-control" name="city" id="city" value="{if isset($smarty.post.city)}{$smarty.post.city}{/if}" required>
          </div>
          {* if customer hasn't update his layout address, country has to be verified but it's deprecated *}
        {elseif $field_name eq "Country:name" || $field_name eq "country"}
          <div class="required select form-group">
            <label for="id_country">{l s='Country'} <sup>*</sup></label>
            <select name="id_country" id="id_country" class="form-control" required>
              <option value="">-</option>
              {foreach from=$countries item=v}
                <option value="{$v.id_country}"{if (isset($smarty.post.id_country) AND $smarty.post.id_country == $v.id_country) OR (!isset($smarty.post.id_country) && $sl_country == $v.id_country)} selected="selected"{/if}>{$v.name}</option>
              {/foreach}
            </select>
          </div>
        {elseif $field_name eq "State:name" || $field_name eq 'state'}
          {assign var='stateExist' value=true}
          <div class="required id_state select form-group">
            <label for="id_state">{l s='State'} <sup>*</sup></label>
            <select name="id_state" id="id_state" class="form-control" required>
              <option value="">-</option>
            </select>
          </div>
        {/if}
      {/foreach}
      {if $postCodeExist eq false}
        <div class="required postcode form-group unvisible">
          <label for="postcode">{l s='Zip/Postal Code'} <sup>*</sup></label>
          <input type="text" class="validate form-control" name="postcode" id="postcode" data-validate="isPostCode" value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{/if}">
        </div>
      {/if}
      {if $stateExist eq false}
        <div class="required id_state select unvisible form-group">
          <label for="id_state">{l s='State'} <sup>*</sup></label>
          <select name="id_state" id="id_state" class="form-control">
            <option value="">-</option>
          </select>
        </div>
      {/if}
      <div class="textarea form-group">
        <label for="other">{l s='Additional information'}</label>
        <textarea class="form-control" name="other" id="other" cols="26" rows="3">{if isset($smarty.post.other)}{$smarty.post.other}{/if}</textarea>
      </div>
      <div class="form-group">
        <label for="phone">{l s='Home phone'}{if isset($one_phone_at_least) && $one_phone_at_least} <sup>**</sup>{/if}</label>
        <input type="text" class="form-control" name="phone" id="phone" value="{if isset($smarty.post.phone)}{$smarty.post.phone}{/if}">
      </div>
      <div class="{if isset($one_phone_at_least) && $one_phone_at_least}required {/if}form-group">
        <label for="phone_mobile">{l s='Mobile phone'}{if isset($one_phone_at_least) && $one_phone_at_least} <sup>**</sup>{/if}</label>
        <input type="text" class="form-control" name="phone_mobile" id="phone_mobile" value="{if isset($smarty.post.phone_mobile)}{$smarty.post.phone_mobile}{/if}">
      </div>
      {if isset($one_phone_at_least) && $one_phone_at_least}
        {assign var="atLeastOneExists" value=true}
        <p class="help-block required">** {l s='You must register at least one phone number.'}</p>
      {/if}
      <div class="required form-group" id="address_alias">
        <label for="alias">{l s='Assign an address alias for future reference.'} <sup>*</sup></label>
        <input type="text" class="form-control" name="alias" id="alias" value="{if isset($smarty.post.alias)}{$smarty.post.alias}{else}{l s='My address'}{/if}" required>
      </div>
    </div>
    <div class="account_creation dni">
      <h3 class="page-subheading">{l s='Tax identification'}</h3>
      <div class="required form-group">
        <label for="dni">{l s='Identification number'} <sup>*</sup></label>
        <input type="text" class="form-control" name="dni" id="dni" value="{if isset($smarty.post.dni)}{$smarty.post.dni}{/if}">
        <p class="help-block">{l s='DNI / NIF / NIE'}</p>
      </div>
    </div>
  {/if}
  {$HOOK_CREATE_ACCOUNT_FORM}
  <div class="submit clearfix mt-4">
	<input type="hidden" name="email_create" value="1">
    <input type="hidden" name="is_new_customer" value="1">
    {if isset($back)}<input type="hidden" class="hidden" name="back" value="{$back|escape:'html':'UTF-8'}">{/if}
    <button type="submit" name="submitAccount" id="submitAccount" class="btn btn-lg btn-dark">
      {l s='Register'} <i class="fa fa-chevron-right"></i>
    </button>
  </div>
</form>
