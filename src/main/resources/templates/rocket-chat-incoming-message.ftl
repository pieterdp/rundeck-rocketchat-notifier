<#if executionData.job.group??>
    <#assign jobName="${executionData.job.group} / ${executionData.job.name}">
<#else>
    <#assign jobName="${executionData.job.name}">
</#if>
<#assign message="RunDeck Job Notification:">
<#if trigger == "start">
    <#assign state="Started">
<#elseif trigger == "failure">
    <#assign state="Failed">
<#else>
    <#assign state="Succeeded">
</#if>
<#assign formattedTitle="${executionData.job.name} ${state?lower_case}">

{
   "channel":"${channel}",
   "attachments":[
      {  
	 "title":"${formattedTitle}",
         "channel":"${channel}",
         "icon_emoji":":rundeck:",
         "fallback":"${state}: ${message}",
         "color":"${color}",
         "fields":[
            {
               "title":"Job Name",
               "value":"<${executionData.job.href}|${executionData.job.name}>",
               "short":true
            },
            {
               "title":"Status",
               "value":"${state}",
               "short":true
            },
            {
               "title":"Execution ID",
               "value":"<${executionData.href}|#${executionData.id}>",
               "short":true
            }
<#if trigger == "failure">
            ,{
               "title":"Failed Nodes",
               "value":"${executionData.failedNodeListString!"- (Job itself failed)"}",
               "short":false
            }
</#if>
]
      }
   ]
}
