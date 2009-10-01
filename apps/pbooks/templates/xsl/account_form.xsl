<!--
Program: PBooks
Component: account_form.xsl
Copyright: Savonix Corporation
Author: Albert L. Lash, IV
License: Gnu Affero Public License version 3
http://www.gnu.org/licenses

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program; if not, see http://www.gnu.org/licenses
or write to the Free Software Foundation, Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301 USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml">
	<xsl:include href="html_main.xsl"/>
	<xsl:template name="content">
		<xsl:param name="link_prefix"/>
		<xsl:param name="path_prefix"/>
		<xsl:param name="i18n"/>
    <xsl:variable name="this_account"
    select="/_R_/account_get_by_id/account_get_by_id" />
    <xsl:variable name="account_meta"
    select="/_R_/account_meta_get/account_meta_get" />

<!--
The form is validated via a javascript library included in the end of
main.xsl. Form input elements have attributes like required="1" if they are
to be validated.
-->

<form method="post" onSubmit="return validateStandard(this, 'myerror');">
  <div class="tableframe">

    <!-- Check if the user is creating a new account or editing and existing one,
    and set appropriate parameter "my_action" -->
    <xsl:if test="$this_account/id">
      <input type="hidden" name="my_action" value="update"/>
      <input type="hidden" value="{$this_account/id}" name="account_id"/>
    </xsl:if>
    <xsl:if test="not($this_account/id)">
      <input type="hidden" name="my_action" value="create"/>
    </xsl:if>

    <!-- If there is already an account with the same name, display error. -->
    <xsl:if test="//account_duplicate_check">
      <div class="error" id="my_error">
        <img src="{$path_prefix}{/_R_/runtime/icon_set}/exclamation.png"/>
        Error: <xsl:value-of select="//error[key='account_duplicate']/value"/>
      </div>
    </xsl:if>
    <!-- End error -->

    <table class="form-table" style="width: 100%">
      <tbody>
      <tr>
        <th>
          <label for="name">
            <span id="i18n-account_name">Account Name</span>
          </label>
        </th>
        </td>
        <td>
          <input type="text" name="name" id="name"
          value="{$this_account/name|//_post/name}"
          required="1" err="{//error[key='missing_account_name']/value}" />
        </td>
      </tr>
      <tr>
        <th>
          <label for="account_type_id">
            <span id="i18n-account_type">Account Type</span>
          </label>
        </th>
        <td>
          <select name="account_type_id" id="account_type_id">
            <option>
              <xsl:value-of select="$i18n/select_one"/>
            </option>
            <xsl:for-each select="//account_types/account_type">
              <option value="{account_type_id}">
                <xsl:if test="$this_account/account_type_id=account_type_id or
                //_post/account_type_id=account_type_id">
                  <xsl:attribute name="selected">selected</xsl:attribute>
                </xsl:if>
                <xsl:value-of select="name"/>
              </option>
            </xsl:for-each>
          </select>
        </td>
      </tr>
      <tr>
        <th>
          <label for="account_number">
            <span id="i18n-account_number">Account Number</span>
          </label>
        </th>
        <td>
          <input type="text" name="account_number" required="1"
          err="{//error[key='missing_account_number']/value}"
          value="{$this_account/account_number|//_post/account_number}"/>
        </td>
      </tr>
      <tr>
        <th>
          <label for="description">
            <span id="i18n-description">Description</span>
          </label>
        </th>
        <td>
          <textarea name="description" id="description" cols="40" rows="2">
            <xsl:value-of select="$this_account/description|//_post/description"/>
          </textarea>
        </td>
      </tr>
      <tr>
        <th>
          <label for="reconciled">
            <span id="i18n-reconciled">Reconciled</span>
          </label>
        </th>
        <td>
          <input type="text" name="reconciled" id="reconciled" required="1"
          err="{//error[key='reconciled']/value}"
          value="{$account_meta[meta_key='reconciled']/meta_value|//_post/reconciled}"/>
        </td>
      </tr>
      <tr>
        <th>
          <span id="i18n-has_checks">Has Checks</span>
        </th>
        <td>
          <input type="radio" name="has_checks" id="has_checks_on" value="on">
            <xsl:if test="$account_meta[meta_key='has_checks']/meta_value='on'">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
          </input>
          <label for="has_checks_on">
            <span id="i18n-yes">Yes</span>
          </label>
          <br/>
          <input type="radio" name="has_checks" id="has_checks_off" value="off">
            <xsl:if test="not($account_meta[meta_key='has_checks']/meta_value='on')">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
          </input>
          <label for="has_checks_off">
            <span id="i18n-no">No</span>
          </label>
      </td>
      </tr>
      <tr>
        <th>
          <label for="takes_deposits">
            <span id="i18n-takes_deposits">Takes Deposits</span>
          </label>
        </th>
        <td>
          <input type="radio" name="takes_deposits" value="on">
            <xsl:if test="$account_meta[meta_key='has_checks']/meta_value='on'">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
          </input>Yes<br/>
          <input type="radio" name="takes_deposits" value="off">
            <xsl:if test="not($account_meta[meta_key='has_checks']/meta_value='on')">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
          </input>No
        </td>
      </tr>
      <tr>
        <td>
          <xsl:value-of select="$i18n/accounts_receivable_account"/>:
        </td>
        <td>
          <input type="radio" name="accounts_receivable_account" value="on">
            <xsl:if test="$account_meta[meta_key='accounts_receivable_account']/meta_value='on'">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
          </input>Yes<br/>
          <input type="radio" name="accounts_receivable_account" value="off">
            <xsl:if test="not($account_meta[meta_key='accounts_receivable_account']/meta_value='on')">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
          </input>No<br/>
        </td>
      </tr>
      <tr>
        <td>
          <xsl:value-of select="$i18n/cash_account"/>:
        </td>
        <td>
          <input type="radio" name="cash_account" value="on">
            <xsl:if test="$account_meta[meta_key='cash_account']/meta_value='on'">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
          </input>Yes
          <br/>
          <input type="radio" name="cash_account" value="off">
            <xsl:if test="not($account_meta[meta_key='cash_account']/meta_value='on')">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
          </input>No
        </td>
      </tr>
      <tr>
        <td>
          <xsl:value-of select="$i18n/account_closed"/>:
        </td>
        <td>
          <input type="radio" name="account_closed" value="on">
            <xsl:if test="$account_meta[meta_key='account_closed']/meta_value='on'">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
          </input>Yes
          <br/>
          <input type="radio" name="account_closed" value="off">
            <xsl:if test="not($account_meta[meta_key='account_closed']/meta_value='on')">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
          </input>No
        </td>
      </tr>
      <tr>
        <td>
          <xsl:value-of select="$i18n/group"/>:
        </td>
        <td>
          <select name="group_id">
            <xsl:for-each select="//get_account_groups/get_account_groups">
              <xsl:variable name="my_group_id" select="id"/>
              <option value="{id}">
                <xsl:if test="$this_account/group_id=id">
                  <xsl:attribute name="selected">selected</xsl:attribute>
                </xsl:if>
                <xsl:value-of select="name"/>
              </option>
            </xsl:for-each>
          </select>
        </td>
      </tr>
      <tr>
        <td>
          <xsl:value-of select="$i18n/hide"/>:
        </td>
        <td>
          <input type="checkbox" name="hide">
            <xsl:if test="$this_account/hide='on'">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
          </input>
        </td>
      </tr>
    </table>
  </div>
  <div style="text-align: center; margin-top: 10px;" class="table_meta">
    <input type="submit" value="{$i18n/save}" name="submit" />
    <input type="button" value="{$i18n/cancel}"
      onclick="window.location.href='{$link_prefix}accounts'"/>
  </div>
</form>


	</xsl:template>
</xsl:stylesheet>
