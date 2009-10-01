<!--
Program: PBooks
Component: common_js_functions.js.xsl
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
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="text" indent="yes" encoding="UTF-8" omit-xml-declaration="yes"/>
	<xsl:strip-space elements="*"/>
	<xsl:template match="/">
function journal_entry_amount_delete(entry_amount_id) {
  $.post("<xsl:value-of select="//link_prefix"/>x-journal-entry-amount-delete",
  {
    'entry_amount_id': entry_amount_id
  },
  function (data){
    $("#ea_"+entry_amount_id).remove();
  });
}

function invoice_paid(invoice_number, invoice_entry_id) {
    $.ajax({
      type: "POST",
      url: "<xsl:value-of select="//link_prefix"/>x-invoice-paid",
      data: {
        'invoice_id': invoice_number,
        'invoice_entry_id': invoice_entry_id
      },
      success: function (res){
        $("#p_"+invoice_number).replaceWith("Paid");
      }
    });
}

function journal_entry_amount_create(entry_type_id,entry_id) {
  var this_entry_date = $("#invoice_date").val();
  $.ajax({
    url: "<xsl:value-of select="//link_prefix"/>x-journal-entry-new-"+entry_type_id+"&amp;entry_id="+entry_id,
    type: "POST",
    async: false,
    data: ({
      'entry_id': entry_id,
      'entry_datetime': this_entry_date
    }),
    success: function(response){
      window.location.reload();
    }
  });
}

function post_entry(entry_id,account_id,entry_type_id,entry_amount_id,account_type_id) {
  $("#"+entry_amount_id).removeAttr("onclick");
  $("#"+entry_amount_id).fadeTo("slow", 0.33);
  $.post("<xsl:value-of select="//link_prefix"/>x-ledger-create",
  {
    'entry_id':        entry_id,
    'account_id':      account_id,
    'type':            entry_type_id,
    'entry_amount_id': entry_amount_id,
    'account_type_id': account_type_id
  },
  function (data){
    $("#"+entry_amount_id).remove();
  });
}

function journal_entry_location(entry_id) {
  location.href = "<xsl:value-of select="//link_prefix"/>journal-entry&amp;entry_id="+entry_id;
}

$(document).ready(function() {
  $('#my_debit_amount').val($('.credit_amounts').sum());
});
  </xsl:template>
</xsl:stylesheet>
