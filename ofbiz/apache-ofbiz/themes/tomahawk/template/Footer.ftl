<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

<#assign nowTimestamp = Static["org.apache.ofbiz.base.util.UtilDateTime"].nowTimestamp()>

<div id="footer">
    <span>${nowTimestamp?datetime?string.short} - <a href="<@ofbizUrl>ListTimezones</@ofbizUrl>">${timeZone.toZoneId().getDisplayName(Static["java.time.format.TextStyle"].FULL_STANDALONE, locale)}</a></span>
    <span> ${uiLabelMap.CommonCopyright} (c)  2023-${nowTimestamp?string("yyyy")}
        <a href=""http://www.pangun.tech"" target="_blank">Pangun Technologies</a>.
        Powered By <a href="http://www.pangun.tech" class="noicon">Pangun NeoERP </a>
       
    </span>
</div>

<#if layoutSettings.VT_FTR_JAVASCRIPT?has_content>
  <#list layoutSettings.VT_FTR_JAVASCRIPT as javaScript>
    <script src="<@ofbizContentUrl>${StringUtil.wrapString(javaScript)}</@ofbizContentUrl>" type="application/javascript"></script>
  </#list>
</#if>

</div>
<@scriptTagsFooter/>
</body>
</html>
