{capture name=path}
  <a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}">{l s='My account'}</a>
  <span class="navigation-pipe">{$navigationPipe}</span>
  <span class="navigation_page">{l s='Your personal information'}</span>
{/capture}

<div class="box">
  <h1 class="page-subheading">{l s='Your personal information'}</h1>

  {include file="$tpl_dir./errors.tpl"}

  {if isset($confirmation) && $confirmation}
    <div class="alert alert-success">
      {l s='Your personal information has been successfully updated.'}
      {if isset($pwd_changed)}<br>{l s='Your password has been sent to your email:'} {$email}{/if}
    </div>
  {else}
    <p>
      <b>{l s='Please be sure to update your personal information if it has changed.'}</b>
    </p>
    <p class="required">
      <sup>*</sup>{l s='Required field'}
    </p>
    <form action="{$link->getPageLink('identity', true)|escape:'html':'UTF-8'}" method="post" class="std">
      <fieldset>
		<div class="title-form input-group mb-3">	
			<label class="input-group-text">{l s='Social title'}</label>
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
			<span class="input-group-text" id="firstname">{l s='First name'} <sup>*</sup></span>
			<input type="text" class="is_required validate form-control" data-validate="isName" id="firstname" name="firstname" value="{if isset($smarty.post.firstname)}{$smarty.post.firstname}{/if}" required>
        </div>
        <div class="required input-group mb-3">
          <span class="input-group-text" id="lastname">{l s='Last name'}</span>
          <input class="is_required validate form-control" data-validate="isName" type="text" name="lastname" id="lastname" value="{if isset($smarty.post.lastname)}{$smarty.post.lastname}{/if}" required>
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
        <div class="required input-group mb-3">
          <span class="input-group-text" id="old_passwd">{l s='Current Password'}</span>
          <input class="is_required validate form-control" type="password" data-validate="isPasswd" name="old_passwd" id="old_passwd" required>
        </div>
        <div class="password input-group mb-3">
          <span class="input-group-text" id="passwd">{l s='New Password'}</span>
          <input class="is_required validate form-control" type="password" data-validate="isPasswd" name="passwd" id="passwd">
        </div>
        <div class="password input-group mb-3">
          <span class="input-group-text" id="confirmation">{l s='Confirmation'}</span>
          <input class="is_required validate form-control" type="password" data-validate="isPasswd" name="confirmation" id="confirmation">
        </div>
        {if isset($newsletter) && $newsletter}
          <div class="form-check mb-1">
			<input class="form-check-input" type="checkbox" id="newsletter" name="newsletter" value="1" {if isset($smarty.post.newsletter) && $smarty.post.newsletter == 1} checked="checked"{/if}>
			<label class="form-check-label" for="newsletter">
				{l s='Sign up for our newsletter!'}
            </label>
          </div>
        {/if}
        {if isset($optin) && $optin}
          <div class="form-check mb-1">
			<input class="form-check-input" type="checkbox" name="optin" id="optin" value="1" {if isset($smarty.post.optin) && $smarty.post.optin == 1} checked="checked"{/if}>
			<label class="form-check-label" for="optin">
				{l s='Receive special offers from our partners!'}
			</label>
          </div>
        {/if}
        {if $b2b_enable}
          <h1 class="page-subheading">{l s='Your company information'}</h1>
          <div class="form-group">
            <label for="company">{l s='Company'}</label>
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
        {/if}
        {if isset($HOOK_CUSTOMER_IDENTITY_FORM)}
          {$HOOK_CUSTOMER_IDENTITY_FORM}
        {/if}
        <div class="form-group">
          <button type="submit" name="submitIdentity" class="btn btn-lg btn-dark my-3">
            <span>{l s='Save'} <i class="icon icon-chevron-right"></i></span>
          </button>
        </div>
      </fieldset>
    </form>
  {/if}
</div>

<nav>
	<button type="button" class="btn btn-outline-dark">
		<a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}">
			{if $isRtl}&rarr;{else}&larr;{/if} {l s='Back to your account'}
		</a>
	</button>
</nav>
