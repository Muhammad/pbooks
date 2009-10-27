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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
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

function account_delete(id) {
    if(confirm('Are you sure?')) {
        $.post("<xsl:value-of select="//link_prefix"/>accounts-delete", {'id': id},
        function (data){
          $("#a_"+id).remove();
        });
    }
}

function account_group_delete(group_id) {
  if(confirm('Are you sure?')) {
    $.post("<xsl:value-of select="//link_prefix"/>account-group-delete",
    {'group_id': group_id},
    function (data){
        $("#g_"+group_id).remove();
    });
  }
}

// I think this can be deleted 2009-10-05
function not_journal_entry_amount_delete(entry_amount_id,row) {
  $.post("<xsl:value-of select="//link_prefix"/>journal-entry-amount-delete",
  {
      'entry_amount_id': entry_amount_id
  },
  function (data){
  });
  myTable = document.getElementById("entry_form_table");
  if(myTable.getElementsByTagName('tr').length > 4) {
      myTable.deleteRow(row);
  } else {
      setTimeout('window.location.reload()',200);
  }
}

function confirmFlip () {
  var flip=confirm('Are you sure?');
  if(flip)
      window.location.href= location.href + '&amp;flip=true';
  else
      return false;
}

function debits_summarize() {
  mysum = "";
  for (i=0; i &lt; document.forms[0].length; i++) {
    if(document.forms[0].elements[i].name == "debit_amount_1[]") {
        mysum = (mysum * 1) + (1 * document.forms[0].elements[i].value);
    } else if (document.forms[0].elements[i].name == "credit_amount_1[]") {
        mytarget = document.forms[0].elements[i];
    } else {
    }
  }
  mytarget.value = mysum;
}

function invoice_paid(invoice_number, entry_id) {
    $.ajax({
      type: "POST",
      url: "<xsl:value-of select="//link_prefix"/>x-invoice-paid",
      data: {
        'invoice_id': invoice_number,
        'entry_id': entry_id
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

function note_delete(note_id) {
    $.post("<xsl:value-of select="//link_prefix"/>x-note-delete",
    {
      'note_id': note_id
    },
    function (data){
      $("#n_"+note_id).remove();
    });
}

function note_archive(note_id) {
    $.post("<xsl:value-of select="//link_prefix"/>x-note-archive",
    {
      'note_id': note_id
    },
    function (data){
      $("#n_"+note_id).remove();
    });
}
function journal_entry_location(entry_id) {
  location.href = "<xsl:value-of select="//link_prefix"/>journal-entry&amp;entry_id="+entry_id;
}

function update_date_selector_account_id(account_id) {
	if (account_id == '') {
  	$('#hidden_account_id_input').remove();
	} else {
  	//$('#hidden_account_id_input').attr('value',account_id);
  	$('#dc23').val(account_id);
  }
}

$(document).ready(function() {
  $('#my_debit_amount').val($('.credit_amounts').sum());
});

  </xsl:template>
</xsl:stylesheet>
