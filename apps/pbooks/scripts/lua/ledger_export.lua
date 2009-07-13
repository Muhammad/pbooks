#!/usr/bin/lua
--[[ <!--
Program: PBooks
Component: ledger_export.lua
Copyright: Savonix Corporation
Author: Albert L. Lash, IV
License: Gnu Affero Public License version 3
http://www.gnu.org/licenses

This program is free software you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program if not, see http://www.gnu.org/licenses
or write to the Free Software Foundation, Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301 USA
--> --]]
require "luasql.mysql"
require "config"

env = assert (luasql.mysql())
con = assert (env:connect(dbconfig["database"],dbconfig["username"],dbconfig["password"],dbconfig["hostname"]))


function lpad (str, len, char)
    if char == nil then char = ' ' end
    return str .. string.rep(char, len - #str)
end

function rpad (str, len, char)
    if char == nil then char = ' ' end
    return string.rep(char, len - #str) .. str
end

function rows (connection, sql_statement)
  local cursor = assert (connection:execute (sql_statement))
  return function ()
    return cursor:fetch()
  end
end

myledger = ""
account_type = ""

myquery = [[SELECT entry_id,
    SUBSTRING(entry_datetime,1,10) as entry_datetime,
    SUBSTRING(memorandum,1,30) as memorandum
  FROM pb_entries
  WHERE entry_id!=0
    AND memorandum!='PLACEHOLDER'
    AND pb_entries.status != 9
    LIMIT 200]]

getallentries = [[SELECT 
    pb_entry_amounts.entry_amount,
    pb_accounts.name as name,
    pb_entry_amounts.memorandum as entry_amount_memorandum,
    pb_entry_amounts.entry_type_id,
    pb_accounts.account_type_id
  FROM
    (pb_entries)
  LEFT JOIN pb_entry_amounts
    ON pb_entry_amounts.entry_id=pb_entries.entry_id
  LEFT JOIN pb_accounts
    ON pb_entry_amounts.account_id=pb_accounts.id
  WHERE
    pb_entries.entry_id=]]


for entry_id,entry_datetime,memorandum in rows (con, myquery) do
-- 2007-01-02 'AUTOMATIC LOAN PAY' 
--  Expenses:Expense Account 1               		$4
--  Assets:Bank Account1                       			$-4

  myledger = myledger..entry_datetime.." '"..memorandum.."'\n"
  getentryamounts = getallentries..entry_id

  for entry_amount,account_name,entry_amount_memorandum,entry_type_id,account_type_id in rows (con, getentryamounts) do
    local myaccount = "  "..account_types[account_type_id]..":"..account_name
    myaccount = lpad(myaccount,50)
    myledger = myledger..myaccount
    if entry_type_id == "Credit" then
        myledger = myledger.."    "
        myledger = myledger.."-"..entry_amount.."\n"
    else
        myledger = myledger..entry_amount.."\n"
    end
  end
  myledger = myledger.."\n"
end
--print (string.format ("%s", myledger))
F = io.open("ledger.txt","w")
F:write(string.format ("%s", myledger))
F:close()

